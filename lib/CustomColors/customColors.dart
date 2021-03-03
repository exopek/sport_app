import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomCol {
  Color blackShadow() {
    return Color.lerp(Colors.white, Colors.black, 0.5);
  }
}