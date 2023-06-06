import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:resume_builder/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SignUpPage(),
    );
  }
}
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conpass = TextEditingController();
  bool passToggle = true;
  bool passToggle2 = true;

  Future register() async {
    var url = Uri.parse(
        'https://testresumebuilder.000webhostapp.com/capstone/register.php');
//    var url = Uri.parse('http://192.168.2.205/capstone/register.php');
    //var url = Uri.parse('http://resumebuilder.infinityfreeapp.com/register.php');
    String useremail = email.text.trim();
    String password = pass.text.trim();
    String username = user.text.trim();
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    // if(useremail.isEmpty){
    //   Fluttertoast.showToast(msg: "Please enter a email");
    //   return;
    // }

    if (!RegExp(emailPattern).hasMatch(useremail)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
      return;
    }

    if (username.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a username");
      return;
    }


    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a password");
      return;
    }

    if (password.length < 8) {
      Fluttertoast.showToast(msg: "Password should have at least 8 characters");
      return;
    }
    if (!password.contains(new RegExp(r'[A-Z]'))) {
      Fluttertoast.showToast(
          msg: "Password should contain at least one uppercase letter");
      return;
    }
    if (!password.contains(new RegExp(r'[a-z]'))) {
      Fluttertoast.showToast(
          msg: "Password should contain at least one lowercase letter");
      return;
    }
    if (!password.contains(new RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(msg: "Password should contain at least one digit");
      return;
    }
    if (password != conpass.text) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return;
    }

    var response = await http.post(url, body: {
      "username": user.text,
      "email": email.text,
      "password": pass.text,
      "confirm password": conpass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Email Already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0

      );
    } else {
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0

      );
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage(),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   brightness: Brightness.light,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(Icons.arrow_back,
      //       size: 20,
      //       color: Colors.black,),
      //
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Container(
          key: _formKey,
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery
              .of(context)
              .size
              .height - 5,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 100),
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icon.png"),
                        fit: BoxFit.fitHeight,
                    )
                ),
              ),
              Column(
                children: <Widget>[
                 // SizedBox(height: 10),
                  Text("Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 20),
                  Text("Create an account",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]),)
                ],
              ),

              Form(
                  key: _formKey,
                  child:Container(
                    //padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            //inputFile1(label: "UserName"),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: user,
                              decoration: InputDecoration(
                                labelText: "User Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value){
                                if(user.text.isEmpty){
                                  return "Name field cannot be empty";
                                }else if(user.text.length >=100){
                                  return "Name cannot be exceed 100 characters";
                                }
                                return null;
                              },
                            ),
                            //inputFile2(label: "Email"),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: email,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),

                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value){
                                // if(email.text.isEmpty){
                                //   return "Email field cannot be empty";
                                // }else if(email.text.length >=100){
                                //   return "Email cannot be exceed 100 characters";
                                // }
                                // return null;
                                String useremail = email.text.trim();
                                String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                if(email.text.isEmpty) {
                                  return "Email field cannot be empty";
                                }
                                else if (!RegExp(emailPattern).hasMatch(useremail )) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            //inputFile3(label: "Password",obscureText: true),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: pass,
                              obscureText: passToggle,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(10, 26, 10, 5),
                                  prefixIcon: Icon(Icons.lock),
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passToggle = !passToggle;
                                      });
                                    },
                                    child: Icon(passToggle ? Icons.visibility : Icons
                                        .visibility_off),
                                  )
                              ),
                              validator: (value){
                                if (pass.text.isEmpty) {
                                  return "Please enter a password";
                                }

                                if (pass.text.length < 8) {
                                  return "Password should have at least 8 characters";
                                }
                                if (!pass.text.contains(new RegExp(r'[A-Z]'))) {
                                  return "Password should contain at least one uppercase letter";
                                }
                                if (!pass.text.contains(new RegExp(r'[a-z]'))) {
                                  return "Password should contain at least one lowercase letter";
                                }
                                if (!pass.text.contains(new RegExp(r'[0-9]'))) {
                                  return "Password should contain at least one digit";
                                }

                                // if(pass.text.isEmpty){
                                //   return "password field cannot be empty";
                                // }else if(pass.text.length >=100){
                                //   return "password cannot be exceed 100 characters";
                                // }
                                return null;
                              },
                            ),
                            //inputFile4(label: "Confirm Password",obscureText: true),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: conpass,
                              obscureText: passToggle2,
                              decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.fromLTRB(10, 26, 10, 5),
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passToggle2 = !passToggle2;
                                      });
                                    },
                                    child: Icon(passToggle2 ? Icons.visibility : Icons
                                        .visibility_off),
                                  )
                              ),
                              validator: (value){
                                if (pass.text.isEmpty) {
                                  return "Please enter a password";
                                }
                                if (pass.text != conpass.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // border: Border(
                            //   bottom: BorderSide(color: Colors.black),
                            //   top: BorderSide(color: Colors.black),
                            //   left: BorderSide(color: Colors.black),
                            //   right: BorderSide(color: Colors.black),
                            // )
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                register();
                              }
                            },
                            color: Color.fromARGB(255, 0, 121, 139),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Text(
                              "Sign Up", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account ? "),
                  SizedBox(height: 5),
                  MaterialButton(
                    //minWidth: double.infinity,
                    //height: 50,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    // color: Color(0xff0095FF),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(50)
                    //),
                    child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.blue,decoration: TextDecoration.underline,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
