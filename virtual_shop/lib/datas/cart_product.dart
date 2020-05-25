import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualshop/datas/product_data.dart';

class CartProduct {

  String cId;
  String category;
  String pId;
  int quantity;
  String size;
  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cId = document.documentID;
    category = document.data["category"];
    quantity = document.data["quantity"];
    size = document.data["size"];
    pId = document.data["pId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pId": pId,
      "size": size,
      "quantity": quantity,
//      "product": productData.toResumeMap()
    };
  }
}