import 'package:cosky/screens/util/hex_color_converter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  //const InitialPage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  Color mainColor = HexColorConverter.fromHex("#1D4A7A");

  Future<void>? _launched;

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Uri pawddleTerms = Uri.parse(
        '');
    final Uri pawddlePrivacy = Uri.parse(
        '');

    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Center(
        child:
        Container(
          height: 500,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Image.asset('assets/images/Main logo.png'),
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/logo/CoSkyLogo_colored.png'),
                ),
                const SizedBox(height: 10),
                Text('Co-Sky',
                  style: TextStyle(color: mainColor,
                      fontFamily: 'Montserrat',
                      fontSize:40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text("Online Break Room",
                  style: TextStyle(color: Colors.black54,
                    fontFamily: 'Montserrat',
                    fontSize:18,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 80),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton( // foreground
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('GET STARTED',
                        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white),
                        //selectionColor: Palette.kToDark,
                      ),
                    )
                ),
                const SizedBox(height: 10),
               const Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                     Text('By clicking get started, you agree with our Terms. Learn how we process your data in our Privacy Policy.',
                       style: TextStyle(color: Colors.black54), textAlign: TextAlign.center,),
                   /*  ==============use when link is working already
                    GestureDetector(
                      child: const Text(
                        'Terms',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color:  Colors.black54),
                      ),
                      onTap: ()  {
                        _launched = _launchInWebViewOrVC(pawddleTerms);
                      },
                    ),
                     Text('.',  style: TextStyle(color: Colors.black54)),
                     Text('Learn how we process your data in our ', style: TextStyle(color: Colors.black54)),
                     ==============use when link is working already
                    GestureDetector(
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color:  Colors.black54),
                      ),
                      onTap: () {
                        _launched = _launchInWebViewOrVC(pawddlePrivacy);
                      },
                    ),*/
                    Text('.',  style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}