import 'package:amazin/screen/login.dart';
import 'package:amazin/screen/screens.dart';
import 'package:amazin/user_screen/homescreen.dart';
import 'package:amazin/user_screen/loading_screen.dart';
import 'package:amazin/user_screen/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBIIZY4nFmhaBovolSx6NqS9FqDN84aySs",
          appId: "1:464970677527:web:de41ff8089b97aa3a18b52",
          messagingSenderId: "464970677527",
          projectId: "class-4e7bb"));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}

// class LaunchPage extends StatefulWidget {
//   const LaunchPage({super.key});

//   @override
//   State<LaunchPage> createState() => _LaunchPageState();
// }

// class _LaunchPageState extends State<LaunchPage> {
//   Future<bool> is_login() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool login = prefs.getBool('login') ?? false;
//     return login;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: is_login(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data == true) {
//               print(snapshot.data);
//               return HomeScreenUser();
//             } else if (snapshot.data == false) {
//               return LoginPageUser();
//             }
//           }
//           return loading_Screen();
//         });
//   }
// }
