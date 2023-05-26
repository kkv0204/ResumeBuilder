import 'dart:convert';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class CertificateForm extends StatefulWidget {
  const CertificateForm({Key? key}) : super(key: key);

  @override
  State<CertificateForm> createState() => _CertificateFormState();
}

class _CertificateFormState extends State<CertificateForm> {

  bool switchToAdd = false;
  final SharedPreferencesService _prefs = SharedPreferencesService();
  Map<String, dynamic> addMap = {};
  List<dynamic> certificationList = [];

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseIssueDescController = TextEditingController();
  // TextEditingController startDateController = TextEditingController();
  // TextEditingController endDate = TextEditingController();
  TextEditingController linkController = TextEditingController();
  // late String startDate;
  // late String endDate;
  DateTime? startdate;
  DateTime? enddate;

  Future saveCertificationInfo() async {

    var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/certificate_details.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.get("userid").toString();
    print(userid);
    print("-----------------------------");

    var response = await http.post(url, body: {
      "u_id":userid.toString(),
      "c_issue_desc":courseIssueDescController.text,
      "c_coursename":courseNameController.text,
      "c_sdate": startdate.toString(),
      "c_edate": enddate.toString(),
      "c_certificatelink":linkController.text,
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


    Map<String, dynamic> certificationInfo = {
      "issue_desc":courseIssueDescController.text,
      "course_name":courseNameController.text,
      "start_date": startdate.toString(),
      "end_date": enddate.toString(),
      "link":linkController.text
    };
    certificationList.add(certificationInfo);
    await _prefs.saveToSharedPref('certification', jsonEncode(certificationList));
  }



  getCertificationInfo() async {
    String? certificationData = await _prefs.getFromSharedPref('certification');
    if(certificationData!=null){
      List<dynamic> decodedData = jsonDecode(certificationData);
      setState(() {
        certificationList = decodedData;
      });
    }
  }

  removeCertification(int index) async {
    String? certificationData = await _prefs.getFromSharedPref('certification');
    if(certificationData!=null){
      List<dynamic> decodedData = jsonDecode(certificationData);
      decodedData.removeAt(index);
      await _prefs.saveToSharedPref('certification', jsonEncode(decodedData));
      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCertificationInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
onWillPop: () => _onBackButtonPressed(context),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                      Color.fromARGB(255, 0, 121, 139)
                  ),
                  onPressed: () {
                    setState(() {
                      switchToAdd = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Add certification"),
                      Icon(Icons.add,color: Colors.black87,)
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *0.8,
                  padding: const EdgeInsets.all(0),
                  child: ListView.builder(
                    itemCount: certificationList.length,
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
                                  Text(certificationList[index]["issue_desc"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  Text(certificationList[index]["course_name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  const SizedBox(height:5),
                                  Text(
                                    '${certificationList[index]["start_date"].toString() != null ? DateFormat("dd-MM-yyyy").format(DateTime.parse(certificationList[index]["start_date"])) : "-"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${certificationList[index]["end_date"].toString() != null ? DateFormat("dd-MM-yyyy").format(DateTime.parse(certificationList[index]["end_date"])) : "-"}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(certificationList[index]["link"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),

                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  removeCertification(index);
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
                            controller: courseIssueDescController,
                            decoration: textFieldDecoration("Enter your issuer description here", "Issuer Description"),
                            validator: (value){
                              if (courseIssueDescController.text.isEmpty) {
                                return "course name cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: courseNameController,
                            decoration: textFieldDecoration("Enter your course name here", "Course Name"),
                            validator: (value){
                              if (courseNameController.text.isEmpty) {
                                return "course name cannot be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              width: MediaQuery.of(context).size.width * 0.94,
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Color.fromARGB(255, 0, 121, 139),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${startdate != null ? DateFormat("dd-MM-yyyy").format(startdate!) : '-'}' ,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(255, 0, 121, 139),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(' ${enddate != null ? DateFormat("dd-MM-yyyy").format(enddate!) : '-'}',style: TextStyle(
                                                      color: Color.fromARGB(255, 0, 121, 139),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                    //   Text(
                                    //   '${startdate != null ? DateFormat("dd-MM-yyyy").format(startdate!) : '-'} / ${enddate != null ? DateFormat("dd-MM-yyyy").format(enddate!) : '-'}',
                                    //   style: const TextStyle(
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 18,
                                    //     color: Colors.black,
                                    //   ),
                                    // ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child:
                                        ElevatedButton(style: ElevatedButton.styleFrom(
                                            primary: //Colors.blue
                                            Color.fromARGB(255, 0, 121, 139)
                                        ),onPressed: () async{
                                          final result=await showDateRangePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now().add(Duration(days: 356),),
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: ColorScheme.light(
                                                    primary: Color.fromARGB(255, 0, 121, 139) ,// <-- SEE HERE
                                                    onPrimary: Colors.white, // <-- SEE HERE
                                                    onSurface: Colors.black, // <-- SEE HERE
                                                  ),
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.white, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if(result!=null){
                                            setState(() {
                                              startdate=result.start;
                                              enddate=result.end;
                                            });
                                          }
                                        }, child: Text("Date Range Picker")),
                                      ),
                                        ],
                                      ),
                                    ],
                              ),
                            ),
                          ],
                        ),
                                        // ElevatedButton(
                                        //   style: ElevatedButton.styleFrom(
                                        //       primary: //Colors.blue
                                        //       Color.fromARGB(255, 0, 121, 139)
                                        //   ),
                                        //
                                        //   onPressed: () async{
                                        //   DateTime startDate = DateTime.now();
                                        //   TimeOfDay startTime = TimeOfDay.now();
                                        //   DateTime endDate = DateTime.now().add(Duration(days: 1));
                                        //   TimeOfDay endTime = TimeOfDay.fromDateTime(endDate);
                                        //   showCustomDateRangePicker(
                                        //     context,
                                        //     dismissible: true,
                                        //     minimumDate: DateTime.now().subtract(Duration(days: 365)),
                                        //     maximumDate: DateTime.now().add(Duration(days: 365)),
                                        //     endDate: enddate ?? DateTime.now(), // Add time to endDate parameter
                                        //     startDate: startdate ?? DateTime.now(),
                                        //     // endDate: enddate,
                                        //     // startDate: startdate,
                                        //     backgroundColor: Colors.white,
                                        //     primaryColor: Colors.green,
                                        //     onApplyClick: (start, end) {
                                        //       setState(() {
                                        //         enddate = DateTime(end.year, end.month, end.day,);
                                        //         startdate = DateTime(start.year, start.month, start.day);
                                        //         // enddate = end;
                                        //         // startdate = start;
                                        //       });
                                        //     },
                                        //     onCancelClick: () {
                                        //       setState(() {
                                        //         enddate = null;
                                        //         startdate = null;
                                        //       });
                                        //     },
                                        //   );
                                        // }, child: Text("Add Date"),),

                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: Colors.grey[300],
                            //       borderRadius: BorderRadius.circular(10)
                            //   ),
                            //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            //   width: MediaQuery.of(context).size.width * 0.45,
                            //   child:
                            //   DateTimePicker(
                            //     decoration: textFieldDecoration("Start date", "Start date"),
                            //     firstDate: DateTime(1900),
                            //     lastDate: DateTime.now(),
                            //     dateLabelText: "Start date",
                            //     onChanged: (val) {
                            //       String formatDate = val.toString();
                            //       var pos = formatDate.lastIndexOf(' ');
                            //       String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
                            //       setState(() {
                            //         startDate = result;
                            //       });
                            //     },
                            //   ),
                            // ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: Colors.grey[300],
                            //       borderRadius: BorderRadius.circular(10)
                            //   ),
                            //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            //   width: MediaQuery.of(context).size.width * 0.45,
                            //   child: DateTimePicker(
                            //     decoration: textFieldDecoration("End date", "End date"),
                            //     firstDate: DateTime(1900),
                            //     lastDate: DateTime.now(),
                            //     dateLabelText: "End date",
                            //     onChanged: (val) {
                            //       String formatDate = val.toString();
                            //       var pos = formatDate.lastIndexOf(' ');
                            //       String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
                            //       setState(() {
                            //         endDate = result;
                            //       });
                            //     },
                            //   ),
                            // ),
                        const SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          // height: MediaQuery.of(context).size.height * 0.25,
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255,0,121,139),
                            controller: linkController,
                            decoration: InputDecoration(
                                hintText: "Enter comment here",
                                labelText: "Certificate link",
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
                                      primary: //Colors.blue
                                      Color.fromARGB(255, 0, 121, 139)
                                  ),
                                  onPressed: () {
                                    saveCertificationInfo();
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
                                  style: ElevatedButton.styleFrom(
                                      primary: //Colors.blue
                                      Color.fromARGB(255, 0, 121, 139)
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      switchToAdd = false;
                                    });
                                  },
                                  child: const Text("Discard")
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



















// import 'dart:convert';
// import 'package:custom_date_range_picker/custom_date_range_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
// import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:http/http.dart'as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class CertificateForm extends StatefulWidget {
//   const CertificateForm({Key? key}) : super(key: key);
//
//   @override
//   State<CertificateForm> createState() => _CertificateFormState();
// }
//
// class _CertificateFormState extends State<CertificateForm> {
//
//   bool switchToAdd = false;
//   final SharedPreferencesService _prefs = SharedPreferencesService();
//   Map<String, dynamic> addMap = {};
//   List<dynamic> certificationList = [];
//
//   TextEditingController courseNameController = TextEditingController();
//   // TextEditingController startDateController = TextEditingController();
//   // TextEditingController endDate = TextEditingController();
//   TextEditingController courseIssueDescController = TextEditingController();
//   TextEditingController linkController = TextEditingController();
//   //late String startDate;
//   //late String endDate;
//   DateTime? startdate;
//   DateTime? enddate;
//
//   Future saveCertificationInfo() async {
//
//     var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/certificate_details.php');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userid = prefs.get("userid").toString();
//     print(userid);
//     print("-----------------------------");
//
//     var response = await http.post(url, body: {
//       "u_id":userid.toString(),
//       "c_coursename":courseNameController.text,
//       "c_issue_desc":courseIssueDescController.text,
//       "c_sdate": startdate.toString(),
//       "c_edate": enddate.toString(),
//       "c_certificatelink":linkController.text,
//       "is_enabled":"true"
//     });
//     print("--------------");
//     print(response.body);
//     print(response);
//     print(response.statusCode);
//     print("--------------");
//
//
//     var data = json.decode(response.body);
//
//     if (data == "Error") {
//       Fluttertoast.showToast(
//           msg: "Info Already exist!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//
//       );
//     } else {
//       // final prefs = await SharedPreferences.getInstance();
//       // await prefs.setInt("u_id",1);
//       Fluttertoast.showToast(
//           msg: "Data Inserted Successful",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//
//       );
//
//     }
//
//     Map<String, dynamic> certificationInfo = {
//       "issue_desc":courseIssueDescController.text,
//       "course_name":courseNameController.text,
//       "start_date": startdate,
//       "end_date": enddate,
//       "link":linkController.text
//     };
//     certificationList.add(certificationInfo);
//     await _prefs.saveToSharedPref('certification', jsonEncode(certificationList));
//   }
//
//   getCertificationInfo() async {
//     String? certificationData = await _prefs.getFromSharedPref('certification');
//     if(certificationData!=null){
//       List<dynamic> decodedData = jsonDecode(certificationData);
//       setState(() {
//         certificationList = decodedData;
//       });
//     }
//   }
//
//   removeCertification(int index) async {
//     String? certificationData = await _prefs.getFromSharedPref('certification');
//     if(certificationData!=null){
//       List<dynamic> decodedData = jsonDecode(certificationData);
//       decodedData.removeAt(index);
//       await _prefs.saveToSharedPref('certification', jsonEncode(decodedData));
//       setState(() {
//
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getCertificationInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child:
//         switchToAdd == false?
//         Container(
//           padding: EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     primary: //Colors.blue
//                     Color.fromARGB(255, 0, 121, 139)
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     switchToAdd = true;
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text("Add certification"),
//                     Icon(Icons.add,color: Colors.black87,)
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height *0.8,
//                 padding: const EdgeInsets.all(0),
//                 child: ListView.builder(
//                   itemCount: certificationList.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                         padding: const EdgeInsets.all(15),
//                         margin: const EdgeInsets.only(top: 10),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child:Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(certificationList[index]["issue_desc"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
//                                 Text(certificationList[index]["course_name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
//                                 const SizedBox(height:5),
//                                 Text("${certificationList[index]["start_date"]} - ${certificationList[index]["end_date"]}"),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: (){
//                                 removeCertification(index);
//                                 setState(() {});
//                               },
//                               child: const Icon(Icons.delete),
//                             )
//                           ],
//                         )
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ): Container(
//           child: SingleChildScrollView(
//               child: Form(
//                 child: Container(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 30,),
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: courseIssueDescController,
//                           decoration: textFieldDecoration("Enter your issuer description here", "Issuer Description"),
//                           validator: (value){
//                             if (courseIssueDescController.text.isEmpty) {
//                               return "course issuer description cannot be empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 30,),
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: courseNameController,
//                           decoration: textFieldDecoration("Enter your course name here", "Course Name"),
//                           validator: (value){
//                             if (courseNameController.text.isEmpty) {
//                               return "course name cannot be empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                             width: MediaQuery.of(context).size.width * 0.90,
//                             // child: DateTimePicker(
//                             //   decoration: textFieldDecoration("Start date", "Start date"),
//                             //   firstDate: DateTime(1900),
//                             //   lastDate: DateTime.now(),
//                             //   dateLabelText: "Start date",
//                             //   onChanged: (val) {
//                             //     String formatDate = val.toString();
//                             //     var pos = formatDate.lastIndexOf(' ');
//                             //     String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
//                             //     setState(() {
//                             //       startDate = result;
//                             //     });
//                             //   },
//                             // ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                 '${startdate != null ? DateFormat("dd-MM-yyyy").format(startdate!) : '-'} / ${enddate != null ? DateFormat("dd-MM-yyyy").format(enddate!) : '-'}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                                 ElevatedButton(onPressed: () async{
//                                   DateTime startDate = DateTime.now();
//                                   TimeOfDay startTime = TimeOfDay.now();
//                                   DateTime endDate = DateTime.now().add(Duration(days: 1));
//                                   TimeOfDay endTime = TimeOfDay.fromDateTime(endDate);
//                                   showCustomDateRangePicker(
//                                     context,
//                                     dismissible: true,
//                                     minimumDate: DateTime.now().subtract(Duration(days: 365)),
//                                     maximumDate: DateTime.now().add(Duration(days: 365)),
//                                     endDate: enddate ?? DateTime.now(), // Add time to endDate parameter
//                                     startDate: startdate ?? DateTime.now(),
//                                     // endDate: enddate,
//                                     // startDate: startdate,
//                                     backgroundColor: Colors.white,
//                                     primaryColor: Colors.green,
//                                     onApplyClick: (start, end) {
//                                       setState(() {
//                                         enddate = DateTime(end.year, end.month, end.day,);
//                                         startdate = DateTime(start.year, start.month, start.day);
//                                         // enddate = end;
//                                         // startdate = start;
//                                       });
//                                     },
//                                     onCancelClick: () {
//                                       setState(() {
//                                         enddate = null;
//                                         startdate = null;
//                                       });
//                                     },
//                                   );
//                                   // final result=await showDateRangePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime.now().add(Duration(days: 356),),);
//                                   // if(result!=null){
//                                   //   setState(() {
//                                   //     startdate=result.start;
//                                   //     enddate=result.end;
//                                   //   });
//                                   // }
//                                 }, child: Text("Date Range Picker"),),
//                               ],
//                             ),
//                           ),
//                           // Container(
//                           //   decoration: BoxDecoration(
//                           //       color: Colors.grey[300],
//                           //       borderRadius: BorderRadius.circular(10)
//                           //   ),
//                           //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                           //   width: MediaQuery.of(context).size.width * 0.45,
//                           //   child: DateTimePicker(
//                           //     decoration: textFieldDecoration("End date", "End date"),
//                           //     firstDate: DateTime(1900),
//                           //     lastDate: DateTime.now(),
//                           //     dateLabelText: "End date",
//                           //     onChanged: (val) {
//                           //       String formatDate = val.toString();
//                           //       var pos = formatDate.lastIndexOf(' ');
//                           //       String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
//                           //       setState(() {
//                           //         endDate = result;
//                           //       });
//                           //     },
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       const SizedBox(height: 20,),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         // height: MediaQuery.of(context).size.height * 0.25,
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: linkController,
//                           decoration: InputDecoration(
//                               hintText: "Enter comment here",
//                               labelText: "Certificate link",
//                               filled: true,
//                               fillColor: Colors.grey[300],
//                               labelStyle: TextStyle(color: Colors.black54),
//                               focusColor: Colors.black87,
//                               contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               border: InputBorder.none
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: //Colors.blue
//                                     Color.fromARGB(255, 0, 121, 139)
//                                 ),
//                                 onPressed: () {
//                                   saveCertificationInfo();
//                                   setState(() {
//                                     switchToAdd = false;
//                                   });
//                                 },
//                                 child: const Text("Save details")
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: //Colors.blue
//                                     Color.fromARGB(255, 0, 121, 139)
//                                 ),
//                                 onPressed: (){
//                                   setState(() {
//                                     switchToAdd = false;
//                                   });
//                                 },
//                                 child: const Text("Discard")
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//           ),
//         )
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
// import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:http/http.dart'as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class CertificateForm extends StatefulWidget {
//   const CertificateForm({Key? key}) : super(key: key);
//
//   @override
//   State<CertificateForm> createState() => _CertificateFormState();
// }
//
// class _CertificateFormState extends State<CertificateForm> {
//
//   bool switchToAdd = false;
//   final SharedPreferencesService _prefs = SharedPreferencesService();
//   Map<String, dynamic> addMap = {};
//   List<dynamic> certificationList = [];
//
//   TextEditingController courseNameController = TextEditingController();
//   TextEditingController courseIssueDescController = TextEditingController();
//   // TextEditingController startDateController = TextEditingController();
//   // TextEditingController endDate = TextEditingController();
//   TextEditingController linkController = TextEditingController();
//   late String startDate;
//   late String endDate;
//
//   Future saveCertificationInfo() async {
//
//     var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/certificate_details.php');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userid = prefs.get("userid").toString();
//     print(userid);
//     print("-----------------------------");
//
//     var response = await http.post(url, body: {
//       "u_id":userid.toString(),
//       "c_issue_desc":courseIssueDescController.text,
//       "c_coursename":courseNameController.text,
//       "c_sdate": startDate.toString(),
//       "c_edate": endDate.toString(),
//       "c_certificatelink":linkController.text,
//       "is_enabled":"true"
//     });
//     print("--------------");
//     print(response.body);
//     print(response);
//     print(response.statusCode);
//     print("--------------");
//
//
//     var data = json.decode(response.body);
//
//     if (data == "Error") {
//       Fluttertoast.showToast(
//           msg: "Info Already exist!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//
//       );
//     } else {
//       // final prefs = await SharedPreferences.getInstance();
//       // await prefs.setInt("u_id",1);
//       Fluttertoast.showToast(
//           msg: "Data Inserted Successful",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//
//       );
//
//     }
//
//
//     Map<String, dynamic> certificationInfo = {
//       "issue_desc":courseIssueDescController.text,
//       "course_name":courseNameController.text,
//       "start_date": startDate,
//       "end_date": endDate,
//       "link":linkController.text
//     };
//     certificationList.add(certificationInfo);
//     await _prefs.saveToSharedPref('certification', jsonEncode(certificationList));
//   }
//
//
//
//   getCertificationInfo() async {
//     String? certificationData = await _prefs.getFromSharedPref('certification');
//     if(certificationData!=null){
//       List<dynamic> decodedData = jsonDecode(certificationData);
//       setState(() {
//         certificationList = decodedData;
//       });
//     }
//   }
//
//   removeCertification(int index) async {
//     String? certificationData = await _prefs.getFromSharedPref('certification');
//     if(certificationData!=null){
//       List<dynamic> decodedData = jsonDecode(certificationData);
//       decodedData.removeAt(index);
//       await _prefs.saveToSharedPref('certification', jsonEncode(decodedData));
//       setState(() {
//
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getCertificationInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//         child:
//         switchToAdd == false?
//         Container(
//           padding: EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     primary: //Colors.blue
//                     Color.fromARGB(255, 0, 121, 139)
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     switchToAdd = true;
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text("Add certification"),
//                     Icon(Icons.add,color: Colors.black87,)
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height *0.8,
//                 padding: const EdgeInsets.all(0),
//                 child: ListView.builder(
//                   itemCount: certificationList.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                         padding: const EdgeInsets.all(15),
//                         margin: const EdgeInsets.only(top: 10),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child:Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(certificationList[index]["issue_desc"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
//                                 Text(certificationList[index]["course_name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
//                                 const SizedBox(height:5),
//                                 Text("${certificationList[index]["start_date"]} - ${certificationList[index]["end_date"]}"),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: (){
//                                 removeCertification(index);
//                                 setState(() {});
//                               },
//                               child: const Icon(Icons.delete),
//                             )
//                           ],
//                         )
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ): Container(
//           child: SingleChildScrollView(
//               child: Form(
//                 child: Container(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 30,),
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: courseIssueDescController,
//                           decoration: textFieldDecoration("Enter your issuer description here", "Issuer Description"),
//                           validator: (value){
//                             if (courseIssueDescController.text.isEmpty) {
//                               return "course name cannot be empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 30,),
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: courseNameController,
//                           decoration: textFieldDecoration("Enter your course name here", "Course Name"),
//                           validator: (value){
//                             if (courseNameController.text.isEmpty) {
//                               return "course name cannot be empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: DateTimePicker(
//                               decoration: textFieldDecoration("Start date", "Start date"),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                               dateLabelText: "Start date",
//                               onChanged: (val) {
//                                 String formatDate = val.toString();
//                                 var pos = formatDate.lastIndexOf(' ');
//                                 String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
//                                 setState(() {
//                                   startDate = result;
//                                 });
//                               },
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: DateTimePicker(
//                               decoration: textFieldDecoration("End date", "End date"),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                               dateLabelText: "End date",
//                               onChanged: (val) {
//                                 String formatDate = val.toString();
//                                 var pos = formatDate.lastIndexOf(' ');
//                                 String result = (pos != -1)? formatDate.substring(0, pos): formatDate;
//                                 setState(() {
//                                   endDate = result;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20,),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                         // height: MediaQuery.of(context).size.height * 0.25,
//                         child: TextFormField(
//                           cursorColor: Color.fromARGB(255,0,121,139),
//                           controller: linkController,
//                           decoration: InputDecoration(
//                               hintText: "Enter comment here",
//                               labelText: "Certificate link",
//                               filled: true,
//                               fillColor: Colors.grey[300],
//                               labelStyle: TextStyle(color: Colors.black54),
//                               focusColor: Colors.black87,
//                               contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               border: InputBorder.none
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: //Colors.blue
//                                     Color.fromARGB(255, 0, 121, 139)
//                                 ),
//                                 onPressed: () {
//                                   saveCertificationInfo();
//                                   setState(() {
//                                     switchToAdd = false;
//                                   });
//                                 },
//                                 child: const Text("Save details")
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: //Colors.blue
//                                     Color.fromARGB(255, 0, 121, 139)
//                                 ),
//                                 onPressed: (){
//                                   setState(() {
//                                     switchToAdd = false;
//                                   });
//                                 },
//                                 child: const Text("Discard")
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//           ),
//         )
//     );
//   }
// }
