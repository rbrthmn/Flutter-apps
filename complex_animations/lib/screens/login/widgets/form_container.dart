import 'package:complexanimations/screens/login/widgets/input_field.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: <Widget>[
            InputField("Username", false, Icons.person_outline),
            InputField("Passwird", true, Icons.lock_outline),
          ],
        ),
      ),
    );
  }
}
