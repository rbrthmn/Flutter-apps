import 'package:flutter/material.dart';
import 'package:virtualshop/tabs/home_tab.dart';
import 'package:virtualshop/tabs/products_tab.dart';
import 'package:virtualshop/widgets/cart_button.dart';
import 'package:virtualshop/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Container(color: Colors.green,),
        Container(color: Colors.blue,),
      ],
    );
  }
}
