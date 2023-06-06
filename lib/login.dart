import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resume_builder/homepagescreen/data.dart';
import 'package:resume_builder/homepagescreen/home.dart';
import 'package:resume_builder/homepagescreen/homepage.dart';
import 'package:resume_builder/main.dart';
import 'package:resume_builder/signup.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:resume_builder/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool passToggle = true;
  bool isLoading = false; // Track loading state

  Future login() async {
    setState(() {
      isLoading = true; // Show progress bar
    });
    String useremail = email.text.trim();
    String password = pass.text.trim();

    if (useremail.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter an email");
      setState(() {
        isLoading = false; // Hide progress` bar
      });
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a password");
      setState(() {
        isLoading = false; // Hide progress bar
      });
      return;
    }

    var url = Uri.parse(
        'https://testresumebuilder.000webhostapp.com/capstone/login.php');
    var response = await http.post(url, body: {
      "email": email.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data['status'] == 'Success') {
      var userid = int.parse(data['userid']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userid', userid);
      String userName = data['username'];
      await prefs.setString("username", userName);
      String Email = data['email'];
      await prefs.setString('email', Email);
      print(Email);
      print(userName);
      Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          textColor: Colors.white,
          fontSize: 16.0);
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      isLoading = false; // Hide progress bar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        //margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0, left: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(10, 37, 10, 5),
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  validator: (value) {
                                    String useremail = email.text.trim();
                                    String emailPattern =
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                    if (value!.isEmpty) {
                                      return "Please enter a email";
                                    } else if (!RegExp(emailPattern)
                                        .hasMatch(useremail)) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: pass,
                                  obscureText: passToggle,
                                  validator: (value) {
                                    if (pass.text.isEmpty) {
                                      return "Please enter a password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(200)),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(10, 27, 10, 5),
                                      prefixIcon: Icon(Icons.lock),
                                      suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            passToggle = !passToggle;
                                          });
                                        },
                                        child: Icon(passToggle
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      )),
                                ),
                              ),
                              SizedBox(height: 20,),
                              //   inputFile(label: "Email", controller: email),
                              //   inputFile(
                              //       label: "Password",
                              //       controller: pass,
                              //       obscureText: passToggle,
                              //       suffixIcon: IconButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             passToggle = !passToggle;
                              //           });
                              //         },
                              //         icon: Icon(
                              //           passToggle
                              //               ? Icons.visibility
                              //               : Icons.visibility_off,
                              //           color: Colors.grey[700],
                              //         ),
                              //       )),
                            ],

                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            color: Color.fromARGB(255, 0, 121, 139),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icon.png"),
                            fit: BoxFit.fitHeight)),
                  ),
                ],
              ),
            ),
            isLoading // Conditionally show progress bar
                ? CircularProgressIndicator()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget inputFile({label, obscureText = false, controller, suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: Color.fromARGB(255, 0, 121, 139),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 121, 139),
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}