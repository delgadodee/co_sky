import 'package:cosky/main.dart';
import 'package:cosky/screens/signup_screen.dart';
import 'package:cosky/screens/util/hex_color_converter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  //const InitialPage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color mainColor = HexColorConverter.fromHex("#1D4A7A");

  String? email;
  String? password;

  String? loadEmail;
  String? loadPassword;

  bool showPassword = false;
  @override
  void initState() {
    super.initState();
  }

  // Method to load the login details
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loadEmail = prefs.getString('$email') ?? '';
      loadPassword = prefs.getString('$password') ?? '';
    });
    print('load preferences are loadEmail:$loadEmail and loadPassword:$loadPassword');
    print('email is $email and loadEmail is $loadEmail and password is $password');
    if(email == loadEmail && password == loadPassword){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentEmail', email!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      print('login success');
    }
  }

  Widget logIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/logo/CoSkyLogo_colored.png'),
              ),
              SizedBox(width: 10),
              Text('Login',
                style: TextStyle(color: mainColor,
                    fontFamily: 'Montserrat',
                    fontSize:40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              onChanged: (value) {
                email = value.toString().trim();
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
                  ),labelText: "Email", labelStyle: TextStyle(color: mainColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: TextFormField(
              onChanged: (value) {
                password = value.toString().trim();
              },
              cursorColor: mainColor,
              obscureText: !showPassword,
              decoration: InputDecoration(
                  suffixIcon: IconButton(icon: Icon(
                    showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: mainColor,
                  ),
                    color: mainColor,
                    onPressed: () {
                      setState(
                            () {
                          showPassword = !showPassword;
                        },
                      );
                    },
                  ),
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
                  ), labelText: "Password", labelStyle: TextStyle(color: mainColor)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:
            TextButton(
              onPressed: (){
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: mainColor, fontSize: 15, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: ElevatedButton(
              // foreground
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Navigate the user to the Home page'
                  _loadPreferences();
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
                'LOGIN',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                //selectionColor: Palette.kToDark,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New User?',
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: //forgetPassword != true ?
              logIn() //:
              //forgetPass(),
            ),
          ),
        ),
      ),
    );
  }

}