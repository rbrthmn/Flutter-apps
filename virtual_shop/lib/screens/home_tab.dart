import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Novidades'),
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
