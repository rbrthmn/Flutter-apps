import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome completo"),
              keyboardType: TextInputType.text,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty || text.length < 2) return "Nome inválido";
              },
            ),
            SizedBox(height: 16.0),
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
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              keyboardType: TextInputType.text,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty || text.length < 3) return "Endereço inválido";
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  "Cadastrar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
