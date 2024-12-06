import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/take_an_image_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
  // ignore: unused_field
  String _deviceTemperature = '';
  var temperature = 0.0;
  String projectName = '';
  String projectDescription = '';
  String treeName = '';
  String createdAt = '';
  String profileimage = "";
  List<String> projectImages = [];
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
      return (fahrenheit + 62) *
          5 /
          9; // Format temperature to two decimal places
    }
  }

  String formatTemperature(double temperature) {
    return temperature.toStringAsFixed(0);
  }

  Future<void> _fetchProjectDetails() async {
    final response = await http.get(Uri.parse(
        'https://spinryte.in/tree/api/Project/single_view/${widget.userid}}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final data = responseData['dataList'];

      setState(() {
        projectName = "";
        projectDescription = '';
        treeName = '';
        createdAt = '';
        profileimage = '';
        projectImages.clear();

        projectName = responseData['dataList']['name'];

        projectDescription = responseData['dataList']['description'];

        treeName = responseData['dataList']['tree_name'];

        createdAt = responseData['dataList']['created_at'];

        profileimage = responseData['dataList']['image'];

        projectImages = List<String>.from(
            data['project_images'].map((image) => image['image']));

        // ignore: prefer_is_empty
        if (projectImages.length > 0) imageone = projectImages[0];
        if (projectImages.length > 1) imagetwo = projectImages[1];
        if (projectImages.length > 2) imagethree = projectImages[2];
        if (projectImages.length > 3) imagefour = projectImages[3];
      });
    } else if (response.statusCode == 401) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> register() async {
    final token = await getToken();
    // ignore: avoid_print
    print(token);

    if (widget.userid.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        treenameController.text.isNotEmpty &&
        soilcontroller.text.isNotEmpty) {
      final url =
          Uri.parse('https://spinryte.in/tree/api/Project/create_project');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization1': '$token',
        },
        body: jsonEncode(<String, String>{
          'id': widget.userid,
          'description': discriptionController.text,
          'tree_name': treenameController.text,
          'longitude': " ${_currentPosition!.longitude}",
          'latitude': " ${_currentPosition!.latitude}",
          'temperture': '${formatTemperature(temperature)} °C',
          'soil': soilcontroller.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          // ignore: avoid_print
          print('Project created successfully');
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop("refresh");
        } else {
          // ignore: avoid_print
          print('Failed to create project: ${responseData['message']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to create project. Error code: ${response.statusCode}');
        // ignore: avoid_print
        print('Error message: ${response.body}');
      }
    } else {}
  }

  Future<void> showImageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
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
                  "Changes that you made may not be saved",
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
                Navigator.of(context).pop();
                Navigator.of(context).pop("refresh");
              },
              child: const Text('Leave'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 60),
                              GestureDetector(
                                  onTap: () {
                                    showImageDialog();
                                  },
                                  child: const Icon(Icons.arrow_back_ios)),
                              const SizedBox(width: 10),
                              Text(
                                widget.projectname,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
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
                        const Text(
                          "Images",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
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
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                // ignore: non_constant_identifier_names
                                String? Refreash = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ImageTaker(
                                              userid: widget.userid,
                                            )));
                                if (Refreash == "refresh") {
                                  projectImages.clear();
                                  _fetchProjectDetails();
                                }
                              },
                              child: imageone == null
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF40cd25),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imageone!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
                                // ignore: non_constant_identifier_names
                                String? Refreash = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ImageTaker(
                                              userid: widget.userid,
                                            )));
                                if (Refreash == "refresh") {
                                  projectImages.clear();
                                  _fetchProjectDetails();
                                }
                              },
                              child: imagetwo == null
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF40cd25),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imagetwo!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
                                // ignore: non_constant_identifier_names
                                String? Refreash = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ImageTaker(
                                              userid: widget.userid,
                                            )));
                                if (Refreash == "refresh") {
                                  projectImages.clear();
                                  _fetchProjectDetails();
                                }
                              },
                              child: imagethree == null
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF40cd25),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imagethree!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
                                // ignore: non_constant_identifier_names
                                String? Refreash = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ImageTaker(
                                              userid: widget.userid,
                                            )));
                                if (Refreash == "refresh") {
                                  projectImages.clear();
                                  _fetchProjectDetails();
                                }
                              },
                              child: imagefour == null
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF40cd25),
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
                                          color: const Color(0xFF40cd25),
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
                        const Text(
                          "Tree Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
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
                            padding: const EdgeInsets.only(left: 10, right: 5),
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
                        const Text(
                          "Describe Your Tree",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
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
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: TextField(
                              controller: discriptionController,
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
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 96,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  _checkloactionpermission();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF40cd25),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.height / 17,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    _currentAddress,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
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
                          const Text(
                            "Temperture",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 96),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  _checkloactionpermission();
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF40cd25),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(
                                      Icons.sunny,
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.height / 17,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '${formatTemperature(temperature)} °C',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
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
                        const Text(
                          "Soil",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
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
                        color: const Color(0xFF40cd25),
                      ),
                      child: Center(
                          child: isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.white, size: 20)
                              : const Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )),
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
    );
  }
}
