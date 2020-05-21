import 'package:flutter/material.dart';
import 'package:virtualshop/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignUpScreen()
              ));
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido";
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválida";
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                child: Text("Esqueci minha senha"),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
           SizedBox(
             height: 44.0,
             child:  RaisedButton(
               child: Text(
                 "Entrar",
                 style: TextStyle(color: Colors.white, fontSize: 18),
               ),
               color: Theme.of(context).primaryColor,
               onPressed: () {
                 if(_formKey.currentState.validate()) {

                 }
               },
             ),
           )
          ],
        ),
      ),
    );
  }
}
