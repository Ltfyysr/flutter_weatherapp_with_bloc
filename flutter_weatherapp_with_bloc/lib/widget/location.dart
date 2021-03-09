import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final String secilenSehir;
  LocationWidget(
      {@required
          this.secilenSehir}); //ne zamanki locationwidgettan bir nesne üretilsin mutlaka bu değer buraya geçilsin
  @override
  Widget build(BuildContext context) {
    return Text(
      secilenSehir,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
