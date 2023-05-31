
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/homepagescreen/data.dart';
import 'package:resume_builder/homepagescreen/logout.dart';
import 'package:resume_builder/homepagescreen/home.dart';
import 'package:resume_builder/homepagescreen/resume_form.dart';
import 'package:resume_builder/homepagescreen/templates.dart';
import 'package:resume_builder/main.dart';
import 'package:resume_builder/templatescreen/home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = const [
    Icon(Icons.home, size: 30, color: Colors.white),
    Icon(Icons.add, size: 30, color: Colors.white),
    Icon(Icons.article, size: 30, color: Colors.white),
    //Icon(Icons.logout, size: 30, color: Colors.white),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Resume Builder'),
      //   backgroundColor: Colors.blue[300],
      // ),
      //
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 0, 121, 139),
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: Container(
          color: Color.fromARGB(255, 0, 121, 139),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Home();
        break;
      case 1:
        widget = ResumeForm();
        break;
    // case 2:
    //   widget = const Templates();
    //   break;
      default:
        widget = const Templates();

    // default:
    //   widget = const Logout();
    //   break;
    }
    return widget;
  }
}


// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:resume_builder/homepagescreen/data.dart';
// import 'package:resume_builder/homepagescreen/logout.dart';
// import 'package:resume_builder/homepagescreen/home.dart';
// import 'package:resume_builder/homepagescreen/resume_form.dart';
// import 'package:resume_builder/homepagescreen/templates.dart';
// import 'package:resume_builder/main.dart';
// import 'package:resume_builder/templatescreen/home_page.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final items = const [
//     Icon(Icons.home, size: 30, color: Colors.white),
//     Icon(Icons.add, size: 30, color: Colors.white),
//     Icon(Icons.article, size: 30, color: Colors.white),
//     Icon(Icons.logout, size: 30, color: Colors.white),
//   ];
//
//   int index = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Resume Builder'),
//       //   backgroundColor: Colors.blue[300],
//       // ),
//       //
//       bottomNavigationBar: CurvedNavigationBar(
//         color: Color.fromARGB(255, 0, 121, 139),
//         items: items,
//         index: index,
//         onTap: (selectedIndex) {
//           setState(() {
//             index = selectedIndex;
//           });
//         },
//         height: 70,
//         backgroundColor: Colors.transparent,
//         animationDuration: const Duration(milliseconds: 300),
//       ),
//       body: Container(
//           color: Color.fromARGB(255, 0, 121, 139),
//           width: double.infinity,
//           height: double.infinity,
//           alignment: Alignment.center,
//           child: getSelectedWidget(index: index)),
//     );
//   }
//
//   Widget getSelectedWidget({required int index}) {
//     Widget widget;
//     switch (index) {
//       case 0:
//         widget = Home();
//         break;
//       case 1:
//         widget = const ResumeForm();
//         break;
//       case 2:
//         widget = const Templates();
//         break;
//       default:
//         widget = const Logout();
//         break;
//     }
//     return widget;
//   }
// }
