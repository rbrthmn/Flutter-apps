import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttershopadmin/blocs/orders_bloc.dart';
import 'package:fluttershopadmin/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder(
          stream: _ordersBloc.outOrders,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent)));
            else if (snapshot.data.length == 0)
              return Center(
                child: Text("Nenhum pedido encontrado!"),
              );
            return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return OrderTile(snapshot.data[index]);
                });
          }),
    );
  }
}
