import 'package:cosky/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CoSkyHome());
  }

class CoSkyHome extends StatelessWidget {
  const CoSkyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoSky App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          //iconTheme: IconThemeData(color: Colors.black),
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.blue, fontSize: 20,) //fontFamily: 'Space Grotesk'),
        ),
        fontFamily: 'Montserrat',
        primaryTextTheme:
        TextTheme(
          displayLarge: TextStyle(color: Colors.red[300]),
          displayMedium: TextStyle(color: Colors.red[300]),
          bodyMedium:  TextStyle(color: Colors.red[300]),
          titleMedium:  TextStyle(color: Colors.red[300]),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}