import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';


Widget EmptyList(
    {required BuildContext context, String body: "No item found."}) {
  ThemeData themeData = Theme.of(context);
  return ListView(
    children: [
      Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Image(
                    image: AssetImage(
                      './assets/project/circle_2.webp',
                    ),
                    height: 40,
                    width: 40),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(23),
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: themeData.colorScheme.onBackground,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
