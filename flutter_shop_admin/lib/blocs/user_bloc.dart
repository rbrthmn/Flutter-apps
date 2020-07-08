import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {

  final _userController = BehaviorSubject();

  Map<String, Map<String, dynamic>> _users = {};

  Firestore _firestore = Firestore.instance;

  UserBloc() {
    _addUsersListener();
  };

  void _addUsersListener() {
    _firestore.collection("users").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {

        String uid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _firestore.collection("users").document(uid).collection("orders").snapshots().listen((orders) {

      int numOrders = orders.documents.length;

      double money = 0.0;
    });
  }

  @override
  void dispose() {
    _userController.close();
  }
}