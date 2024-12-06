import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/Bannercard.dart';
import 'package:plantatree/notification_screen.dart';
import 'package:plantatree/project_add_screen_project_one.dart';
import 'package:plantatree/project_card2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plantatree/project_single_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = '';
  String name = '';
  String image = '';
  String bannerimage = '';
  List<dynamic> dataList = [];
  List<dynamic> bannerList = [];

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Project/homepage'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      dataList.clear();
      bannerList.clear();
      setState(() {
        dataList = responseData['dataList'];
        bannerList = responseData['banner'];
      });
      final jsonResponse = json.decode(response.body);
      setState(() {
        id = jsonResponse['dataList']['id'];
        name = jsonResponse['dataList']['name'];
        image = jsonResponse['dataList']['image'];
        bannerimage = jsonResponse['banner']['image'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false; 
      },child:  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "asset/flash_screen/payment.png",
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.notifications,
                                size: 20,
                                color: Color.fromARGB(255, 32, 128, 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: bannerList.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Bannercard(
                            imageUrl: bannerList[index]["image"],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.linearToEaseOut,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 700),
                        viewportFraction: 1.0,
                      ),
                    ),
                    if (bannerList.isEmpty)
                      Container(
                          color: const Color.fromARGB(255, 236, 250, 238),
                          height: MediaQuery.of(context).size.height / 3,
                          child: Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.green, size: 40))),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Projects",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF071305)),
                  ),
                ),
                dataList.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: GestureDetector(
                          onTap: () async {
                            String? Refreash = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) =>
                                  const CreateProjectPageOne(),
                            ));
                            if (Refreash == "refresh") {
                              fetchData();
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ProjectCardsIcon(
                                Name: "Add New Project",
                              )),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          itemCount:
                              dataList.length > 4 ? 4 : dataList.length - 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SingleViewProjectScreen(
                                    projectId: dataList[index]["id"],
                                  ),
                                ));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ProjectCards(
                                      imageUrl: dataList[index]["image"],
                                      Name: dataList[index]["name"])),
                            );
                          },
                        ),
                      ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
          ],
        ),
      ),
    )
  );
  }
}
