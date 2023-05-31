import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/homepagescreen/data.dart';
import 'package:resume_builder/homepagescreen/homepage.dart';
import 'package:resume_builder/homepagescreen/resume_form.dart';
import 'package:resume_builder/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = '';
  String _email = '';
  String uIcon = '';

  @override
  void initState() {
    _loadUsername();
    super.initState();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.get("username").toString();
    String Email = prefs.get("email").toString();
    print(userName);
    print(Email);

    if (userName != null) {
      setState(() {
        _username = userName;
        _email = Email;
        uIcon = _username[0].toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 121, 139),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(uIcon,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 121, 139),
                          )),
                    ),
                    accountName: Text(
                      _username,
                      style: TextStyle(fontSize: 20),
                    ),
                    accountEmail: Text(
                      _email,
                      style: TextStyle(fontSize: 18),
                    )),
                Card(
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Logout();
                        },
                      ));
                    },
                    leading: Icon(Icons.logout),
                  ),
                )
              ],
            ),
          ),
          //backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Resume Builder"),
            backgroundColor: Color.fromARGB(255, 0, 121, 139),
            // leading: Container(
            //   child: CircleAvatar(radius: 5,backgroundImage: AssetImage("assets/icon.png")),
            // ),
          ),
          body: Container(
            child: Container(
              height: 800,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 20, 0, 20),
                        child: Column(
                          children: [
                            Text(
                              'Create a Resume',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color.fromARGB(255, 0, 121, 139),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'in few minutes!!',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color.fromARGB(255, 0, 121, 139),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Lottie.asset('assets/homescreen.json',
                                width: 140, height: 140, fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.all(30),
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 121, 139),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                        )),
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: 20.0, height: 100.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          SizedBox(
                          child: TyperAnimatedTextKit(
                              text: [
                                'Welcome, '+ _username+'',
                              ],
                              textStyle: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: "Rumbling",
                                color: Colors.white
                              ),
                              textAlign: TextAlign.start, // or Alignment.topLeft
                          ),
                        ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(child: Text('CREATE RESUME'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 121, 139),
                          side: BorderSide(color: Colors.white,width: 2),
                            elevation: 15,
                        ),onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ResumeForm(),));
                        },)
                      ],
                    ),
                  ),
                  // Text(
                  //   'Home Page',
                  //   style: TextStyle(
                  //       fontSize: 40,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       height: 2),
                  // ),
                  // SizedBox(height: 20),
                  // CircleAvatar(
                  //   radius: 70,
                  //   child: Icon(Icons.home, size: 120),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   'Welcome, '+ _username+'',
                  //   style: TextStyle(
                  //       fontSize: 40,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       height: 2),
                  // ),
                ],
              ),
            ),
          )),
    );
  }


  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App ?"),
          content: const Text("Do you want to exit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("YES"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("NO"),
            ),
          ],
        );
      },
    );
    return exitApp ?? false;
  }
}

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigate to login screen;
    //Navigator.pop(context,true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  // void showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Logout'),
  //         content: Text('Are you sure you want to logout?'),
  //         actions: [
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Logout'),
  //             onPressed: () {
  //               logoutUser(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        TextButton(
          child: Text('Logout'),
          onPressed: () {
            logoutUser(context);
          },
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
