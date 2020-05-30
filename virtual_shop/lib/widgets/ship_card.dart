import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ExpansionTile(
            title: Text("Calcular Frete",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey[700]),
                textAlign: TextAlign.start),
            leading: Icon(Icons.location_on),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Digite seu CEP"),
                  initialValue: "",
                  onFieldSubmitted: (text) {},
                ),
              )
            ]));
  }
}
