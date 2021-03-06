import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'menu_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkUser(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Center(
            child: FlutterLogo(size: 100,),
          )
    );
  }

  checkUser(BuildContext context) async {


    Timer(Duration(milliseconds: 500), () async {
     
      await Future.delayed(Duration(milliseconds: 1500));

      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MenuPage()),
  );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
