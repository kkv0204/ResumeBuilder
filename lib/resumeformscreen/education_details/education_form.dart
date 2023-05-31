import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:resume_builder/resumeformscreen/education_details/education_switch.dart';
import 'package:resume_builder/resumeformscreen/education_details/add_education.dart';
import 'package:resume_builder/resumeformscreen//text_field_Style.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class EducationForm extends StatefulWidget {
  const EducationForm({Key? key}) : super(key: key);

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {

  bool switchToAdd = false;
  final SharedPreferencesService _prefs = SharedPreferencesService();
  Map<String, dynamic> addMap = {};
  List<dynamic> educationList = [];

  TextEditingController instituteNameController = TextEditingController();
  // TextEditingController startDateController = TextEditingController();
  // TextEditingController endDate = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  late String startDate;
  late String endDate;
  // DateTime? startdate;
  // DateTime? enddate;

  Future saveEducationInfo() async {
    var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/education_details.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.get("userid").toString();
    print(userid);
    print("-----------------------------");

    var response = await http.post(url, body: {
      "u_id":userid.toString(),
      "e_institute_name":instituteNameController.text,
      "s_date": startDate.toString(),
      "e_date": endDate.toString(),
      "e_degree":degreeController.text,
      "e_grade":gradeController.text,
      "e_desc":commentsController.text,
      "is_enabled":"true"
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
          backgroundColor:  Color.fromARGB(255, 0, 121, 139),
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

    Map<String, dynamic> educationInfo = {

      "institute_name":instituteNameController.text,
      "start_date": startDate.toString(),
      "end_date": endDate.toString(),
      "degree":degreeController.text,
      "grade":gradeController.text,
      "comments":commentsController.text
    };
    educationList.add(educationInfo);
    await _prefs.saveToSharedPref('education', jsonEncode(educationList));
  }



  getEducationInfo() async {
    String? educationData = await _prefs.getFromSharedPref('education');
    if(educationData!=null){
      List<dynamic> decodedData = jsonDecode(educationData);
      setState(() {
        educationList = decodedData;
      });
    }
  }

  removeEducation(int index) async {
    String? educationData = await _prefs.getFromSharedPref('education');
    if(educationData!=null){
      List<dynamic> decodedData = jsonDecode(educationData);
      decodedData.removeAt(index);
      await _prefs.saveToSharedPref('education', jsonEncode(decodedData));
    }
  }

  @override
  void initState() {
    super.initState();
    getEducationInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SingleChildScrollView(
          child:
          switchToAdd == false?
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: //Colors.blue
                      Color.fromARGB(255,0,121,139)
                  ),
                  onPressed: () {
                    setState(() {
                      switchToAdd = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Add education"),
                      Icon(Icons.add,color: Colors.black87,)
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *0.8,
                  padding: const EdgeInsets.all(0),
                  child: ListView.builder(
                    itemCount: educationList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(educationList[index]["institute_name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  const SizedBox(height:5),
                                  Text(
                                    '${educationList[index]["start_date"].toString() != null ? DateFormat("dd-MM-yyyy").format(DateTime.parse(educationList[index]["start_date"])) : "-"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${educationList[index]["end_date"].toString() != null ? DateFormat("dd-MM-yyyy").format(DateTime.parse(educationList[index]["end_date"])) : "-"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),                                  const SizedBox(height:5),
                                  Text(educationList[index]["degree"]),
                                  const SizedBox(height:5),
                                  Text(educationList[index]["grade"])
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  removeEducation(index);
                                  setState(() {});
                                },
                                child: const Icon(Icons.delete),
                              )
                            ],
                          )
                      );
                    },
                  ),
                )
              ],
            ),
          ): Container(
            child: SingleChildScrollView(
                child: Form(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: instituteNameController,
                            decoration: textFieldDecoration("Enter your institute name here", "Institute name"),
                            validator: (value){
                              if (instituteNameController.text.isEmpty) {
                                return "Institute name cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.grey[300],
                        //           borderRadius: BorderRadius.circular(10)
                        //       ),
                        //       padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //       width: MediaQuery.of(context).size.width * 0.94,
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             children: <Widget>[
                        //               Icon(
                        //                 Icons.date_range,
                        //                 size: 18.0,
                        //                 color: Color.fromARGB(255, 0, 121, 139),
                        //               ),
                        //               Column(
                        //                 children: [
                        //                   Row(
                        //                     children: [
                        //                       Text(
                        //                         '${startdate != null ? DateFormat("dd-MM-yyyy").format(startdate!) : '-'}' ,
                        //                         style: TextStyle(
                        //                             color: Color.fromARGB(255, 0, 121, 139),
                        //                             fontWeight: FontWeight.bold,
                        //                             fontSize: 18.0),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       Text(' ${enddate != null ? DateFormat("dd-MM-yyyy").format(enddate!) : '-'}',style: TextStyle(
                        //                           color: Color.fromARGB(255, 0, 121, 139),
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 18.0),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //               //   Text(
                        //               //   '${startdate != null ? DateFormat("dd-MM-yyyy").format(startdate!) : '-'} / ${enddate != null ? DateFormat("dd-MM-yyyy").format(enddate!) : '-'}',
                        //               //   style: const TextStyle(
                        //               //     fontWeight: FontWeight.w400,
                        //               //     fontSize: 18,
                        //               //     color: Colors.black,
                        //               //   ),
                        //               // ),
                        //
                        //               Padding(
                        //                 padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        //                 child:
                        //                 ElevatedButton(style: ElevatedButton.styleFrom(
                        //                     primary: //Colors.blue
                        //                     Color.fromARGB(255, 0, 121, 139)
                        //                 ),onPressed: () async{
                        //                   final result=await showDateRangePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now().add(Duration(days: 356),),
                        //                     builder: (context, child) {
                        //                       return Theme(
                        //                         data: Theme.of(context).copyWith(
                        //                           colorScheme: ColorScheme.light(
                        //                             primary: Color.fromARGB(255, 0, 121, 139) ,// <-- SEE HERE
                        //                             onPrimary: Colors.white, // <-- SEE HERE
                        //                             onSurface: Colors.black, // <-- SEE HERE
                        //                           ),
                        //                           textButtonTheme: TextButtonThemeData(
                        //                             style: TextButton.styleFrom(
                        //                               primary: Colors.white, // button text color
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         child: child!,
                        //                       );
                        //                     },
                        //                   );
                        //                   if(result!=null){
                        //                     setState(() {
                        //                       startdate=result.start;
                        //                       enddate=result.end;
                        //                     });
                        //                   }
                        //                 }, child: Text("Date Range Picker")),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: DateTimePicker(
                                decoration: textFieldDecoration("Start date", "Start date"),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                dateLabelText: "Start date",
                                onChanged: (val) {
                                  String formatDate = val.toString();
                                  var pos = formatDate.lastIndexOf(' ');
                                  String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
                                  setState(() {
                                    startDate = result;
                                  });
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: DateTimePicker(
                                decoration: textFieldDecoration("End date", "End date"),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                dateLabelText: "End date",
                                onChanged: (val) {
                                  String formatDate = val.toString();
                                  var pos = formatDate.lastIndexOf(' ');
                                  String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
                                  setState(() {
                                    endDate = result;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: degreeController,
                            decoration: textFieldDecoration("Enter your degree here", "Degree"),
                            validator: (value){
                              if (degreeController.text.length > 50) {
                                return "Degree exceeding the character limit";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: gradeController,
                            decoration: textFieldDecoration("Enter your grade here", "Grade"),
                            validator: (value){
                              if (gradeController.text.length > 50) {
                                return "Grade exceeding the character limit";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: commentsController,
                            decoration: InputDecoration(
                                hintText: "Comments",
                                labelText: "Enter comment here",
                                filled: true,
                                fillColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.black54),
                                focusColor: Colors.black87,
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:// Colors.blue
                                      Color.fromARGB(255,0,121,139)
                                  ),
                                  onPressed: () {
                                    saveEducationInfo();
                                    setState(() {
                                      switchToAdd = false;

                                    });

                                  },
                                  child: const Text("Save details")
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                onPressed: (){

                                  setState(() {
                                    switchToAdd = false;

                                  });

                                },
                                child: const Text("Discard"),
                                style: ElevatedButton.styleFrom(
                                    primary:// Colors.blue
                                    Color.fromARGB(255,0,121,139)
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
            ),
          )
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
