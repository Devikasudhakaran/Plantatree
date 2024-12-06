import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
import 'package:flutter_sensors/flutter_sensors.dart';

class ProjectUpdate extends StatefulWidget {
  String userid = '';
  String projectname = '';
  ProjectUpdate({Key? key, required this.userid, required this.projectname})
      : super(key: key);

  @override
  State<ProjectUpdate> createState() => _ProjectUpdateState();
}

class _ProjectUpdateState extends State<ProjectUpdate> {
  File? _captureimage;
  MapController mapController = MapController();
  Position? _currentPosition;
  String _currentAddress = '';
  TextEditingController ProjectnameController = TextEditingController();
  TextEditingController treenameController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController soilcontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

    // TODO: implement initState
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
    return temperature
        .toStringAsFixed(0); // Format temperature to two decimal places
  }

  Future<void> _fetchProjectDetails() async {
    print("befor api calling :");
    print(widget.userid);

    final response = await http.get(Uri.parse(
        'https://spinryte.in/tree/api/Project/single_view/${widget.userid}}'));

    if (response.statusCode == 200) {
      print("befor api calling : one ................");
      final Map<String, dynamic> responseData = json.decode(response.body);
      final data = responseData['dataList'];
      print("befor api calling : two ................");

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
        print("befor api calling : four ................");

        if (projectImages.length > 0) imageone = projectImages[0];
        if (projectImages.length > 1) imagetwo = projectImages[1];
        if (projectImages.length > 2) imagethree = projectImages[2];
        if (projectImages.length > 3) imagefour = projectImages[3];
        print("befor api calling : four ................");

        print("ooooooooooooooooooooooooooooooo");
        print(projectName);
        print(profileimage);
        print(projectImages = List<String>.from(
            data['project_images'].map((image) => image['image'])));
      });
      print("befor api calling : three ................");
    } else if (response.statusCode == 401) {
      setState(() {
        isLoading = false;
      });
      // // Unauthorized - invalid credentials
      // print('Invalid username or password');
      // // Inform the user about invalid credentials, e.g., show a snackbar
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Center(child: Text('Invalid username or password')),
      // ));
    } else {
      setState(() {
        isLoading = false;
      });
      // // Other errors, handle accordingly
      // print('Login failed with status code ${response.statusCode}');
      // // Inform the user about the error, e.g., show a snackbar
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Center(child: Text('Login failed. Please try again later.')),
      // ));
    }
  }

  Future<void> _getDeviceTemperature() async {
    print("sreaching for temp>>>>>>>>>>");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _deviceTemperature = 'Mock Temperature: ${androidInfo.device}';
    });
    print("here is yor temperature ..................................");
    print(_deviceTemperature);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _checkloactionpermission() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      print("not enbaled");
    }
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();
    LocationPermission serveperm = await Geolocator.checkPermission();
    print("_checkloactionpermission is working ");
    if (serveperm == LocationPermission.denied) {
      print("permission denied");
      serveperm = await Geolocator.requestPermission();
    } else {
      getcurrentlocation();
      print("checking....");
    }
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
              child: Text('Leave'),
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

  void getcurrentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("getcurrentlocation is working ");
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    print("_getAddressFromLatLng is working ");
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark placemark = placemarks[0];
      print(_currentPosition!.latitude);
      print(_currentPosition!.longitude);
      setState(() {
        _currentAddress = "${placemark.locality}, ${placemark.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> register() async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(discriptionController.text);
    print(treenameController.text);
    print("location Here:");
    print(_currentAddress);
    print(_currentPosition!.longitude);
    print(_currentPosition!.latitude);

    final token = await getToken();
    print(token);

    if (widget.userid.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        treenameController.text.isNotEmpty &&
        soilcontroller.text.isNotEmpty) {
      final url =
          Uri.parse('https://spinryte.in/tree/api/Project/update_project');
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
          'temperture': "${'${formatTemperature(temperature)} °C'}",
          'soil': soilcontroller.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          print('Project updated successfully');

          Navigator.of(context).pop("refresh");
        } else {
          // Handle failure
          print('Failed to update project: ${responseData['message']}');
        }
      } else {
        // Handle error
        print('Failed to update project. Error code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3),
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
                              SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    showImageDialog();
                                  },
                                  child: Icon(Icons.arrow_back_ios)),
                              SizedBox(width: 10),
                              Text(
                                widget.projectname,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
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
                    height: 20,
                  ),

                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Images",
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
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
                                String? Refreash = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ImageTaker(
                                              userid: widget.userid,
                                            )));
                                if (Refreash == "refresh") {
                                  projectImages.clear();
                                  _fetchProjectDetails();
                                  print(
                                      "refreash is working perfectly .......................");
                                }
                              },
                              child: imageone == null
                                  ? Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF40cd25),
                                      ),
                                      child: Icon(
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
                                          color: Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imageone!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
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
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF40cd25),
                                      ),
                                      child: Icon(
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
                                          color: Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imagetwo!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
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
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF40cd25),
                                      ),
                                      child: Icon(
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
                                          color: Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(imagethree!),
                                              fit: BoxFit.cover)),
                                    )),
                          GestureDetector(
                              onTap: () async {
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
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF40cd25),
                                      ),
                                      child: Icon(
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
                                          color: Color(0xFF40cd25),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                imagefour!,
                                              ),
                                              fit: BoxFit.cover)),
                                    )),
                        ],
                      )),

                  SizedBox(height: 20),

                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Tree Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                        ),
                        SizedBox(height: 5),
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

                  SizedBox(height: 20),

                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Describe Your Tree",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                        ),
                        SizedBox(height: 5),
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

                  //                  SizedBox(height: 20),

                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 30,right: 30),
                  //                   child: SizedBox(
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(
                  //                           "  Location",
                  //                           style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Color(0xFF071305),
                  //                           ),
                  //                         ),
                  //                          SizedBox(height: 5),
                  //                         Row(
                  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                           children: [

                  //                              GestureDetector(
                  //                               onTap:() async{
                  //                                 _checkloactionpermission();
                  //                                 print("onclick");
                  //                               },
                  //                                child: Container(
                  //                                 width: 50,
                  //                                 height: MediaQuery.of(context).size.height / 17,
                  //                                 decoration: BoxDecoration(
                  //                                   color: Color(0xFF40cd25),
                  //                                   borderRadius: BorderRadius.circular(20),
                  //                                 ),
                  //                                 child: Icon(Icons.location_on,color: Colors.white,)
                  //                                                              ),
                  //                              ),

                  //                             Container(
                  //                               width: MediaQuery.of(context).size.width / 1.5,
                  //                               height: MediaQuery.of(context).size.height / 17,
                  //                               decoration: BoxDecoration(
                  //                                 color: Colors.white,
                  //                                 borderRadius: BorderRadius.circular(20),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Text(_currentAddress,style:TextStyle(
                  //                                   fontSize: 16,
                  //                                 ),),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),

                  // SizedBox(height: 20),

                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 30,right: 30),
                  //                   child: SizedBox(
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(
                  //                           "  Temperture",
                  //                           style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Color(0xFF071305),
                  //                           ),
                  //                         ),
                  //                          SizedBox(height: 5),
                  //                         Row(
                  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                           children: [

                  //                              GestureDetector(
                  //                               onTap:() async{
                  //                                 _checkloactionpermission();
                  //                                 print("onclick");
                  //                               },
                  //                                child: Container(
                  //                                 width: 50,
                  //                                 height: MediaQuery.of(context).size.height / 17,
                  //                                 decoration: BoxDecoration(
                  //                                   color: Color(0xFF40cd25),
                  //                                   borderRadius: BorderRadius.circular(20),
                  //                                 ),
                  //                                 child: Icon(Icons.sunny,color: Colors.white,)
                  //                                                              ),
                  //                              ),

                  //                             Container(
                  //                               width: MediaQuery.of(context).size.width / 1.5,
                  //                               height: MediaQuery.of(context).size.height / 17,
                  //                               decoration: BoxDecoration(
                  //                                 color: Colors.white,
                  //                                 borderRadius: BorderRadius.circular(20),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Text( '${formatTemperature(temperature)} °C',style:TextStyle(
                  //                                   fontSize: 16,
                  //                                 ),),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),

                  SizedBox(height: 20),

                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Soil",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                        ),
                        SizedBox(height: 5),
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

                  SizedBox(height: 20),

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
                            color: Colors.grey
                                .withOpacity(0.2), // Color of the shadow
                            spreadRadius: 3, // Spread radius
                            blurRadius: 3, // Blur radius
                            offset: Offset(0, 3), // Offset from the container
                          ),
                        ],
                        color: Color(0xFF40cd25),
                      ),
                      child: Center(
                          child: isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.white, size: 20)
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
