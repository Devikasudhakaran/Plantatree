import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/widget/alert_message.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/small_project_card.dart';
import 'package:plantatree/widget/Bannercard.dart';
import 'package:plantatree/widget/project_card2.dart';

import 'package:plantatree/view/donation_screen.dart';
import 'package:plantatree/controller/home_screen_controller.dart';
import 'package:plantatree/model/home_fetch_model.dart';
import 'package:plantatree/model/project_delete_model.dart';
import 'package:plantatree/view/new_project.dart';
import 'package:plantatree/view/notification_screen.dart';
import 'package:plantatree/view/project_single_screen.dart';
import 'package:plantatree/widget/walletlist.dart';

import 'package:plantatree/widget/project_card.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataList> dataList = [];
  List<HomeBanner> bannerList = [];
  bool switchpage = false;
  HomeScreenController homeScreenController = HomeScreenController();

  Future deleteProject(String id) async {
    final user = ProjectDeleteModel(id: id);
    try {
      final statuscode =
          await homeScreenController.deleteProject(context, user);
      fetchData();
    } catch (e) {
      print('Error Deleteing Project: $e');
    }
  }

  Future fetchData() async {
    dataList.clear();
    final statuscode = await homeScreenController.fetchData();
    setState(() {
      dataList = statuscode!.dataList;
      bannerList = statuscode.banner;
    });
  }

  Future<void> showWarringDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                GoogleFont(
                  text: "Rejected",
                  fontSize: 20,
                ),
                const SizedBox(height: 10),
                GoogleFont(
                  text:
                      "This project has been rejected by the admin for not meeting the basic guidelines. Please\n remove it.",
                  textAlign: TextAlign.center,
                  fontSize: 18,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deleteProject(id);
                Navigator.of(context).pop("refresh");
              },
              child: GoogleFont(text: 'Delete'),
            ),
          ],
        );
      },
    );
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
        },
        child: Scaffold(
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
                              "asset/flash_screen/plantatree.png",
                            ),
                            fit: BoxFit.contain),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.green.shade300,
                        //     spreadRadius: 5, // Spread radius
                        //     blurRadius: 6, // Blur radius
                        //     offset:
                        //         const Offset(0, 3), // Offset from the container
                        //   )
                        // ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          // bottomRight: Radius.circular(10)
                        )),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 65,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            GoogleFont(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                text:
                                    "' Trees are poems \n that the earth writes \n upon the sky ' "),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen(),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.notifications,
                                    size: 20, color: Color(0xFF497a39)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bannerList.isEmpty
                        ? Container(
                            color: const Color.fromARGB(255, 236, 250, 238),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            child: Center(
                                child: Loadingwidget(
                                    color: const Color(0xFF497a39), size: 40)))
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            child: CarouselSlider.builder(
                              itemCount: bannerList.length,
                              itemBuilder: (context, index, realIndex) {
                                final banners = bannerList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const DonationScreen(),
                                      ));
                                    },
                                    child: Bannercard(
                                      imageUrl: banners.image,
                                    ),
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
                          ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (switchpage == false) {
                              setState(() {
                                switchpage = false;
                              });
                            } else {
                              setState(() {
                                switchpage = false;
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: switchpage
                                  ? const Color(0xFF497a39)
                                  : const Color.fromARGB(255, 106, 171, 108),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15, right: 15),
                              child: Center(
                                child: GoogleFont(
                                    text: "Wallet",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            fetchData();
                            if (switchpage == true) {
                              setState(() {
                                switchpage = true;
                              });
                            } else {
                              setState(() {
                                switchpage = true;
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: switchpage
                                  ? const Color.fromARGB(255, 106, 171, 108)
                                  : const Color(0xFF497a39),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15, right: 15),
                              child: Center(
                                child: GoogleFont(
                                    text: "Projects",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    switchpage
                        ? const Column()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF0e9215),
                                        Color(0xFF9af881),
                                      ],
                                      // begin: Alignment.bottomLeft,
                                      // end: Alignment.topRight,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GoogleFont(
                                                  text: "Hello, Akhil",
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              GoogleFont(
                                                  text: "Total balance",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      height: 15,
                                                      width: 15,
                                                      child: Image.asset(
                                                        "asset/icons/25473.png",
                                                        color: Colors.white,
                                                      )),
                                                  GoogleFont(
                                                      text: " 2000",
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 60,
                                                backgroundColor: Colors.white,
                                                // foregroundImage:AssetImage("asset/flash_screen/payment.png"),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Column(
                      children: [
                        switchpage
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.4,
                                child: SingleChildScrollView(
                                  child: dataList.isEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    String? Refreash =
                                                        await Navigator.of(
                                                                context)
                                                            .push(
                                                                MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CreateProjectPageOne(),
                                                    ));
                                                    if (Refreash == "refresh") {
                                                      fetchData();
                                                    }
                                                  },
                                                  child: ProjectCardsIcon(
                                                    Name: "Add New Project",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 1,
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25, right: 15),
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: dataList.length > 6
                                                      ? 6
                                                      : dataList.length - 0,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final project =
                                                        dataList[index];
                                                    print(project.name);
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        if (project.status ==
                                                            "2") {
                                                          return Altermessage
                                                              .showCustomDialog(
                                                            onConfirmed: () {
                                                              deleteProject(
                                                                  project.id);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      "refresh");
                                                            },
                                                            title: "Rejected",
                                                            message:
                                                                "This project has been rejected by the admin for not meeting the basic guidelines. Please remove it.",
                                                            confirmnavi: 1,
                                                            cannelbutton:
                                                                "Cancel",
                                                            confirmbutton:
                                                                "Delete",
                                                            context: context,
                                                            cannelnavi: 0,
                                                            onCannel: () {},
                                                          );
                                                        } else {
                                                          String? Refreash =
                                                              await Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      MaterialPageRoute(
                                                            builder: (context) =>
                                                                SingleViewProjectScreen(
                                                              projectId:
                                                                  project.id,
                                                            ),
                                                          ));
                                                          print(Refreash);

                                                          if (Refreash ==
                                                              "refresh") {
                                                            fetchData();
                                                          }
                                                        }
                                                      },
                                                      child: SmallProjectCard(
                                                        imageURL: project.image
                                                            .toString(),
                                                        Name: project.name
                                                            .toString(),
                                                        status: project.status,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFf8f8f8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GoogleFont(
                                                    text: "History",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF071305)),
                                                GoogleFont(
                                                    text: "See all",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF071305)),
                                              ],
                                            ),
                                            SizedBox(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return const Walletlist();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
              ],
            ),
          ),
        ));
  }
}
