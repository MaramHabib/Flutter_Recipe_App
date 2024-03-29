import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/preferences.services.dart';
import '../utils/images.dart';
import 'home_page.dart';
import 'home_page_mod.dart';
import 'home_page_resp.dart';
import 'login_page.dart';
import 'login_page_mod.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  StreamSubscription<User?>? _listener;
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    // await Future.delayed(const Duration(seconds: 3));

//********************  Using Shared Preferences ****************
//     if (PreferencesService.checkUser()){
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => HomePage()));
//     }else{
//       Navigator.pushReplacement(context,
//       MaterialPageRoute(builder: (_) => LoginPage()));
//     }
//********************  Using GetIt  ****************
//     if (GetIt.I.get<SharedPreferences>().getBool('isLogin') ?? false) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => HomePageMod()));
//
//       // go to home page
//     } else {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => HomePageMod()));
//       // go to login page

//******************  Firebase Provider *****************************8

    await Future.delayed(const Duration(seconds: 1));
    _listener=FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPageMod()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePageMod()));
      }
    });
  }
  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagesPath.background), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(ImagesPath.baseHeader),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

}