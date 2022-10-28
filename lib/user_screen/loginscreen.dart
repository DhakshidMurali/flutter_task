import 'package:amazin/user_screen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageUser extends StatefulWidget {
  const LoginPageUser({super.key});

  @override
  State<LoginPageUser> createState() => _LoginPageUserState();
}

class _LoginPageUserState extends State<LoginPageUser> {
  TextEditingController _phonenumberController = new TextEditingController();
  TextEditingController _otpnumberController = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isverify = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(34, 34, 34, 1),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYugcd50H-J9k2aqtQ8GgebajaY3aMC7k7uw&usqp=CAU",
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          controller: _phonenumberController,
                          style: GoogleFonts.kadwa(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter your Phone Number',
                            hintStyle: GoogleFonts.kadwa(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 106, 0))),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          controller: _otpnumberController,
                          style: GoogleFonts.kadwa(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter the OTP send',
                            hintStyle: GoogleFonts.kadwa(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 106, 0))),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          print("+91 " + _phonenumberController.text);
                          if (_phonenumberController.text.length == 10) {
                            isverify = true;
                            setState(() {});
                            auth.verifyPhoneNumber(
                              phoneNumber: "+91 " + _phonenumberController.text,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                print("ENtered");
                                await auth
                                    .signInWithCredential(credential)
                                    .then((value) {
                                  prefs.setBool('login', true);
                                  print("You are logged in successfully");
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomeScreenUser()));
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print("ENtered1");
                                showdialog(context,
                                    "Enter valid Phone Number to continue");
                              },
                              codeSent: (String verificationId,
                                  int? resendToken) async {
                                print("ENtered2");
                                isverify = true;
                                setState(() {});
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: _otpnumberController.text);
                                await auth
                                    .signInWithCredential(credential)
                                    .then((value) => {
                                          prefs.setBool('login', true),
                                          print(
                                              "You are logged in successfully"),
                                          print(prefs.getBool('login')),
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreenUser()))
                                        });
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          }
                          if (_phonenumberController.text.length == 0) {
                            showdialog(
                                context, "Phone Number field is empty!!");
                          }
                          setState(() {});
                          //remove
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => otp_Screen(verificationID)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.kadwa(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }

  Future<dynamic> showdialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("${text}"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: Text('OK'))),
            )
          ],
        );
      },
    );
  }
}
