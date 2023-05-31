import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({Key? key}) : super(key: key);

  @override
  State<PersonalForm> createState() => PersonalFormState();
}

class PersonalFormState extends State<PersonalForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCityValue;
  String? selectedStateValue;
  List<String> city = [
    'Ahmedabad',
    'Rajkot',
    'Vadodara',
    'Mumbai',
    'Chennai',
    'Patna',
    'Surat',
  ];
  List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Lakshadweep',
    'Puducherry',
  ];

  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController socialmediaController = TextEditingController();

  Future savePersonalInfo() async {
    var url = Uri.parse(
        'https://testresumebuilder.000webhostapp.com/capstone/personal_details.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.get("userid").toString();
    print(userid);
    print("-----------------------------");

    var response = await http.post(url, body: {
      "u_id": userid.toString(),
      "f_name": fnameController.text,
      "m_name": mnameController.text,
      "l_name": lnameController.text,
      "p_email": emailController.text,
      "p_mobile": mobileController.text,
      "p_flat_p_house": flatController.text,
      "p_area": areaController.text,
      "p_landmark": landmarkController.text,
      "p_city": selectedCityValue.toString(),
      "p_state": selectedStateValue.toString(),
      "p_pincode": pincodeController.text,
      "p_socialmedia": socialmediaController.text,
      "is_enabled": "true"
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
          fontSize: 16.0);
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
          fontSize: 16.0);
    }

    SharedPreferencesService _prefs = SharedPreferencesService();
    Map<String, dynamic> personalData = {
      "fname": fnameController.text,
      "mname": mnameController.text,
      "lname": lnameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "flat/house": flatController.text,
      "area": areaController.text,
      "landmark": landmarkController.text,
      "city": selectedCityValue.toString(),
      "state": selectedStateValue.toString(),
      "pincode": pincodeController.text,
      "socialmedia": socialmediaController.text,
      "is_enabled": true
    };
    await _prefs.saveToSharedPref('personal-data', jsonEncode(personalData));
  }

  // Future savePersonalInfoDB() async {
  //
  // }

  getPersonalInfo() async {
    SharedPreferencesService _prefs = SharedPreferencesService();
    String? personalData = await _prefs.getFromSharedPref('personal-data');
    if (personalData != null) {
      Map<String, dynamic> decodedData = jsonDecode(personalData);
      setState(() {
        fnameController.text = decodedData["fname"];
        mnameController.text = decodedData["mname"];
        lnameController.text = decodedData["lname"];
        emailController.text = decodedData["email"];
        mobileController.text = decodedData["mobile"];
        flatController.text = decodedData["flat/house"];
        areaController.text = decodedData["area"];
        landmarkController.text = decodedData["landmark"];
        cityController.text = decodedData["city"];
        stateController.text = decodedData["state"];
        pincodeController.text = decodedData["pincode"];
        socialmediaController.text = decodedData["socialmedia"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPersonalInfo();
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: fnameController,
                      validator: (value) {
                        if (fnameController.text.isEmpty) {
                          return "Name field cannot be empty";
                        } else if (fnameController.text.length >= 100) {
                          return "Name cannot be exceed 100 characters";
                        }
                        return null;
                      },
                      decoration:
                      textFieldDecoration("First Name", "First Name"),
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: mnameController,
                      // validator: (value){
                      //   if(mnameController.text.isEmpty){
                      //     return "Name field cannot be empty";
                      //   }else if(mnameController.text.length >=100){
                      //     return "Name cannot be exceed 100 characters";
                      //   }
                      //   return null;
                      // },
                      decoration:
                      textFieldDecoration("Middle Name", " Middle Name"),
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: lnameController,
                      validator: (value) {
                        if (lnameController.text.isEmpty) {
                          return "Name field cannot be empty";
                        } else if (lnameController.text.length >= 100) {
                          return "Name cannot be exceed 100 characters";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration("Last Name", "Last Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: emailController,
                      validator: (value) {
                        String useremail = emailController.text.trim();
                        String emailPattern =
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        if (emailController.text.isEmpty) {
                          return "Email field cannot be empty";
                        } else if (!RegExp(emailPattern).hasMatch(useremail)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      decoration:
                      textFieldDecoration("Enter your email", "Email"),
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: mobileController,
                      inputFormatters: [PhoneInputFormatter()],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (mobileController.text.isEmpty) {
                          return "Mobile number cannot be empty";
                        } else if (mobileController.text.length > 10) {
                          return "Mobile number cannot be greater than 10 digits";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter your mobile number", "Mobile Number"),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // aiya drop down for states

                  Container(
                    child: Column(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                // Icon(
                                //   Icons.list,
                                //   size: 20,
                                //   color: Colors.black54,
                                // ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select State',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: states
                                .map((states) => DropdownMenuItem<String>(
                              value: states,
                              child: Text(
                                states,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedStateValue,
                            onChanged: (value) {
                              setState(() {
                                selectedStateValue = value as String;
                              });
                            },
                            icon: const Icon(
                              Icons.expand_circle_down,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey[300],
                            buttonHeight: 50,
                            buttonWidth: 400,
                            buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              color: Colors.grey,
                            ).copyWith(
                                boxShadow: kElevationToShadow[0],
                                color: Colors.grey[300]),
                            itemHeight: 40,
                            itemPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                            dropdownMaxHeight: 200,
                            dropdownDecoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 320, 5),
                        //   child: Text("City",style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(255,0,121,139),fontSize: 15 ),),
                        // ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                // Icon(
                                //   Icons.list,
                                //   size: 20,
                                //   color: Colors.black54,
                                // ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select City',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: city
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedCityValue,
                            onChanged: (value) {
                              setState(() {
                                selectedCityValue = value as String;
                              });
                            },
                            icon: const Icon(
                              Icons.expand_circle_down,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                            buttonHeight: 50,
                            buttonWidth: 400,
                            buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              color: Colors.grey,
                            ).copyWith(
                              boxShadow: kElevationToShadow[0],
                              color: Colors.grey[300],
                            ),
                            itemHeight: 40,
                            itemPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                            dropdownMaxHeight: 200,
                            dropdownDecoration: BoxDecoration(
                              color: Colors.blueGrey,
                            ),
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                          ),
                        ),
                      ],
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: flatController,
                      validator: (value) {
                        if (flatController.text.isEmpty) {
                          return "Flat/House No field cannot be empty";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter your flat/house no", "Flat/House No"),
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: areaController,
                      validator: (value) {
                        if (areaController.text.isEmpty) {
                          return "Area cannot be empty";
                        }
                        return null;
                      },
                      decoration:
                      textFieldDecoration("Enter your area", "Area"),
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
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      controller: landmarkController,
                      validator: (value) {
                        if (landmarkController.text.isEmpty) {
                          return "landmark cannot be empty";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter your landmark", "Landmark"),
                    ),
                  ),


                  // Container(
                  //   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[300],
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: TextFormField(
                  //     cursorColor: Color.fromARGB(255,0,121,139),
                  //     controller: cityController,
                  //     validator: (value){
                  //       if(cityController.text.isEmpty){
                  //         return "city cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: textFieldDecoration("Enter your city", "City"),
                  //   ),
                  // ),



                  //Orignal code of State form field
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[300],
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: TextFormField(
                  //     cursorColor: Color.fromARGB(255,0,121,139),
                  //     controller: stateController,
                  //     validator: (value){
                  //       if(stateController.text.isEmpty){
                  //         return "State cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: textFieldDecoration("Enter your state", "State"),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      keyboardType: TextInputType.number,
                      controller: pincodeController,
                      inputFormatters: [ZipInputFormatter()],
                      validator: (value) {
                        if (pincodeController.text.isEmpty) {
                          return "Pincode cannot be empty";
                        }
                        return null;
                      },
                      decoration:
                      textFieldDecoration("Enter your pincode", "Pincode"),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: socialmediaController,
                      cursorColor: Color.fromARGB(255, 0, 121, 139),
                      validator: (value) {
                        if (socialmediaController.text.isEmpty) {
                          return "social media cannot be empty";
                        }
                        return null;
                      },
                      decoration: textFieldDecoration(
                          "Enter your LinkedIn/GitHub", "LinkedIn/GitHub URL"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: //Colors.blue
                          Color.fromARGB(255, 0, 121, 139)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          savePersonalInfo();
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: const Text(
                            'Save details',
                            style: TextStyle(fontSize: 16),
                          )))
                ],
              ),
            )),
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

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 10) {
      return oldValue;
    }
    return newValue;
  }
}

class ZipInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 6) {
      return oldValue;
    }
    return newValue;
  }
}

// import 'dart:convert';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:resume_builder/resumeformscreen/text_field_Style.dart';
// import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
// import 'package:http/http.dart'as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class  PersonalForm extends StatefulWidget {
//   const PersonalForm({Key? key}) : super(key: key);
//
//   @override
//   State<PersonalForm> createState() => PersonalFormState();
// }
//
// class PersonalFormState extends State<PersonalForm> {
//
//   final _formKey = GlobalKey<FormState>();
//   String? selectedCityValue;
//   List<String> items = [
//     'Ahmedabad',
//     'Rajkot',
//     'Vadodara',
//     'Mumbai',
//     'Chennai',
//     'Patna',
//     'Surat',
//   ];
//   TextEditingController fnameController = TextEditingController();
//   TextEditingController mnameController = TextEditingController();
//   TextEditingController lnameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController flatController = TextEditingController();
//   TextEditingController areaController = TextEditingController();
//   TextEditingController landmarkController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController pincodeController = TextEditingController();
//   TextEditingController socialmediaController = TextEditingController();
//
//
//    Future savePersonalInfo() async {
//      var url = Uri.parse('https://testresumebuilder.000webhostapp.com/capstone/personal_details.php');
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      String userid = prefs.get("userid").toString();
//      print(userid);
//      print("-----------------------------");
//
//      var response = await http.post(url, body: {
//        "u_id":userid.toString(),
//        "f_name":fnameController.text,
//        "m_name":mnameController.text,
//        "l_name":lnameController.text,
//        "p_email":emailController.text,
//        "p_mobile":mobileController.text,
//        "p_flat_p_house":flatController.text,
//        "p_area":areaController.text,
//        "p_landmark":landmarkController.text,
//        "p_city":cityController.text,
//        "p_state":stateController.text,
//        "p_pincode":pincodeController.text,
//        "p_socialmedia":socialmediaController.text,
//        "is_enabled":"true"
//      });
//      print("--------------");
//      print(response.body);
//      print(response);
//      print(response.statusCode);
//      print("--------------");
//
//
//      var data = json.decode(response.body);
//
//      if (data == "Error") {
//        Fluttertoast.showToast(
//            msg: "Info Already exist!",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIosWeb: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 16.0
//
//        );
//      } else {
//        // final prefs = await SharedPreferences.getInstance();
//        // await prefs.setInt("u_id",1);
//        Fluttertoast.showToast(
//            msg: "Data Inserted Successful",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIosWeb: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 16.0
//
//        );
//
//      }
//
//
//     SharedPreferencesService _prefs = SharedPreferencesService();
//     Map<String, dynamic> personalData = {
//       "fname":fnameController.text,
//       "mname":mnameController.text,
//       "lname":lnameController.text,
//       "email":emailController.text,
//       "mobile":mobileController.text,
//       "flat/house":flatController.text,
//       "area":areaController.text,
//       "landmark":landmarkController.text,
//       "city":cityController.text,
//       "state":stateController.text,
//       "pincode":pincodeController.text,
//       "socialmedia":socialmediaController.text,
//       "is_enabled":true
//     };
//     await _prefs.saveToSharedPref('personal-data', jsonEncode(personalData));
//   }
//
//   // Future savePersonalInfoDB() async {
//   //
//   // }
//
//   getPersonalInfo() async {
//     SharedPreferencesService _prefs = SharedPreferencesService();
//     String? personalData = await _prefs.getFromSharedPref('personal-data');
//     if(personalData!=null){
//       Map<String,dynamic> decodedData = jsonDecode(personalData);
//       setState(() {
//         fnameController.text = decodedData["fname"];
//         mnameController.text = decodedData["mname"];
//         lnameController.text = decodedData["lname"];
//         emailController.text = decodedData["email"];
//         mobileController.text = decodedData["mobile"];
//         flatController.text = decodedData["flat/house"];
//         areaController.text = decodedData["area"];
//         landmarkController.text = decodedData["landmark"];
//         cityController.text = decodedData["city"];
//         stateController.text = decodedData["state"];
//         pincodeController.text = decodedData["pincode"];
//         socialmediaController.text = decodedData["socialmedia"];
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getPersonalInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//           key: _formKey,
//           child:Container(
//             padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 30,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: fnameController,
//                     validator: (value){
//                       if(fnameController.text.isEmpty){
//                         return "Name field cannot be empty";
//                       }else if(fnameController.text.length >=100){
//                         return "Name cannot be exceed 100 characters";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("First Name","First Name"),
//                   ),
//                 ),
//                 const SizedBox(height: 30,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: mnameController,
//                     // validator: (value){
//                     //   if(mnameController.text.isEmpty){
//                     //     return "Name field cannot be empty";
//                     //   }else if(mnameController.text.length >=100){
//                     //     return "Name cannot be exceed 100 characters";
//                     //   }
//                     //   return null;
//                     // },
//                     decoration: textFieldDecoration("Middle Name",  " Middle Name"),
//                   ),
//                 ),
//                 const SizedBox(height: 30,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: lnameController,
//                     validator: (value){
//                       if(lnameController.text.isEmpty){
//                         return "Name field cannot be empty";
//                       }else if(lnameController.text.length >=100){
//                         return "Name cannot be exceed 100 characters";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Last Name", "Last Name"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: emailController,
//                     validator: (value){
//                       if (emailController.text.isEmpty) {
//                         return "Email field cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your email", "Email"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: mobileController,
//                     keyboardType: TextInputType.number,
//                     validator: (value){
//                       if (mobileController.text.isEmpty) {
//                         return "Mobile number cannot be empty";
//                       } else if(mobileController.text.length >10) {
//                         return "Mobile number cannot be greater than 10 digits";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your mobile number", "Mobile Number"),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: flatController,
//                     validator: (value){
//                       if(flatController.text.isEmpty){
//                         return "Flat/House No field cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your flat/house no", "Flat/House No"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: areaController,
//                     validator: (value){
//                       if(areaController.text.isEmpty){
//                         return "Area cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your area", "Area"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: landmarkController,
//                     validator: (value){
//                       if(landmarkController.text.isEmpty){
//                         return "landmark cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your landmark", "Landmark"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 //
//                 // DropdownButtonHideUnderline(
//                 //   child: DropdownButton2(
//                 //     isExpanded: true,
//                 //     hint: Row(
//                 //       children: const [
//                 //         Icon(
//                 //           Icons.list,
//                 //           size: 16,
//                 //           color: Colors.black54,
//                 //         ),
//                 //         SizedBox(
//                 //           width: 4,
//                 //         ),
//                 //         Expanded(
//                 //           child: Text(
//                 //             'City',
//                 //             style: TextStyle(
//                 //               fontSize: 14,
//                 //               fontWeight: FontWeight.bold,
//                 //               color: Colors.black54,
//                 //             ),
//                 //             overflow: TextOverflow.ellipsis,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //     items: items
//                 //         .map((item) => DropdownMenuItem<String>(
//                 //       value: item,
//                 //       child: Text(
//                 //         item,
//                 //         style: const TextStyle(
//                 //           fontSize: 14,
//                 //           fontWeight: FontWeight.bold,
//                 //           color: Colors.white,
//                 //         ),
//                 //         overflow: TextOverflow.ellipsis,
//                 //       ),
//                 //     ))
//                 //         .toList(),
//                 //     value: selectedCityValue,
//                 //     onChanged: (value) {
//                 //       setState(() {
//                 //         selectedCityValue = value as String;
//                 //
//                 //       });
//                 //     },
//                 //     icon: const Icon(
//                 //       Icons.arrow_forward_ios_outlined,
//                 //     ),
//                 //     iconSize: 14,
//                 //     iconEnabledColor: Colors.black,
//                 //     iconDisabledColor: Colors.grey,
//                 //     buttonHeight: 50,
//                 //     buttonWidth: 400,
//                 //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                 //     buttonDecoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(14),
//                 //       border: Border.all(
//                 //         color: Colors.black26,
//                 //       ),
//                 //       color: Colors.grey,
//                 //     ).copyWith(
//                 //       boxShadow: kElevationToShadow[2],
//                 //     ),
//                 //     itemHeight: 40,
//                 //     itemPadding: const EdgeInsets.only(left: 20, right: 20),
//                 //     dropdownMaxHeight: 200,
//                 //     dropdownDecoration: BoxDecoration(color: Colors.blueGrey,),
//                 //     scrollbarRadius: const Radius.circular(40),
//                 //     scrollbarThickness: 6,
//                 //     scrollbarAlwaysShow: true,
//                 //
//                 //   ),
//                 // ),
//                // const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: cityController,
//                     validator: (value){
//                       if(cityController.text.isEmpty){
//                         return "city cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your city", "City"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: stateController,
//                     validator: (value){
//                       if(stateController.text.isEmpty){
//                         return "State cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your state", "State"),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     controller: pincodeController,
//                     keyboardType: TextInputType.number,
//                     validator: (value){
//                       if(pincodeController.text.isEmpty){
//                         return "Pincode cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your pincode", "Pincode"),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextFormField(
//                     controller: socialmediaController,
//                     cursorColor: Color.fromARGB(255,0,121,139),
//                     validator: (value){
//                       if(socialmediaController.text.isEmpty){
//                         return "social media cannot be empty";
//                       }
//                       return null;
//                     },
//                     decoration: textFieldDecoration("Enter your social media", "Social media"),
//                   ),
//                 ),
//                 const SizedBox(height: 15,),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: //Colors.blue
//                         Color.fromARGB(255,0,121,139)
//                     ),
//                     onPressed: (){
//                       if(_formKey.currentState!.validate()){
//                         savePersonalInfo();
//                       }
//                     },
//                     child: Container(padding: const EdgeInsets.fromLTRB(25, 0, 25, 0), child: const Text('Save details', style: TextStyle(fontSize: 16),))
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }