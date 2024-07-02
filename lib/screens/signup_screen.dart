import 'package:cosky/screens/login_screen.dart';
import 'package:cosky/screens/util/hex_color_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  //const InitialPage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool showRePassword = false;

  String pattern = //r'\w+@\w+\.\w+';
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String email = '';
  String password = '';
  String repassword = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  Color mainColor = HexColorConverter.fromHex("#1D4A7A");


  void saveUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    print('save user email is ${emailController.toString()}');
    print('save user password is ${passwordController.toString()}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      if (kDebugMode) {
        print("sign up success!");
      }
  }

  @override
  void initState(){
    super.initState();
    showPassword = false;
    if (kDebugMode) {
      print('init showPassword is $showPassword');
    }
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Center(
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/logo/CoSkyLogo_colored.png'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Text('Sign Up',
                        style: TextStyle(color: mainColor,
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text("Enter your credentials to continue",
                        style: TextStyle(color: Colors.black54,
                          //fontFamily: 'Montserrat',
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                            ), labelText: "Email", labelStyle: TextStyle(color: mainColor)),
                        validator: (value) {
                          RegExp regex = RegExp(pattern);
                          if (value == null || value.isEmpty){
                            return 'Enter a valid email address';
                          }
                          else if (regex.hasMatch(value)) {
                            return null;
                          }
                          else {
                            return 'Invalid e-mail address format';
                          }
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
                          if (value == null || value.isEmpty){
                            return 'Enter a valid password';
                          }
                          else if (value.length < 6 ) {
                            return 'Password must be at least 6 characters';
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
                          repassword = value.toString().trim();
                        },
                        cursorColor: mainColor,
                        obscureText: !showRePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(icon: Icon(
                              showRePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: mainColor,
                            ),
                              color: mainColor,
                              onPressed: () {
                                setState(
                                      () {
                                        showRePassword = !showRePassword;
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
                            ), labelText: "Re-type Password", labelStyle: TextStyle(color: mainColor)),
                        validator: (value) {
                          print('value is $value and password is $passwordController and repass is $repasswordController');
                          if (value != password){
                            return 'Password do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          print('$email and $password');
                          if (_formKey.currentState!.validate()) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('$email', email);
                            await prefs.setString('$password', password);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
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
                          'SIGN UP',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          //selectionColor: Palette.kToDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 115),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text("Already have an account?",
                              style: TextStyle(color: Colors.black54,
                                //fontFamily: 'Montserrat',
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                              if (kDebugMode) {
                                print('log in clicked');
                              }
                            },
                            child: Center(
                              child: Text("Log In",
                                style: TextStyle(color: mainColor,
                                  //fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }



}