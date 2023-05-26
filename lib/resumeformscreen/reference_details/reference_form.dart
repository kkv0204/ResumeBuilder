import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../templatescreen/home_page.dart';
import 'package:flutter/services.dart';

//import 'package:resume_builder/resumeformscreen/personal_details/personal_form.dart';


class SocialsForm extends StatefulWidget {
  const SocialsForm({Key? key}) : super(key: key);

  @override
  State<SocialsForm> createState() => SocialsFormState();
}

class SocialsFormState extends State<SocialsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController referencenameController = TextEditingController();
  TextEditingController referencejobController = TextEditingController();
  TextEditingController referencecompanyController = TextEditingController();
  TextEditingController referenceemailController = TextEditingController();
  TextEditingController referencephoneController = TextEditingController();

 Future savesocialInfo() async {
   var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/reference_details.php');
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String userid = prefs.get("userid").toString();
   print(userid);
   print("-----------------------------");

   var response = await http.post(url, body: {
     "u_id":userid.toString(),
     "r_name": referencenameController.text,
     "r_job": referencejobController.text,
     "r_company": referencecompanyController.text,
     "r_email": referenceemailController.text,
     "r_phone": referencephoneController.text,
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

    SharedPreferencesService _prefs = SharedPreferencesService();
    Map<String, dynamic> socialData = {
      "referencename": referencenameController.text,
      "referencejob": referencejobController.text,
      "referencecompany": referencecompanyController.text,
      "referenceemail": referenceemailController.text,
      "referencephone": referencephoneController.text,
      "is_enabled": true
    };
    await _prefs.saveToSharedPref('social-data', jsonEncode(socialData));
    String? personalData = await _prefs.getFromSharedPref('personal-data');
    if (personalData != null) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    }
  }

  // Future savesocialInfoDB() async {
  //
  // }



  getsocialInfo() async {
    SharedPreferencesService _prefs = SharedPreferencesService();
    String? socialData = await _prefs.getFromSharedPref('social-data');
    if (socialData != null) {
      Map<String, dynamic> decodedData = jsonDecode(socialData);
      setState(() {
        referencenameController.text = decodedData["referencename"];
        referencejobController.text = decodedData["referencejob"];
        referencecompanyController.text = decodedData["referencecompany"];
        referenceemailController.text = decodedData["referenceemail"];
        referencephoneController.text = decodedData["referencephone"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getsocialInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: referencenameController,
                      validator: (value) {
                        if (referencenameController.text.isEmpty) {
                          return "referer name field cannot be empty";
                        } else if (referencenameController.text.length >= 100) {
                          return "referer name cannot be exceed 100 characters";
                        }
                        return null;
                      },
                      decoration:
                          textFieldDecoration("Enter Name", "Referer Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: referencejobController,
                      validator: (value) {
                        if (referencejobController.text.isEmpty) {
                          return "referer job field cannot be empty";
                        } else if (referencejobController.text.length >= 100) {
                          return "referer job cannot be exceed 100 characters";
                        }
                        return null;
                      },
                      decoration:
                          textFieldDecoration("Enter Job", "Referer Job"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: referencecompanyController,
                      validator: (value) {
                        if (referencecompanyController.text.isEmpty) {
                          return "referer company name field cannot be empty";
                        } else if (referencecompanyController.text.length >=
                            100) {
                          return "referer company name cannot be exceed 100 characters";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter Company Name", "Referer Company Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: referenceemailController,
                      validator: (value) {
                        String useremail = referenceemailController.text.trim();
                        String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        if(referenceemailController.text.isEmpty) {
                          return "Email field cannot be empty";
                        }
                        else if (!RegExp(emailPattern).hasMatch(useremail )) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      decoration:
                          textFieldDecoration("Enter Email", "Referer Email"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255,0,121,139),
                      controller: referencephoneController,
                      inputFormatters: [PhoneInputFormatter()],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (referencephoneController.text.isEmpty) {
                          return "Mobile number cannot be empty";
                        } else if (referencephoneController.text.length > 10) {
                          return "Mobile number cannot be greater than 10 digits";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter phone number", "Referer Phone number"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary:
                      //Colors.blue
                      Color.fromARGB(255, 0, 121, 139)),
                      onPressed: () {
                       // PersonalFormState personalFormState = PersonalFormState();
                        // personalFormState.savePersonalInfoDB();
                        if(_formKey.currentState!.validate()){
                          savesocialInfo();
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: const Text(
                            'Generate resume',
                            style: TextStyle(fontSize: 16),
                          )))
                ],
              ),
            )),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context)async {
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
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 10) {
      return oldValue;
    }
    return newValue;
  }
}
