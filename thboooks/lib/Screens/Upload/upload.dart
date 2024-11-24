import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Upload and Retrieve',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadScreen(),
    );
  }
}

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload and View PDF"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                pickFile(context);
              },
              child: Text("Pick and Upload PDF"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListScreen(),
                  ),
                );
              },
              child: Text("View Uploaded PDFs"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> pickFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'docx', 'doc'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    uploadFile(file, context);
  }
}

Future<void> uploadFile(File file, BuildContext context) async {
  String fileName = basename(file.path);
  Uri uploadUrl = Uri.parse(
      "https://leadingsofa-us.backendless.app/api/files/Books/$fileName");

  var request = http.MultipartRequest('POST', uploadUrl)
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("File uploaded successfully"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      throw Exception("Failed to upload file");
    }
  } catch (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Error uploading file: $error"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<String>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = fetchFileList();
  }

  Future<List<String>> fetchFileList() async {
    Uri listUrl =
        Uri.parse("https://leadingsofa-us.backendless.app/api/files/Books/");
    try {
      var response = await http.get(listUrl);
      if (response.statusCode == 200) {
        List<dynamic> fileList = jsonDecode(response.body);
        return fileList.map((file) => file['name'].toString()).toList();
      } else {
        throw Exception("Failed to fetch file list");
      }
    } catch (error) {
      throw Exception("Error fetching file list: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploaded PDFs"),
      ),
      body: FutureBuilder<List<String>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No files uploaded yet"));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio:
                    0.8, // Aspect ratio of each grid item (width/height)
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String fileName = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Handle onTap action
                    retrieveFile(context, fileName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.picture_as_pdf,
                            size: 30, color: Colors.red), // Smaller icon size
                        SizedBox(height: 5),
                        Text(
                          fileName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12), // Smaller text size
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<void> retrieveFile(BuildContext context, String fileName) async {
  Uri fileUrl = Uri.parse(
      "https://leadingsofa-us.backendless.app/api/files/Books/$fileName");

  try {
    var response = await http.get(fileUrl);
    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(filePath: file.path),
        ),
      );
    } else {
      throw Exception("Failed to retrieve file");
    }
  } catch (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Error retrieving file: $error"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String filePath;

  PDFViewerScreen({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View PDF"),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
