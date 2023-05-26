import 'package:flutter/material.dart';
import 'package:resume_builder/templatescreen/choosetemplate/1_template/1_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/2_template/2_c_template.dart';
import 'package:resume_builder/homepagescreen/resume_form.dart';
import 'package:resume_builder/templatescreen/choosetemplate/4_template/4_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/3_template/3_d_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/5_template/5_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/6_template/6_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/7_template/7_c_template.dart';

class Templates extends StatefulWidget {

  const Templates({Key? key}) : super(key: key);

  @override
  State<Templates> createState() => _TemplatesState();
}

class _TemplatesState extends State<Templates> {

  List<dynamic> classicTemplates = [{"image":"assets/template_2.jpeg","title":"Classic"},{"image":"assets/template_3.jpeg","title":"Classic 2",},{"image":"assets/template_4.png","title":"Classic_4"},{"image":"assets/template_5.png","title":"Classic_5"}];
  List<dynamic> designerTemplates = [{"image":"assets/template_1.jpeg","title":"Designer"},{"image":"assets/template_6d.jpg","title":"Designer2"},{"image":"assets/template_7.jpg","title":"Designer3"},{"image":"assets/template_8.jpg","title":"Designer4"}];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          title: Center(child: const Text("View Resume Templates",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color.fromARGB(224, 255, 255, 255)))),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text("Classic templates",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
                SizedBox(height: 20,),
                Container(
                  // color: Colors.grey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(classicTemplates.length, (index){
                            return
                              Column(children: [
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Image.asset(
                                                  classicTemplates[index]["image"]
                                              );
                                            },
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right:8),
                                      child: Column(
                                        children: [
                                          Image(height:225,width:160,image: AssetImage(classicTemplates[index]["image"])),
                                          SizedBox(height: 3,),
                                          Text("${classicTemplates[index]["title"]}", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black54),)
                                        ],
                                      ),
                                    ) ),
                              ],
                              );
                          }
                          )
                      ),
                    )
                ),
                SizedBox(height: 30,),
                Text("Designer templates",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
                SizedBox(height: 20,),
                Container(
                  // color: Colors.grey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(designerTemplates.length, (index){
                            return
                              Column(children: [
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Image.asset(
                                                  designerTemplates[index]["image"]
                                              );
                                            },
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right:8),
                                      child: Column(
                                        children: [
                                          Image(height:225,width:160,image: AssetImage(designerTemplates[index]["image"])),
                                          SizedBox(height: 3,),
                                          Text("${designerTemplates[index]["title"]}", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black54),)
                                        ],
                                      ),
                                    )
                                ),
                              ],
                              );
                          }
                          )
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async{
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


// import 'package:flutter/material.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/1_template/1_c_template.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/2_template/2_c_template.dart';
// import 'package:resume_builder/homepagescreen/resume_form.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/4_template/4_template.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/3_template/3_d_template.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/5_template/5_c_template.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/6_template/6_c_template.dart';
// import 'package:resume_builder/templatescreen/choosetemplate/7_template/7_c_template.dart';
//
// class Templates extends StatefulWidget {
//
//   const Templates({Key? key}) : super(key: key);
//
//   @override
//   State<Templates> createState() => _TemplatesState();
// }
//
// class _TemplatesState extends State<Templates> {
//
//   List<dynamic> classicTemplates = [{"image":"assets/template_2.jpeg","title":"Classic"},{"image":"assets/template_3.jpeg","title":"Classic 2",},{"image":"assets/template_4.png","title":"Classic_4"},{"image":"assets/template_5.png","title":"Classic_5"}];
//   List<dynamic> designerTemplates = [{"image":"assets/template_1.jpeg","title":"Designer"},{"image":"assets/template_6d.jpg","title":"Designer2"},{"image":"assets/template_7.jpg","title":"Designer3"},{"image":"assets/template_8.jpg","title":"Designer4"}];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 0, 121, 139),
//         title: Center(child: const Text("View Resume Templates",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color.fromARGB(224, 255, 255, 255)))),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 30,),
//               Text("Classic templates",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
//               SizedBox(height: 20,),
//               Container(
//                 // color: Colors.grey,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                         children: List.generate(classicTemplates.length, (index){
//                           return
//                             Column(children: [
//                               GestureDetector(
//                                   onTap: (){
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) {
//                                             return Image.asset(
//                                                 classicTemplates[index]["image"]
//                                             );
//                                           },
//                                         ));
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.only(right:8),
//                                     child: Column(
//                                       children: [
//                                         Image(height:225,width:160,image: AssetImage(classicTemplates[index]["image"])),
//                                         SizedBox(height: 3,),
//                                         Text("${classicTemplates[index]["title"]}", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black54),)
//                                       ],
//                                     ),
//                                   ) ),
//                             ],
//                             );
//                         }
//                         )
//                     ),
//                   )
//               ),
//               SizedBox(height: 30,),
//               Text("Designer templates",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black54)),
//               SizedBox(height: 20,),
//               Container(
//                 // color: Colors.grey,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                         children: List.generate(designerTemplates.length, (index){
//                           return
//                             Column(children: [
//                               GestureDetector(
//                                   onTap: (){
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) {
//                                             return Image.asset(
//                                                 designerTemplates[index]["image"]
//                                             );
//                                           },
//                                         ));
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.only(right:8),
//                                     child: Column(
//                                       children: [
//                                         Image(height:225,width:160,image: AssetImage(designerTemplates[index]["image"])),
//                                         SizedBox(height: 3,),
//                                         Text("${designerTemplates[index]["title"]}", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black54),)
//                                       ],
//                                     ),
//                                   )
//                               ),
//                             ],
//                             );
//                         }
//                         )
//                     ),
//                   )
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }