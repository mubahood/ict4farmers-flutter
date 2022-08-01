import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

Widget LoadingWidget() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(CustomTheme.accent),
      ),
    ),
  );
}
