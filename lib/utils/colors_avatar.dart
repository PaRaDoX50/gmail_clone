import 'package:flutter/material.dart';

class AvatarColors {
  int a = "a".codeUnitAt(0);
  int z = "z".codeUnitAt(0);
  List<MaterialColor> colors = [
    Colors.cyan,
    Colors.deepOrange,
    Colors.purple,
    Colors.orange,
    Colors.amber,
    Colors.lightBlue,
    Colors.deepPurple,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.grey,
    Colors.blue,
  ];

  MaterialColor getColorForChar(String string) {
    int x = string.codeUnitAt(0);
    int toCompare = a + 3;

    for (int i = 0; i < 9; i++) {
      if (x < toCompare) {
        return colors[i];
      }
      toCompare = toCompare + 3;
    }
    return colors.last;
  }
}
