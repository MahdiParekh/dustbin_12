import 'dart:core';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dustbin_12/screens/login.dart';
import 'package:dustbin_12/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:dustbin_12/components/rounded_button.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();

  static String id = 'welcome_screen';
}
//flutter sequence animations- for various changes in a sequential manner
//rubber animation- can be applied to widgets,components like menu etc
//sprung animation- easily implemented and calculated from complex physics
//animated_text_kit- for various text animations

//There are 3 components needed for custom animations.
// Ticker - With each tick of clock animation changes in value color etc.
//Animation Controller - it will tell the animation to start, stop,move forward,backward etc
//An Animation value - using this value we can change the value of animation like height,size etc.
class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override

  void initState(){super.initState();
  controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      //vsync:this is used to sync with the state object of this class
      //WelcomeScreenState.
      //upperBound: 100.0 this will crash the app because Curved animations can only have
      //upperbound from 0 to 1.
      upperBound: 1.0
  );
  //animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
  animation=ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
  controller.forward();
  animation.addStatusListener((status)
  {
    print(status);

  });
  controller.addListener((){setState(() {
    //here this will print the value of the color as it changes from
    //blue to red.
    print(animation.value);
  });});

  //this is the animation which regularly goes from 0 to 1 and back from
  //one to zero.
  /* animation.addStatusListener((status){
    if(status==AnimationStatus.completed)
      {
        controller.reverse(from: 1.0);
      }
    else if(status==AnimationStatus.dismissed)
      {
        controller.forward();
      }
  });*/
//controller.addListener((){
//    print(controller.value);
//    setState(() {
//
//    });
//  });
//  }
  //controller.addListener is a very important function as when we try to
  //make some animation work we need a listener which listens and using
  //setState() func. each time updates the state leading to an animation.
  controller.addListener((){

    setState(() {
      print(controller.value);
    });
  });
  }
  //dispose method is used here so as to dispose the animation loop from 0 to 1
  //to 0.....by using controller.dispose()
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    //height: animation.value *100,
                    height: 60.0,
                  ),
                ),
                RotateAnimatedTextKit(
                  //'${controller.value.toInt()}%',
                  text:['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: (){Navigator.pushNamed(context, Login.id);} ,
            ),
            RoundedButton(title: 'Register',
              colour: Colors.blueAccent,
              onPressed: (){
                Navigator.pushNamed(context, Registration.id);
              },)

          ],
        ),),
    );
  }
}
