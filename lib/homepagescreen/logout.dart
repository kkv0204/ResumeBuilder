import 'package:flutter/material.dart';
import 'package:resume_builder/homepagescreen/home.dart';
import 'package:resume_builder/homepagescreen/homepage.dart';
import 'package:resume_builder/login.dart';
import 'package:resume_builder/splashscreen.dart';
import 'package:resume_builder/templatescreen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);
  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear() ;
    // Navigate to login screen;
    //Navigator.pop(context,true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()),);
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
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






// class Logout extends StatelessWidget {
//   const Logout({Key? key}) : super(key: key);
//   Future<void> logoutUser(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear() ;
//     // Navigate to login screen;
//     Navigator.pop(context,true);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()),);
//   }
//
//
//   void showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Logout'),
//           content: Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Logout'),
//               onPressed: () {
//                 logoutUser(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showLogoutDialog(context);
//           },
//           child: Text('Logout'),
//         ),
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:shared_pref/loginPage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:flutter/material.dart';
// import 'package:resume_builder/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Logout extends StatefulWidget {
//   @override
//   _LogoutState createState() => _LogoutState();
// }
//
// class _LogoutState extends State<Logout> {
//   String? username;
//   String? password;
//
//   @override
//   void initState() {
//     super.initState();
//     name();
//   }
//
//   void name() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       username = prefs.getString('user');
//       password = prefs.getString('pass');
//     });
//   }
//
//   void _logOut() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('user');
//     prefs.setString('user', username!);
//     prefs.setString('password', password!);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginPage()));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         backgroundColor: Color.fromARGB(255,0,121,139),
//         actions: <Widget>[
//           IconButton(icon: Icon(Icons.logout), onPressed: _logOut)
//         ],
//       ),
//       body: Center(
//         child: Stack(
//           children: [
//             DraggableScrollableSheet(
//                 initialChildSize: 0.1,
//                 minChildSize: 0.1,
//                 maxChildSize: 0.5,
//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                   return Container(
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(255,0,121,139),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         )),
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(20),
//                                   )),
//                               height: 10,
//                               width: 100,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
//                             child: CircleAvatar(
//                               radius: 50.0,
//                               backgroundColor: Colors.grey,
//                             ),
//                           ),
//                           Text(
//                             "$password",
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             "$username",
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }