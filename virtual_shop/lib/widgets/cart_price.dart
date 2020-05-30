import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualshop/models/cart_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              double price = model.getProductsPrice();
              double discount = model.getDiscountPrice();
              double ship = model.getShipPrice();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Resumo do pedido",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal"),
                      Text("R\$ ${price.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Desconto"),
                      Text("R\$ -${discount.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Entrega"),
                      Text("R\$ ${ship.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        "R\$ ${(price - discount + ship).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                  SizedBox(height: 12.0),
                  RaisedButton(
                    child: Text("Finalizar pedido"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: buy,
                  )
                ],
              );
            },
          ),
        ));
  }
}
