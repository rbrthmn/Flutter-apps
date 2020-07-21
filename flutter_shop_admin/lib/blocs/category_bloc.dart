import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTitle => _titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.isEmpty)
          sink.addError("Insira um título");
        else
          sink.add(title);
      }));

  Stream get outImage => _imageController.stream;

  Stream<bool> get outDelete => _deleteController.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(outTitle, outImage, (a, b) => true);

  DocumentSnapshot category;
  File _image;
  String _title;

  CategoryBloc(this.category) {
    if (category != null) {
      _title = category.data["title"];

      _titleController.add(category.data["title"]);
      _imageController.add(category.data["icon"]);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(File file) {
    _image = file;
    _imageController.add(file);
  }

  void setTitle(String title) {
    _title = title;
    _titleController.add(title);
  }

  Future<void> saveData() async {
    if (_image == null && category != null && _title == category.data["title"])
      return;

    Map<String, dynamic> dataToUpdate = {};

    if (_image != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child("icons")
          .child(_title)
          .putFile(_image);

      StorageTaskSnapshot snap = await task.onComplete;
      dataToUpdate["icon"] = await snap.ref.getDownloadURL();
    }

    if (category == null || _title != category.data["title"]) {
      dataToUpdate["title"] = _title;
    }

    if (category == null) {
      await Firestore.instance
          .collection("products")
          .document(_title.toLowerCase())
          .setData(dataToUpdate);
    } else {
      await category.reference.updateData(dataToUpdate);
    }
  }

  void delete() {
    category.reference.delete();
  }

  @override
  void dispose() {
    _titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}
