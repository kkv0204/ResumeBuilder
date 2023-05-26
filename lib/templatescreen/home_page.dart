import 'package:flutter/material.dart';
import 'package:resume_builder/templatescreen/choosetemplate/1_template/1_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/2_template/2_c_template.dart';
import 'package:resume_builder/homepagescreen/resume_form.dart';
import 'package:resume_builder/templatescreen/choosetemplate/4_template/4_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/3_template/3_d_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/5_template/5_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/6_template/6_c_template.dart';
import 'package:resume_builder/templatescreen/choosetemplate/7_template/7_c_template.dart';

import 'choosetemplate/8_template/8_c_template.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static List<dynamic> classicTemplates = [{"template":ResumePage(),"image":"assets/template_2.jpeg","title":"Classic"},{"template":ResumeClassicPage2(),"image":"assets/template_3.jpeg","title":"Classic 2",},{"template":ResumeClassicPage4(),"image":"assets/template_4.png","title":"Classic_4"},{"template":ResumeClassicPage5(),"image":"assets/template_5.png","title":"Classic_5"}];
  static List<dynamic> designerTemplates = [{"template":ResumeClassicPage(),"image":"assets/template_1.jpeg","title":"Designer"},{"template":ResumeClassicPage6(),"image":"assets/template_6d.jpg","title":"Designer2"},{"template":ResumeClassicPage7(),"image":"assets/template_7.jpg","title":"Designer3"},{"template":ResumeClassicPage8(),"image":"assets/template_8.jpg","title":"Designer4"}];


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 0, 121, 139),
      title: const Text("Resume Templates",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color.fromARGB(224, 255, 255, 255))),
    ),
    body: Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Update Resume")),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                        color:Color.fromARGB(255, 0, 121, 139),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ResumeForm(),
                        ));
                      },
                      child: Row(
                        children: [
                          Text("Edit",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100])),
                          SizedBox(width: 5,),
                          Icon(Icons.edit,color: Colors.grey[100],size: 20,)
                        ],
                      ),
                    ),
                  )
                ]
              ),
            ),
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
                                       builder: (BuildContext context) => classicTemplates[index]["template"],
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
                              builder: (BuildContext context) => designerTemplates[index]["template"],
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
    );
  }
}