import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import '../model/new_project_detail_page/new_project_detail_fetch_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:plantatree/controller/new_project_detail_page/new_project_detail_controller.dart';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_delete_model.dart';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_register_model.dart';
import 'package:plantatree/view/take_an_image_screen.dart';
import 'package:sensors/sensors.dart';

class CreateProject extends StatefulWidget {
  String userid = '';
  String projectname = '';
  CreateProject({super.key, required this.userid, required this.projectname});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  // ignore: unused_field
  File? _captureimage;
  MapController mapController = MapController();
  Position? _currentPosition;
  String _currentAddress = '';
  // ignore: non_constant_identifier_names
  TextEditingController ProjectnameController = TextEditingController();
  TextEditingController treenameController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController soilcontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  NewProjectDetailController newProjectDetailController =
      NewProjectDetailController();
  // ignore: unused_field
  String _deviceTemperature = '';
  var temperature = 0.0;
  // String projectName = '';
  // String projectDescription = '';
  // String treeName = '';
  // String createdAt = '';
  // String profileimage = "";
  List<ProjectImage> projectImages = [];
  String? imageone;
  String? imagetwo;
  String? imagethree;
  String? imagefour;
  bool isLoading = false;
  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    _checkloactionpermission();
    _getDeviceTemperature();

    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        temperature = convertFahrenheitToCelsius(event.y);
      });
      _streamSubscription?.cancel();
    });

    super.initState();
  }

  double convertFahrenheitToCelsius(double fahrenheit) {
    if (temperature < 0) {
      // If negative, return the temperature as a string with the sign
      return (fahrenheit - 32) *
          5 /
          9; // Format temperature to two decimal places
    } else {
      // If positive or zero, return the temperature as a string without the sign
      return (fahrenheit + 50) *
          5 /
          9; // Format temperature to two decimal places
    }
  }

  String formatTemperature(double temperature) {
    return temperature.toStringAsFixed(0);
  }

  Future fetchProjectDetails() async {
    projectImages.clear();

    final details = await newProjectDetailController
        .fetchProjectDetails(int.parse(widget.userid));

    if (details != null && details.dataList != null) {
      setState(() {
        projectImages = details.dataList.projectImages;
      });
    }

    print("chek here for details ------------------");
    print(details);
    print(projectImages);
    if (details != null) {
      setState(() {
        print("chek here for images ------------------");
        print(projectImages[0].image.toString());
        imageone = projectImages[0].image.toString();
        imagetwo = projectImages[1].image.toString();
        imagethree = projectImages[2].image.toString();
        imagefour = projectImages[3].image.toString();
      });
    }
  }

  Future<void> _getDeviceTemperature() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _deviceTemperature = 'Mock Temperature: ${androidInfo.device}';
    });
  }

  void _checkloactionpermission() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      // ignore: avoid_print
      print("not enbaled");
    }
// ignore: unused_local_variable
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();
    LocationPermission serveperm = await Geolocator.checkPermission();

    if (serveperm == LocationPermission.denied) {
      // ignore: avoid_print
      print("permission denied");
      serveperm = await Geolocator.requestPermission();
    } else {
      getcurrentlocation();
    }
  }

  void getcurrentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      print("current position -------------------");
      print(_currentPosition?.altitude.toString());
      print(_currentPosition?.longitude.toString());
    });
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark placemark = placemarks[0];

      setState(() {
        _currentAddress = "${placemark.locality}, ${placemark.country}";
        print("address here check it out ___________________");
        print(_currentAddress);
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> register() async {
    if (widget.userid.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        projectImages.isNotEmpty &&
        treenameController.text.isNotEmpty &&
        soilcontroller.text.isNotEmpty) {
      final user = NewProjectDetailRegisterModel(
        id: widget.userid,
        description: discriptionController.text,
        latitude: _currentPosition!.latitude.toString(),
        treeName: treenameController.text,
        longitude: _currentPosition!.longitude.toString(),
        temperture: formatTemperature(temperature),
        soil: soilcontroller.text,
      );
      try {
        await newProjectDetailController.register(user, context);
      } catch (e) {
        print('Error Deleteing Project: $e');
      }
    }
  }

  Future<void> deleteProject() async {
    final user = NewProjectDetailDeleteModel(id: widget.userid);

    await newProjectDetailController.deleteProject(context, user);
  }

  Future<void> showImageDialog() async {
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
                  text: "Changes that you made may not be saved",
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
              child: GoogleFont(text: 'Leave'),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showImageDialog();
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          60),
                                  GestureDetector(
                                      onTap: () {
                                        showImageDialog();
                                      },
                                      child: const Icon(Icons.arrow_back_ios)),
                                  const SizedBox(width: 10),
                                  GoogleFont(
                                    text: widget.projectname,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            const CircleAvatar(
                              foregroundImage:
                                  AssetImage("asset/flash_screen/payment.png"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoogleFont(
                              text: "Images",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, right: 5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    // ignore: non_constant_identifier_names
                                    String? Refreash = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ImageTaker(
                                                  userid: widget.userid,
                                                )));
                                    fetchProjectDetails();
                                    print("not working *****************");
                                    if (Refreash == "refresh") {
                                      fetchProjectDetails();
                                    }
                                  },
                                  child: imageone == null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFF497a39),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFF497a39),
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(imageone!),
                                                  fit: BoxFit.cover)),
                                        )),
                              GestureDetector(
                                  onTap: () async {
                                    // ignore: non_constant_identifier_names
                                    String? Refreash = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ImageTaker(
                                                  userid: widget.userid,
                                                )));

                                    print("not working *****************");
                                    if (Refreash == "refresh") {
                                      print("not working *****************");
                                      projectImages.clear();
                                      fetchProjectDetails();
                                    }
                                  },
                                  child: imagetwo == null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFF497a39),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFF497a39),
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(imagetwo!),
                                                  fit: BoxFit.cover)),
                                        )),
                              GestureDetector(
                                  onTap: () async {
                                    // ignore: non_constant_identifier_names
                                    String? Refreash = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ImageTaker(
                                                  userid: widget.userid,
                                                )));
                                    if (Refreash == "refresh") {
                                      projectImages.clear();
                                      fetchProjectDetails();
                                    }
                                  },
                                  child: imagethree == null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFF497a39),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFF497a39),
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(imagethree!),
                                                  fit: BoxFit.cover)),
                                        )),
                              GestureDetector(
                                  onTap: () async {
                                    // ignore: non_constant_identifier_names
                                    String? Refreash = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ImageTaker(
                                                  userid: widget.userid,
                                                )));
                                    if (Refreash == "refresh") {
                                      projectImages.clear();
                                      fetchProjectDetails();
                                    }
                                  },
                                  child: imagefour == null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFF497a39),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFF497a39),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    imagefour!,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        )),
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoogleFont(
                              text: "Tree Name",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 96,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 17,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: TextField(
                                  controller: treenameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoogleFont(
                              text: "Describe Your Tree",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 96,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 20,
                                  controller: discriptionController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GoogleFont(
                                text: "Location",
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 96,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      _checkloactionpermission();
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                17,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF497a39),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: GoogleFont(
                                        text: _currentAddress,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GoogleFont(
                                text: "Temperture",
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 96),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      _checkloactionpermission();
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                17,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF497a39),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.sunny,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: GoogleFont(
                                        text:
                                            '${formatTemperature(temperature)} °C',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoogleFont(
                              text: "Soil",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 96),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 17,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: TextField(
                                  controller: soilcontroller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          register();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: const Color(0xFF497a39),
                          ),
                          child: Center(
                              child: isLoading
                                  ? Loadingwidget(color: Colors.white, size: 20)
                                  : GoogleFont(
                                      text: "Submit",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
