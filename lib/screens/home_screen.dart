import 'package:cosky/screens/util/hex_color_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color mainColor = HexColorConverter.fromHex("#1D4A7A");
  String? currentUser;
  String whatsHappening = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  // Method to load the login details
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser = prefs.getString('currentEmail') ?? '';
    });
  }

  void _loadWhatsHappening() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      whatsHappening = prefs.getString('whatsHappening') ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const Text('Co-Sky', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child:
            Text("Hi $currentUser,",
              style: const TextStyle(color: Colors.black54,
                fontFamily: 'Montserrat',
                fontSize: 16,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical:0),
            child: Text("Welcome Back!",
            style: TextStyle(color: Colors.black54,
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical:20),
            child: TextFormField(
              onChanged: (value) {
                whatsHappening = value.toString().trim();
              },
              cursorColor: mainColor,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: mainColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: mainColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: mainColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 2, color: mainColor),
                    //borderRadius: BorderRadius.circular(15.0),
                  ), labelText: "What's happening right now?", labelStyle: TextStyle(color: mainColor)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical:5),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('whatsHappening', whatsHappening);
                  _loadWhatsHappening();
                  if (kDebugMode) {
                    print("sign up success!");
                  }
                  // Navigate the user to the Home page
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Please fill up all fields',
                      style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: mainColor),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'POST',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                //selectionColor: Palette.kToDark,
              ),
            ),
          ),
          SizedBox(height: 30),
          whatsHappening != '' ?
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical:5),
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical:5),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.5,
                    color: mainColor
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
            child: Text(whatsHappening, style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: mainColor, fontSize: 30),)
          ))  : Container(),
        ],
      ),),
    );
  }

}