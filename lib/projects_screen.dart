import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/project_add_screen_project_one.dart';
import 'package:plantatree/notification_screen.dart';
import 'package:plantatree/project_card.dart';
import 'package:plantatree/project_single_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<Map<String, String>> dataList = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchData();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchData() async {
    final token = await getToken();
    print("token + ${token}");
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Project/projectList'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == true) {
        setState(() {
          // Adjust the parsing to handle dynamic types
          dataList = (jsonResponse['dataList'] as List<dynamic>).map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
              'image': item['image'].toString(),
            };
          }).toList();
        });
      } else {
        print('Error: ${jsonResponse['message']}');
      }
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false; 
      },child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (() async {
            String? Refreash =
                await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateProjectPageOne(),
            ));
            if (Refreash == "refresh") {
              dataList.clear();
              fetchData();
            }
          }),
          backgroundColor: Color(0xFF40cd25),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Color of the shadow
                    spreadRadius: 3, // Spread radius
                    blurRadius: 3, // Blur radius
                    offset: Offset(0, 3), // Offset from the container
                  ),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                        bottom: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            foregroundImage:
                                AssetImage("asset/flash_screen/payment.png"),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ));
                              },
                              child: Icon(
                                Icons.notifications,
                                color: Color.fromARGB(255, 32, 128, 12),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (dataList.isEmpty)
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.green, size: 40)
                        ],
                      )),
                ),
              Column(
                children: [
                  // if (dataList.isEmpty)
                  //   Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       color: Colors.transparent,
                  //       height: MediaQuery.of(context).size.height / 1.2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "Add New Project",
                  //             style: TextStyle(
                  //                 color: Color.fromARGB(255, 16, 42, 11),
                  //                 fontSize: 17),
                  //           ),
                  //         ],
                  //       )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: dataList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final project = dataList[index];
                                return GestureDetector(
                                  onTap: () async {
                                    String? Refreash =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SingleViewProjectScreen(
                                        projectId: project['id'].toString(),
                                      ),
                                    ));
                                    print(Refreash);

                                    if (Refreash == "refresh") {
                                      setState(() {
                                        dataList = [];
                                      });
                                      dataList.clear();
                                      fetchData();
                                    }
                                  },
                                  child: ProjectCard(
                                      imageURL: project['image'],
                                      Name: project['name']),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
