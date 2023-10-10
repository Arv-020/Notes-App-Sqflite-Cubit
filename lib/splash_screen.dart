import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                "assets/animation/anLoading.json",
                // height: 500,
                // width: 500,
                frameRate: FrameRate(144),
                // reverse: true,
              ),
            ),
            Expanded(
              child: Lottie.network(
                  "https://lottie.host/343debd4-dadc-401f-bd7d-c072c8601a10/rC9TSed2ZS.json",
                  reverse: true,
                  frameRate: FrameRate(144)),
            )
          ],
        ),
      ),
    );
  }
}
