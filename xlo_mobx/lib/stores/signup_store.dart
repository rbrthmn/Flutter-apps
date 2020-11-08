import 'package:mobx/mobx.dart';
import 'package:xlomobx/helpers/extension.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Nome muito curto';
    }
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'E-mail inválido';
    }
  }

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Número inválido';
    }
  }

  @observable
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => phone != null && pass1.length > 6;
  String get pass1Error {
    if (pass1 == null || pass1Valid) {
      return null;
    } else if (pass1.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Senha muito curta';
    }
  }

  @observable
  String pass2;

  @action
  void setPass2(String value) => pass1 = value;

  @computed
  bool get pass2Valid => phone != null && pass2 == pass1;
  String get pass2Error {
    if (pass2 == null ||
        pass2Valid) {
      return null;
    } else {
      return 'Senhas não coincidem';
    }
  }
}
