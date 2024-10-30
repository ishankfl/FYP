import 'package:flutter/material.dart';

class BorderShadow {
  static BoxShadow shadow({Color? color, Offset? offset}) {
    return BoxShadow(
      color: color ??
          const Color.fromARGB(145, 255, 255, 255)
              .withOpacity(0.1), //color of shadow
      spreadRadius: 5, //spread radius
      blurRadius: 10, // blur radius
      offset: offset ?? const Offset(0, 2), // changes position of shadow
      //first paramerter of offset is left-right
      //second parameter is top to down
    );
  }
}
