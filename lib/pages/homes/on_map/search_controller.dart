import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';

import '../../../models/map_item.dart';
import '../../../theme/app_theme.dart';

class SearchController extends FxController {
  bool showLoading = false, uiLoading = false;
  List<MapItem> map_items = [];
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  int currentPage = 0;


  @override
  void initState() {
    super.save = false;
    super.initState();
  }

  Future<void> setMapTheme() async {
  }

  @override
  String getTag() {
    return "search_controller";
  }

  onMarkerTap(MapItem item) {
    if (map_items.isEmpty) {
      return;
    }
    int position = 0;
    int x = 0;
    map_items.forEach((element) {
      if (element.id.toString() == item.id.toString()) {
        position = x;
      }
      x++;
    });

    pageController.animateToPage(
      position,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
    update();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  add_marker(MapItem item) async {
    double lati = 0.364607;
    double long = 32.604781;

    try {
      lati = double.parse(item.lati.toString());
      long = double.parse(item.longi.toString());
    } catch (e) {
      lati = 0.364607;
      long = 32.604781;
    }
  }

  addMarkers(List<MapItem> items) async {
    if (items.isEmpty) {
      return;
    }
    map_items.clear();
    for (int x = 0; x < items.length; x++) {
      map_items.add(items[x]);
      await add_marker(items[x]);
    }
    update();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
