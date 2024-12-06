import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:plantatree/controller/otp_verification_controller.dart';
import 'package:plantatree/model/otp_verification_model.dart';
import 'package:plantatree/widget/button_widget.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ForgottenOtp extends StatefulWidget {
  ForgottenOtp({super.key, required this.email, required this.otp});
  String? email;
  int? otp;

  @override
  State<ForgottenOtp> createState() => _ForgottenOtpState();
}

class _ForgottenOtpState extends State<ForgottenOtp> {
  bool isLoading = false;
  String? typeotp;
  bool resentaotp = false;
  OtpVerificationController otpVerificationController =
      OtpVerificationController();

  Future otpverifiaction() async {
    final user = OtpVerificationModel(otp: typeotp.toString());

    final top = otpVerificationController.otpverifiaction(context, user);
  }

  Future delaymsg() async {
    await Future.delayed(const Duration(minutes: 1));
    setState(() {
      resentaotp = true;
      print(resentaotp);
    });
  }

  @override
  void initState() {
    delaymsg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            "asset/flash_screen/login page background.png",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                GoogleFont(
                    text: "OTP Verification",
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF071305)),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                GoogleFont(
                    text: "We have sent the code verification to ",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF071305)),
                SizedBox(height: MediaQuery.of(context).size.height / 96),
                GoogleFont(
                    text: widget.email!,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF071305)),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                GoogleFont(
                    text: "Enter the OTP below to verify it",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF071305)),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Pinput(
                            length: 5,
                            keyboardType: TextInputType.number,
                            defaultPinTheme: PinTheme(
                                width: MediaQuery.of(context).size.width / 9,
                                height: MediaQuery.of(context).size.height / 17,
                                textStyle: const TextStyle(),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10))),
                            onCompleted: (value) {
                              setState(() {
                                typeotp = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 90),
                        GoogleFont(
                            text: "Resent code ?",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: resentaotp
                                ? Colors.blue
                                : const Color.fromARGB(255, 131, 133, 130)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                ButtonWidget(
                    onTap: () {
                      setState(() {
                        isLoading = true; // Set loading state to true
                      });
                      print(widget.otp.toString());
                      print("new one");
                      print(typeotp);
                      if (identical(
                          widget.otp.toString(), typeotp.toString())) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: GoogleFont(
                            text: 'Wrong OTP',
                          ),
                        ));
                      } else {
                        otpverifiaction();
                      }
                    },
                    width: MediaQuery.of(context).size.width / 1.3,
                    hight: MediaQuery.of(context).size.height / 17,
                    isloading: isLoading,
                    text: "Submit"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
