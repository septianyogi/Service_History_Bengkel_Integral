import 'package:flutter/material.dart';

class Nac {
  static push(BuildContext context, Widget page) {
    return Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => page)  
    );
  }

  static replace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => page)
    );
  }
}