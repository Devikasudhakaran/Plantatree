import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/profile_image_carousel.dart';
import 'package:plantatree/project_update_screen.dart';

class SingleViewProjectScreen extends StatefulWidget {
  final String projectId;
  SingleViewProjectScreen({super.key, required this.projectId});

  @override
  State<SingleViewProjectScreen> createState() =>
      _SingleViewProjectScreenState();
}

class _SingleViewProjectScreenState extends State<SingleViewProjectScreen> {
  String projectName = '';
  String projectDescription = '';
  String treeName = '';
  String createdAt = '';
  String profileimage = "";
  String projectimagesid = "";
  List<String> projectImages = [];
  List<String> projectImagesId = [];

  Future<void> showImageDialog(
      BuildContext context, String imageUrl, String imageId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Image.network(imageUrl),
                // SizedBox(height: 10),
                // Text('Image ID: $imageId'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                // Call API to delete the image based on its ID
                try {
                  final response = await http.post(
                    Uri.parse(
                        'https://spinryte.in/tree/api/Project/remove_image'),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode({"id": "${imageId}"}),
                  );
                  if (response.statusCode == 200) {
                    // Image deleted successfully, do something
                    // For example, you can refresh the UI or show a message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Center(child: Text('Image deleted successfully'))));
                    fetchProjectData(widget.projectId.toString());
                  } else {
                    throw Exception('Failed to delete image');
                  }
                } catch (e) {
                  // Handle error
                  print('Error deleting image: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Center(child: Text('Failed to delete image'))),
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProject() async {
    try {
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Project/project_delete'),
        body: jsonEncode({"id": "${widget.projectId}"}),
      );
      if (response.statusCode == 200) {
        // Image deleted successfully, do something
        // For example, you can refresh the UI or show a message
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Center(child: Text('Your Project Deleted')))
        // );
        Navigator.of(context).pop("refresh");
        Navigator.of(context).pop("refresh");
      } else {
        throw Exception('Failed to Delete Your Project');
      }
    } catch (e) {
      // Handle error
      print('Error Deleteing Project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Failed to Delete Project'))),
      );
    }
  }

  Future<void> showWarringDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "WARRING !!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Are Your Sure, You Want To Delete This Project ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )

                // SizedBox(height: 10),
                // Text('Image ID: $imageId'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deleteProject();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to fetch project data
  Future<void> fetchProjectData(String projectId) async {
    print("befor api calling :");
    print(projectId);

    final response = await http.get(Uri.parse(
        'https://spinryte.in/tree/api/Project/single_view/${projectId}}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final data = responseData['dataList'];
      setState(() {
        projectName = responseData['dataList']['name'];
        projectDescription = responseData['dataList']['description'];
        treeName = responseData['dataList']['tree_name'];
        createdAt = responseData['dataList']['created_at'];
        profileimage = responseData['dataList']['image'];
        projectImages = List<String>.from(
            data['project_images'].map((image) => image['image']));
        projectImagesId =
            List<String>.from(data['project_images'].map((id) => id['id']));

        // projectImages = List<String>.from(data['project_images'].map((image) => image['image']));

        print("ooooooooooooooooooooooooooooooo");
        print(projectName);
        print(projectId);
        print(profileimage);
        print(projectImages = List<String>.from(
            data['project_images'].map((image) => image['image'])));
      });
    } else {
      throw Exception('Failed to load project data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProjectData(widget.projectId.toString());
  }

  @override
  Widget build(BuildContext context) {
    print("lost images here.............................");
    print(projectImages);
    return Scaffold(
      floatingActionButton: Container(
        height: 60,
        width: 100,
        child: FloatingActionButton(
            onPressed: (() async {
              String? Refreash =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProjectUpdate(
                  userid: widget.projectId,
                  projectname: projectName,
                ),
              ));
              if (Refreash == "refresh") {
                fetchProjectData(widget.projectId);
              }
            }),
            backgroundColor: Color(0xFF40cd25),
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(children: [
              projectImages.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: LoadingAnimationWidget.fourRotatingDots(
                          color: const Color.fromARGB(255, 115, 230, 119),
                          size: 40),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: CarouselSlider.builder(
                        itemCount: projectImages.length,
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                              onTap: () {
                                showImageDialog(context, projectImages[index],
                                    projectImagesId[index]);
                              },
                              child: profileimagecarousel(
                                imageUrl: projectImages[index],
                                imageId: projectImagesId[index],
                              ));
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 2,
                          autoPlay: true,
                          autoPlayCurve: Curves.linearToEaseOut,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 700),
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop("refresh");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showWarringDialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(
                              Icons.delete,
                              size: 20,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    treeName,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF071305)),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  child: Text(
                    "Date : ${createdAt}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 100, 101, 100)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    projectDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF071305)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
