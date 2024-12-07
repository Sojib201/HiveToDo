import 'package:flutter/material.dart';

InputDecoration MyInput(label) {
  return InputDecoration(
   // contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
    border: OutlineInputBorder(),
    hintText: label,
    labelText: label,
  );
}

ButtonStyle button() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.all(10),
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}
