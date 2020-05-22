import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess(),
      @required VoidCallback onFail()}) {
    isLoading = true;

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: password)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}
