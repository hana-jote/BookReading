// book_list_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class Book {
  final String author;
  final String pdfName;
  final DateTime publishedDate;
  final String description;
  final String fileUrl;

  Book({
    required this.author,
    required this.pdfName,
    required this.publishedDate,
    required this.description,
    required this.fileUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      author: json['author'],
      pdfName: json['pdfName'],
      publishedDate: DateTime.parse(json['publishedDate']),
      description: json['description'],
      fileUrl: json['fileUrl'],
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    Uri fetchUrl = Uri.parse(
        "https://leadingsofa-us.backendless.app/api/data/BookDetails");

    var response = await http.get(
      fetchUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Add your Backendless user token here
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        books = data.map((json) => Book.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      throw Exception("Failed to fetch books");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book List"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Book book = books[index];
                return ListTile(
                  title: Text(book.pdfName),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewScreen(fileUrl: book.fileUrl),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PdfViewScreen extends StatelessWidget {
  final String fileUrl;

  PdfViewScreen({required this.fileUrl});

  Future<String> downloadFile(String url, String fileName) async {
    var response = await http.get(Uri.parse(url));
    var bytes = response.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View PDF"),
      ),
      body: FutureBuilder(
        future: downloadFile(fileUrl, basename(fileUrl)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return PDFView(
                filePath: snapshot.data as String,
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
