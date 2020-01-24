import 'package:dustbin_12/constants.dart';
import 'package:flutter/material.dart';
import 'package:dustbin_12/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String email,password;
int phoneno;
bool showSpinner = false;

final _auth = FirebaseAuth.instance;
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
  static String id = 'registration_screen';
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Hero is an animation class/widget where we get a range of animations.
              //There are other animation classes as well .
              //We have to compulsorily give a tag property which takes in a string
              // which generally defines the starting and the ending point of an animation.
              Hero(tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,

                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter a username'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter a password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Register',colour: Colors.blueAccent,onPressed:  ()async{
                setState(() {
                  showSpinner = true;
                });

                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser!=null)
                  {
                    //Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e)
                {
                  print(e);
                }
              }

              )
            ],
          ),
        ),
      ),
    );
  }
}
