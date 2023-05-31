import 'dart:async';
import 'package:resume_builder/homepagescreen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:resume_builder/homepagescreen/home.dart';
import 'package:resume_builder/login.dart';
import 'package:resume_builder/resumeformscreen/sharedpreference.dart';
import 'package:resume_builder/signup.dart';
import 'package:resume_builder/templatescreen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _splashController;
  bool copAnimated = false;
  bool animateResumeBuilderText = false;
  static const String KEYLOGIN="login";//

  @override
  void initState() {
    super.initState();
    whereToGo();//
    _splashController = AnimationController(vsync: this);
    _splashController.addListener(() {
      if (_splashController.value > 0.7) {
        _splashController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateResumeBuilderText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _splashController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255,0,121,139),
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(milliseconds: 875),
            //white screen upar jae ani duration
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(copAnimated
                      ? 50.0
                      : 0.0)), //white screen upar jae ani edge round karva
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !copAnimated,
                  child: Lottie.asset(
                    'assets/resume.json',
                    controller: _splashController,
                    onLoaded: (composition) {
                      _splashController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: copAnimated,
                  child: Image.asset(
                    'assets/splash.gif',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('W E L C O M E ',
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255,0,121,139),)),
                        ],
                        isRepeatingAnimation: true,
                        totalRepeatCount: 100,
                        pause: Duration(milliseconds: 2000),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('T O ',
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255,0,121,139),)),
                        ],
                        isRepeatingAnimation: true,
                        totalRepeatCount: 100,
                        pause: Duration(milliseconds: 2000),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('R E S U M E   B U I L D E R',
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255,0,121,139),)),
                        ],
                        isRepeatingAnimation: true,
                        totalRepeatCount: 100,
                        pause: Duration(milliseconds: 2000),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(visible: copAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
//aa bi aakhu function banayu
  void whereToGo() async{
    var sharedPref=await SharedPreferences.getInstance();
    var isLogIn=sharedPref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2),(){
      if(isLogIn!=null){
        if(isLogIn)
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyHomePage(),));
        }
        else
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage(),));
        }
      }
      else
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage(),));
      }

    },);
  }
}
class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 300, 50, 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              color: Color.fromARGB(255,50,50,50),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                color: Color.fromARGB(255,50,50,50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                )),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}