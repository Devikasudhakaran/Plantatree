import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageUploadController {
  Future<void> uploadImage(String userId, File? captureImage) async {
    if (captureImage == null) {
      print('Invalid image path');
      return;
    }

    String extension = captureImage.path.split('.').last;
    String mimeType = 'image/$extension';

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://spinryte.in/tree/api/Project/image_upload'),
      );
      request.fields['id'] = userId;
      request.files.add(
        await http.MultipartFile.fromPath(
          'projectImage',
          captureImage.path,
          contentType: MediaType('image', extension),
        ),
      );
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while uploading image: $e');
    }
  }
}
