import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/new_project_detail_page/new_project_detail_fetch_model.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/controller/project_single_screen_controller.dart';
import 'package:plantatree/model/project_single_screen_delete_project_model.dart';
import 'package:plantatree/model/project_single_screen_fetch_model.dart';
import 'package:plantatree/widget/profile_image_carousel.dart';
import 'package:plantatree/widget/single_project_update.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class SingleViewProjectScreen extends StatefulWidget {
  final String projectId;
  const SingleViewProjectScreen({super.key, required this.projectId});

  @override
  State<SingleViewProjectScreen> createState() =>
      _SingleViewProjectScreenState();
}

class _SingleViewProjectScreenState extends State<SingleViewProjectScreen> {
  String projectName = '';
  String projectDescription = '';
  String treeName = '';
  String createdAt = '';
  String status = '';
  String projectimagesid = "";
  String profileimage = "";
  String soildname = "";
  int currentIndex = 0;
  List<ProjectImage> dataLists = [];
  ProjectSingleScreenController projectSingleScreenController =
      ProjectSingleScreenController();

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
                const SizedBox(
                  height: 30,
                ),
                Image.network(imageUrl),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: GoogleFont(text: 'Close'),
            ),
            TextButton(
              onPressed: () async {
                // Call API to delete the image based on its ID
                try {
                  final response = await http.post(
                    Uri.parse(
                        'https://spinryte.in/tree/api/Project/remove_image'),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode({"id": imageId}),
                  );
                  if (response.statusCode == 200) {
                    // Image deleted successfully, do something
                    // For example, you can refresh the UI or show a message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                            child: GoogleFont(
                                text: 'Image deleted successfully'))));
                    fetchProjectData(widget.projectId.toString());
                  } else {
                    throw Exception('Failed to delete image');
                  }
                } catch (e) {
                  // Handle error
                  print('Error deleting image: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Center(
                            child: GoogleFont(text: 'Failed to delete image'))),
                  );
                }
                Navigator.of(context).pop();
              },
              child: GoogleFont(text: 'Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProject() async {
    final user = ProjectSingleScreenDeleteProjectModel(id: widget.projectId);
    projectSingleScreenController.deleteProject(context, user);
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
                GoogleFont(
                  text: "WARRING !!",
                  fontSize: 20,
                ),
                SizedBox(height: 10),
                GoogleFont(
                  text: "Are Your Sure, You Want To Delete This Project ?",
                  textAlign: TextAlign.center,
                  fontSize: 18,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deleteProject();
              },
              child: GoogleFont(text: 'Delete'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: GoogleFont(text: 'Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to fetch project data
  Future fetchProjectData(String projectId) async {
    final details = await projectSingleScreenController
        .fetchProjectDetails(int.parse(widget.projectId));
    if (details != null && details.dataList != null) {
      setState(() {
        dataLists = details.dataList.projectImages;
        treeName = details.dataList.name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProjectData(widget.projectId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   height: 60,
      //   width: 100,
      //   child: FloatingActionButton(
      //       onPressed: (() async {
      //         String? Refreash =
      //             await Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => ProjectUpdate(
      //             userid: widget.projectId,
      //             projectname: projectName,
      //             soilname: soildname,
      //             treename: treeName,
      //             discription: projectDescription,
      //           ),
      //         ));
      //         if (Refreash == "refresh") {
      //           fetchProjectData(widget.projectId);
      //         }
      //       }),
      //       backgroundColor: Color(0xFF497a39),
      //       child: Text(
      //         "Edit",
      //         style: TextStyle(color: Colors.white, fontSize: 16),
      //       )),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: Stack(children: [
                    dataLists.isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                            )),
                            child: Loadingwidget(
                                color: const Color(0xFF497a39), size: 40))
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                            )),
                            child: CarouselSlider.builder(
                              itemCount: dataLists.length,
                              itemBuilder: (context, index, realIndex) {
                                return GestureDetector(
                                    onTap: () {
                                      showImageDialog(
                                          context,
                                          dataLists[index].image,
                                          dataLists[index].id);
                                    },
                                    child: profileimagecarousel(
                                      imageUrl: dataLists[index].image,
                                      imageId: dataLists[index].id,
                                    ));
                              },
                              options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.linearToEaseOut,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 700),
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  }),
                            ),
                          ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop("refresh");
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                  ),
                                )),
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
                                  child: const Center(
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
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: currentIndex,
                                  count: dataLists.length,
                                  effect: WormEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    activeDotColor: Colors.blue,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: GoogleFont(
                                    text: treeName,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF071305)),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                child: GoogleFont(
                                    text: "Date : $createdAt",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 100, 101, 100)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: GoogleFont(
                                  text: projectDescription,
                                  textAlign: TextAlign.justify,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF071305),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GoogleFont(
                        text: "Six Months",
                        fontSize: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleProjectUpdate(
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
