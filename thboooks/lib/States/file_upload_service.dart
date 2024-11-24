import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadService {
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, String?>> uploadFiles() async {
    // Pick image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String? imageUrl;
    if (image != null) {
      File imageFile = File(image.path);
      try {
        Map response = (await Backendless.files.upload(
          imageFile,
          '/images/${imageFile.path.split('/').last}',
          overwrite: true,
        )) as Map;
        imageUrl = response['fileURL'];
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    // Pick PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf,docx,'],
    );
    String? pdfUrl;
    if (result != null) {
      File pdfFile = File(result.files.single.path!);
      try {
        Map response = (await Backendless.files.upload(
          pdfFile,
          '/pdfs/${pdfFile.path.split('/').last}',
          overwrite: true,
        )) as Map;
        pdfUrl = response['fileURL'];
      } catch (e) {
        print('Error uploading PDF: $e');
      }
    }

    return {
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
    };
  }

  Future<void> saveData(String author, String description,
      DateTime publishedDate, Map<String, String?> fileUrls) async {
    Map<String, dynamic> data = {
      'author': author,
      'description': description,
      'publishedDate': publishedDate.toIso8601String(),
      'imageUrl': fileUrls['imageUrl'],
      'pdfUrl': fileUrls['pdfUrl'],
    };

    try {
      await Backendless.data.of('YourTableName').save(data);
      print('Data saved successfully');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
