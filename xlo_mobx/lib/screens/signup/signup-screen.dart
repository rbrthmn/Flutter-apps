import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlomobx/screens/signup/components/field_title.dart';
import 'package:xlomobx/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FieldTitle(
                      title: 'Apelido',
                      subtitle: 'Como aparecerá em seus anúncios.',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo: John S.',
                              isDense: true,
                              errorText: signupStore.nameError),
                          onChanged: signupStore.setName,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: 'E-mail',
                      subtitle: 'Enviaremos um e-mail de confirmação.',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo: john@snow.com.',
                              isDense: true,
                              errorText: signupStore.emailError),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: signupStore.setEmail,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: 'Celular',
                      subtitle: 'Proteja sua conta.',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exemplo: (99) 99999-9999',
                            isDense: true,
                            errorText: signupStore.phoneError),
                        onChanged: signupStore.setPhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: 'Senha',
                      subtitle: 'Use letras, números e caracteres especiais.',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: signupStore.pass1Error),
                          onChanged: signupStore.setPass1,
                          obscureText: true,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: 'Confirmar Senha',
                      subtitle: 'Repita a senha.',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: signupStore.pass2Error),
                          onChanged: signupStore.setPass2,
                          obscureText: true,
                        );
                      },
                    ),
                    Observer(builder: (_) {
                      return Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: RaisedButton(
                          color: Colors.orange,
                          disabledColor: Colors.orange.withAlpha(120),
                          child: signupStore.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text('CADASTRAR'),
                          textColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: signupStore.signUpPressed,
                        ),
                      );
                    }),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Já tem conta?',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Entrar',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.purple,
                                    fontSize: 16)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
