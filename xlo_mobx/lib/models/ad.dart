import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/models/user.dart';

enum AdStatus {PEDING, ACTIVE, SOLD, DELETED}

class Ad{

  String id;

  List images;

  String title;
  String description;

  Category category;
  Address address;

  num price;
  bool hidePhone;

  AdStatus status = AdStatus.PEDING;
  DateTime createdDate;

  User user;

  int views;
}