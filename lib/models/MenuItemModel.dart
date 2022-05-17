import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ict4farmers/utils/AppConfig.dart';
import 'package:ict4farmers/utils/Utils.dart';


class MenuItemModel  {
  String title = "";
  String photo = "";
  String screen = "";
  bool is_protected = false;

  MenuItemModel(this.title, this.photo, this.screen,this.is_protected);
}

