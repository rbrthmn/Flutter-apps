import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtualshop/datas/cart_product.dart';
import 'package:virtualshop/datas/product_data.dart';
import 'package:virtualshop/models/cart_model.dart';
import 'package:virtualshop/models/user_model.dart';
import 'package:virtualshop/screens/cart_screen.dart';
import 'package:virtualshop/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  String size;
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return Image.network(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  Text(
                    "U\$ ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Tamanho",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34,
                    child: GridView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.5),
                        children: product.sizes.map((p) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                size = p;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                    width: 2,
                                    color: p == size
                                        ? primaryColor
                                        : Colors.grey[500],
                                  )),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(p),
                            ),
                          );
                        }).toList()),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: size != null
                          ? () {
                              if (UserModel.of(context).isLoggedIn()) {

                                CartProduct cartProduct = CartProduct();
                                cartProduct.size = size;
                                cartProduct.quantity = 1;
                                cartProduct.pId = product.id;
                                cartProduct.category = product.category;
                                cartProduct.productData = product;

                                CartModel.of(context).addCartItem(cartProduct);

                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              }
                            }
                          : null,
                      child: Text(
                        UserModel.of(context).isLoggedIn()
                            ? "Adicionar ao carrinho"
                            : "Entre para comprar",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Descrição",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
