import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  BarButton({this.label, this.decoration, this.onTab});

  final String label;
  final BoxDecoration decoration;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTab,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          decoration: decoration,
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
