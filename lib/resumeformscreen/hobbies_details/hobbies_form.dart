import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class HobbiesForm extends StatefulWidget {
  const HobbiesForm({Key? key}) : super(key: key);

  @override
  State<HobbiesForm> createState() => _HobbiesFormState();
}

class _HobbiesFormState extends State<HobbiesForm> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferencesService _prefs = SharedPreferencesService();
  TextEditingController hobbiescontroller = new  TextEditingController();
  List<dynamic> hobbiesList = [];
  List<dynamic> suggestedHobbies = ["Reading", "Cricket", "Movies", "Travelling"];

  getAllHobbies() async {
    String? allHobbies = await _prefs.getFromSharedPref('hobbies');
    if (allHobbies != null) {
      List<dynamic> decodedHobbies = jsonDecode(allHobbies);
      setState(() {
        hobbiesList = decodedHobbies;
      });
    }
  }

  removeHobbies(int index) async {
    hobbiesList.removeAt(index);
    await _prefs.saveToSharedPref('hobbies', jsonEncode(hobbiesList));
  }

  saveSuggestedLanguage(int index) async {
    hobbiesList.add(suggestedHobbies[index]);
    await _prefs.saveToSharedPref('hobbies', jsonEncode(hobbiesList));
  }

  Future saveLanguage() async {
    hobbiesList.add(hobbiescontroller.text);
    await _prefs.saveToSharedPref('hobbies', jsonEncode(hobbiesList));

    var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/hobbies_details.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.get("userid").toString();
    print(userid);
    print("-----------------------------");

    var response = await http.post(url, body: {
      "u_id" : userid.toString(),
      //"s_name":controller.text,
      "h_name" : hobbiesList.toString(),
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
          msg: "Fill the details properly",
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

  }

  @override
  void initState() {
    super.initState();
    getAllHobbies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: hobbiescontroller,
                            decoration: textFieldDecoration("Enter a single hobby here", "Hobbies"),
                            validator: (value){
                              if (hobbiescontroller.text.isEmpty) {
                                return "Hobbies field cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 121, 139),
                              //Color.fromARGB(255,0,121,139),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:GestureDetector(
                              onTap: (){
                                if (_formKey.currentState!.validate()) {
                                  saveLanguage();
                                  hobbiescontroller.text = "";
                                  setState(() { });
                                }
                              },
                              child: const Icon(Icons.add),
                            )

                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: List.generate(hobbiesList.length, (index){
                          return Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(5),
                            // margin: const EdgeInsets.only(left: 10),
                            // width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Text(hobbiesList[index], overflow: TextOverflow.ellipsis,),
                                const SizedBox(width: 5,),
                                GestureDetector(
                                    onTap: (){
                                      removeHobbies(index);
                                      setState(() {});
                                    },
                                    child:const Icon(Icons.cancel_sharp, color: Colors.black54,size: 18,)
                                )
                              ],
                            ),
                          );
                        },
                        ),
                      )),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Suggestions for you", style: TextStyle(fontSize: 16),),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(
                    height: 2,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 20,),
                  Container(
                      child: Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(suggestedHobbies.length, (index){
                            return Container(
                                padding: const EdgeInsets.fromLTRB(15,10,15,10),
                                margin: const EdgeInsets.all(5),
                                // margin: const EdgeInsets.only(left: 10),
                                // width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child:GestureDetector(
                                  onTap: (){


                                    setState(() {
                                      saveSuggestedLanguage(index);
                                    });
                                  },
                                  child: Text(suggestedHobbies[index], overflow: TextOverflow.ellipsis,),)
                            );
                          }
                          ))
                  )
                ],
              )
          ),
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