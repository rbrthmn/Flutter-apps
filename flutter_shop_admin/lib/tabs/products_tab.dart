import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttershopadmin/widgets/category_tile.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> with KeepAliveParentDataMixin{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
              child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation(Colors.white)));
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
          return CategoryTile(snapshot.data.documents[index]);
        });
      },
    );
  }

  @override
  void detach() {
    // TODO: implement detach
  }

  @override
  // TODO: implement keptAlive
  bool get keptAlive => true;
}
