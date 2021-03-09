import 'package:flutter/material.dart';

class GecisliRenkContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor renk;

  GecisliRenkContainer({@required this.child, @required this.renk});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child, //çocuğu dışardan buraya atadığım child olacak
      decoration: BoxDecoration(
          gradient: LinearGradient(
              //artan şekilde olacak renkler
              colors: [renk[700], renk[500], renk[200]],
              begin: Alignment
                  .topCenter, //geçişli renk nerden başlayacak? yukarının ortasından başlasın
              end: Alignment
                  .bottomCenter, //bütün sayfa boyunca yukarıdan aşağı geçiş olsun
              stops: [0.6, 0.8, 1])),
    );
  }
}
