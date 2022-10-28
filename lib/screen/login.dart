import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Karo',
              style: GoogleFonts.kadwa(
                letterSpacing: 0.2,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            SizedBox(
              width: 450,
              child: TextFormField(
                controller: _emailController,
                style: GoogleFonts.kadwa(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: GoogleFonts.kadwa(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 255, 106, 0),
                      ),
                    )),
              ),
            ),
            SizedBox(
              width: 450,
              child: TextFormField(
                controller: _passwordController,
                style: GoogleFonts.kadwa(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.kadwa(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 255, 106, 0),
                      ),
                    )),
              ),
            ),
            InkWell(
              onTap: () async {
                if (_emailController.text == "") {
                  alert(context, "Email Field is Empty");
                } else if (_passwordController.text == "") {
                  alert(context, "Password Field is Empty");
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.28,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromARGB(255, 252, 5, 5),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: GoogleFonts.kadwa(
                      letterSpacing: 0.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<dynamic> alert(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text(
          "Validation Error!",
          style: GoogleFonts.kadwa(
            letterSpacing: 0.2,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.kadwa(
            letterSpacing: 0.2,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(ctx).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'OK',
                style: GoogleFonts.kadwa(
                  letterSpacing: 0.2,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
