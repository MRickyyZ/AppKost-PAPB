import 'package:flutter/material.dart';
import 'package:appkost/screens/Detail_Screen.dart';
import 'package:appkost/screens/Login_Screen.dart';
import 'package:appkost/screens/SignUp_Screen.dart';
import 'package:appkost/screens/Started_Screen.dart';
import 'package:appkost/screens/Home_Screen.dart';
import 'package:appkost/screens/Profile_Screen.dart';
import 'package:appkost/screens/Edit_Profile_Screen.dart';
import 'package:appkost/screens/Change_Password_Screen.dart';
import 'package:appkost/screens/Splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kost Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/detail': (context) {
  final arguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  return DetailScreen(kostId: arguments['kostId']);
},

        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/editprofile': (context) => EditProfileScreen(),
        '/changepassword': (context) => ChangePasswordScreen(),
        '/': (context) => StartedScreen(),
      },
    );
  }
}
