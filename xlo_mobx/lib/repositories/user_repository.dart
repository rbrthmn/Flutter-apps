import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/models/user.dart';
import 'package:xlomobx/repositories/parse_errors.dart';
import 'package:xlomobx/repositories/table_keys.dart';

class UserRepository {

  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);
    
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();
    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if(response.success) {
      return mapParseToUser(response.result);
    } else {
      print('error');
      print(response.error.code);
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt)
    );
  }
}