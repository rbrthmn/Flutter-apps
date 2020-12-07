import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/models/address.dart';
import 'package:xlomobx/models/category.dart';
import 'package:xlomobx/models/city.dart';
import 'package:xlomobx/models/uf.dart';
import 'package:xlomobx/models/user.dart';
import 'package:xlomobx/repositories/table_keys.dart';
import 'package:xlomobx/repositories/user_repository.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    createdDate = object.createdAt;
    address = Address(
      cep: object.get<String>(keyAdPostalCode),
      city: City(name: object.get<String>(keyAdCity)),
      district: object.get<String>(keyAdDistrict),
      uf: UF(initials: object.get<String>(keyAdFederativeUnit)),
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner));
    status = AdStatus.values[object.get<int>(keyAdStatus)];
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
  }

  Ad();

  String id;

  List images;

  String title;
  String description;

  Category category;
  Address address;

  num price;
  bool hidePhone;

  AdStatus status = AdStatus.PENDING;
  DateTime createdDate;

  User user;

  int views;
}
