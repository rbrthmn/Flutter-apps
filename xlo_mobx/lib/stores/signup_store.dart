import 'package:mobx/mobx.dart';

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
      return 'Nome obrigatório';
    } else {
      return 'Nome muito curto';
    }
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;
}