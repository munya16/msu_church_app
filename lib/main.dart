import 'package:ice/helper/helper_function.dart';
import 'package:ice/pages/auth/login_page.dart';
import 'package:ice/pages/home_page.dart';
import 'package:ice/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ice/Providers/bottom_nav_provider.dart';
import 'package:ice/Providers/db_provider.dart';
import 'package:ice/Providers/fetch_polls_provider.dart';
import 'package:ice/Screens/Home/dash_board_screen.dart';
import 'package:ice/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCyNm0WvHIjd0wu9XpW_EipuS98wg84458",
            authDomain: "iceapp-db79c.firebaseapp.com",
            databaseURL: "https://iceapp-db79c-default-rtdb.firebaseio.com",
            projectId: "iceapp-db79c",
            storageBucket: "iceapp-db79c.appspot.com",
            messagingSenderId: "252588146574",
            appId: "1:252588146574:web:8f8ceab965a35216a6aedf",
            measurementId: "G-M9PWS92131"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => DbProvider()),
        ChangeNotifierProvider(create: (context) => FetchPollsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        //home: DashBoardScreen(),
        home: _isSignedIn ? DashBoardScreen() : const LoginPage(),
      ),
    );
  }
}









