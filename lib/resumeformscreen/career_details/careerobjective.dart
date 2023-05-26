import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
import 'package:resume_builder/resumeformscreen//sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../career_details/suggestions_about.dart';
import 'package:http/http.dart'as http;

class AboutForm extends StatefulWidget {
  const AboutForm({Key? key}) : super(key: key);

  @override
  State<AboutForm> createState() => _AboutFormState();
}

class _AboutFormState extends State<AboutForm> {

  TextEditingController aboutController = TextEditingController();
  SharedPreferencesService _prefs= SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    getAboutInfo();
  }

  getAboutInfo() async {
    String? aboutInfo = await _prefs.getFromSharedPref('about');
    if (aboutInfo!=null) {
      setState(() {
        aboutController.text = aboutInfo;
      });
    }
  }

  Future saveAboutInfo() async {
    var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/career_objective_details.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.get("userid").toString();
    print(userid);
    print("-----------------------------");

    var response = await http.post(url, body: {
      "u_id" : userid.toString(),
      "c_desc" : aboutController.text,
      "is_enabled" : "true"
    });
    print("--------------");
    print(response.body);
    print(response);
    print(response.statusCode);
    print("--------------");


    var data = json.decode(response.body);

    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Info Already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          textColor: Colors.white,
          fontSize: 16.0

      );
    } else {
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setInt("u_id",1);
      Fluttertoast.showToast(
          msg: "Data Inserted Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 0, 121, 139),
          textColor: Colors.white,
          fontSize: 16.0

      );

    }


    if (aboutController.text.isNotEmpty) {
      await _prefs.saveToSharedPref('about', aboutController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child:Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left:5),
                        child: const Text("Career Objective", style: TextStyle(fontSize: 17),),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: //Colors.blue

                            Color.fromARGB(255, 0, 121, 139)
                        ),
                        onPressed: () {
                          saveAboutInfo();
                        },
                        child: Container(
                            padding: EdgeInsets.zero,
                            child: const Text("Save details")
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height:5),
                  const Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                  const SizedBox(height:15),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: aboutController,
                      maxLines: 100,
                      decoration: textFieldDecoration("About me should be under 250 characters", ""),
                      validator: (value){
                        if (aboutController.text.isEmpty) {
                          return "About field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height:15),
                  const Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                  const SizedBox(height:10),
                  const Text("Suggestions for you", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 15,),
                  const Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                  const SizedBox(height:5),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: ListView.builder(
                        itemCount: about_me_suggestions.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 15,),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      aboutController.text = about_me_suggestions[index];
                                    });
                                  },
                                  child:Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        border:Border.all(color: Color.fromARGB(172, 0, 0, 0))

                                    ),
                                    child: Text(about_me_suggestions[index], style: const TextStyle(color: Colors.black54),),
                                  )
                              )
                            ],
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
            )
        ),
      ),
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