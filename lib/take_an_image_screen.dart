import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:lottie/lottie.dart';
import 'package:multipart/multipart.dart';

class ImageTaker extends StatefulWidget {
  String userid = '';
  ImageTaker({super.key, required this.userid});

  @override
  State<ImageTaker> createState() => _ImageTakerState();
}

class _ImageTakerState extends State<ImageTaker> {
  File? _captureimage;
  bool _isLoading = true;
  String _uploadStatus = '';

  Future _takePicture() async {
    final _capture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_capture == null) return;
    setState(() {
      _captureimage = File(_capture.path);
    });

    if (_captureimage != null) uploadImage();

    await Future.delayed(Duration(seconds: 8));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> uploadImage() async {
    if (_captureimage == null) {
      print('Invalid image path');
      return;
    }

    // Determine file extension
    String extension = _captureimage!.path.split('.').last;
    print(widget.userid);
    // Determine MIME type based on file extension
    String mimeType = 'image/$extension';

    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://spinryte.in/tree/api/Project/image_upload'),
    );

    // Add project ID as a field
    request.fields['id'] = widget.userid;

    // Add image file
    request.files.add(await http.MultipartFile.fromPath(
      'projectImage',
      _captureimage!.path,
      contentType: MediaType.parse(mimeType),
    ));

    // Send the request
    final response = await request.send();

    // Check the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Error: ${response.reasonPhrase}');
    }
  }

  @override
  void initState() {
    _takePicture();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _captureimage == null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: FileImage(
                                    _captureimage!,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width,
                          ),
                          if (_isLoading)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: MediaQuery.of(context).size.height / 1.25,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Lottie.asset(
                                  "asset/animation/scan_animation.json",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (_isLoading) {
                          } else {
                            Navigator.of(context).pop("refresh");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF40cd25),
                              borderRadius: BorderRadius.circular(20)),
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: _isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.white, size: 20)
                                  : Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
