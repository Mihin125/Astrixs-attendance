import 'package:flutter/material.dart';

BoxDecoration decoratedBorder = BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(10.0),
);

const inputDecoration = InputDecoration(
  border: InputBorder.none,
);
final errorTextStyle = TextStyle(fontSize: 12, color: Colors.redAccent[700]);

const buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  gradient: LinearGradient(colors: [
    Color.fromARGB(255, 135, 234, 139),
    Color.fromARGB(255, 14, 166, 19),
  ]),
);

final elevatedButtonShape = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.all(0));
