import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'initial_screen.dart';


class SplashScreen extends StatefulWidget {
  //const InitialPage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(//backgroundColor: Palette.kToDark,
      logo: Image.asset('assets/logo/CoSkyLogo_white.png', width: 500, height: 500),
      navigator: InitialScreen(),
      showLoader: false,
      durationInSeconds: 3,
    );
  }

}