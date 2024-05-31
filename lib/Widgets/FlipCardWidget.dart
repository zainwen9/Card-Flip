import 'dart:math';

import 'package:flutter/material.dart';

class flipController{
_FlipCardWidgetState? _state;

Future flipCard() async=>_state?.flipCard();
}

class FlipCardWidget extends StatefulWidget {

  final flipController controller;
  final Image front;
  final Image back;
  const FlipCardWidget({required this.front,required this.back,required this.controller});

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {

  Future flipCard()async{

  }
  @override
  Widget build(BuildContext context) {
    final angle=0.2*-pi;
    final transform=Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(angle);
    return Transform(
        transform: transform,
        alignment: Alignment.center,
        child: widget.front);
  }
}
