import 'package:complexanimations/screens/login/widgets/form_container.dart';
import 'package:complexanimations/screens/login/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 32),
                      child: Image.asset("images/tickicon.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,)
                    ),
                    FormContainer(),
                    SignUpButton()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
