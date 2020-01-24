import 'package:flutter/material.dart';
import 'package:dustbin_12/components/rounded_button.dart';
import 'package:dustbin_12/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String email,password;
bool showSpinner = false;

final _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  static String id = 'login_screen';
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password= value;
                  //Do something with the user input.
                },
                //we can save entire decoration properties inside a constant variable
                //inside another dart file like kTextFieldDecoration and also reuse it with some dynamic properties
                //by using the copyWith function. eg. hintText property.
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter a password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              //We can export a widget eg. RoundedButton in totally another class so that
              //the properties of the widget are not rewritten over and over again and we can
              //just call the widget by keeping some properties as dynamic which need to change.
              RoundedButton(title:'Log In',colour: Colors.lightBlueAccent ,onPressed: () async {
                setState(() {
                  showSpinner=true;
                });
                try{
                  final existingUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(existingUser!=null)
                  {
                   // Navigator.pushNamed(context, ChatScreen.id);
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

              ),
            ],
          ),
        ),
      ),
    );
  }
}
