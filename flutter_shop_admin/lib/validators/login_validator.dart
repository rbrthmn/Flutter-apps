import 'dart:async';

class LoginValidators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Insira um email válido");
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if(password.length > 5) {
          sink.add(password);
        } else {
          sink.addError("Senha precisa conter no mínimo 6 caracteres");
        }
      }
  );
}