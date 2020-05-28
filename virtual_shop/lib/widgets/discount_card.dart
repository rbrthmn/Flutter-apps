import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualshop/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          textAlign: TextAlign.start
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance.collection("coupons").document(text).get().then((docSnapshot) {
                  if(docSnapshot.data != null) {
                    CartModel.of(context).setCoupon(text, docSnapshot.data["percent"]);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Desconto de ${docSnapshot.data["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom não encontrado!"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
