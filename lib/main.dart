import 'package:flutter/material.dart';
import 'package:dustbin_12/screens/registration.dart';
import 'package:dustbin_12/screens/login.dart';
import 'package:dustbin_12/screens/welcome.dart';

void main() => runApp(Dustbin());

class Dustbin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //instead if we are using /first,/second as the keys, instead of
      //LoginScreen.id then one key is to be compulsorily named as
      //'/' otherwise the app will crash. Thus the best and safe way is to use
      //the id system.
        initialRoute: Welcome.id,
        routes: {Login.id:(context)=>Login(),
          Welcome.id:(context)=>Welcome(),
          Registration.id:(context)=>Registration(),
          }
    );
  }
}
