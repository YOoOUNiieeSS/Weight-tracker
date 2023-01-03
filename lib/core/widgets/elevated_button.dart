import 'package:flutter/material.dart';

Widget myElevatedButton({required String text,required Function() onPressed})=>ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20))),
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 18),
    ));