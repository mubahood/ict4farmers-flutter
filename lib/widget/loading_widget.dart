import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget LoadingWidget() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );
}
