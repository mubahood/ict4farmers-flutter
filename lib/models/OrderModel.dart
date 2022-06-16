import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ict4farmers/utils/AppConfig.dart';
import 'package:ict4farmers/utils/Utils.dart';

part 'OrderModel.g.dart';

@HiveType(typeId: 81)
class OrderModel extends HiveObject {
  @HiveField(0)
  int id = 0;

  @HiveField(3)
  String created_at = "";

  @HiveField(4)
  String updated_at = "";

  @HiveField(5)
  String customer_name = "";

  @HiveField(6)
  String customer_phone = "";

  @HiveField(7)
  String customer_address = "";

  @HiveField(8)
  String product_price = "";

  @HiveField(9)
  String product_name = "";

  @HiveField(10)
  String product_id = "";

  @HiveField(11)
  String product_photos = "";

  String get_thumbnail() {
    return this.product_photos;
  }

  static Future<List<OrderModel>> get_trending() async {
    List<OrderModel> items = [];
    get_trending_items_in_background();

    items = await OrderModel.get_local_products();

    if (items == null || items.isEmpty) {
      items = await get_trending_items_in_background();
    } else {
      return items;
    }

    items.sort((a, b) => a.id.compareTo(b.id));

    return items;
  }

  static Future<List<OrderModel>> get_local_products() async {
    Utils.init_databse();
    await Hive.initFlutter();
    var box = await Hive.openBox<OrderModel>("OrderModel");
    if (box.values.isEmpty) {
      return [];
    }

    List<OrderModel> items = [];
    box.values.forEach((element) {
      items.add(element);
    });

    return items;
  }

  static Future<List<OrderModel>> get_trending_items_in_background() async {
    List<OrderModel> items = [];
    items = await get_online_items({'per_page': 100, 'user_id': 0});

    if (await Utils.is_connected()) {
      await OrderModel.save_to_local_db(items, true);
    }
    return items;
  }

  static Future<void> save_to_local_db(
      List<OrderModel> data, bool clear_db) async {
    Utils.init_databse();
    await Hive.initFlutter();
    var box = null;
    if (!Hive.isBoxOpen("OrderModel")) {
      box = await Hive.openBox<OrderModel>("OrderModel");
    }
    if (box == null) {
      box = await Hive.openBox<OrderModel>("OrderModel");
    }
    if (box == null) {
      return;
    }

    if (clear_db) {
      await box.clear();
    }

    List<int> new_data = [];
    data.forEach((element) {
      new_data.add(element.id);
    });

    List existinng = await get_local_products();
    for (int xx = 0; xx < existinng.length; xx++) {
      OrderModel pro = existinng[xx];
      await pro.delete();
    }

    await box.addAll(data);
    return;
  }

  static Future<List<OrderModel>> get_online_items(
      Map<String, dynamic> data) async {
    List<OrderModel> items = [];

    String resp = await Utils.http_get('api/orders', data);

    if (resp != null && !resp.isEmpty) {
      json.decode(resp).map((element) {
        OrderModel item = new OrderModel();
        item = OrderModel.fromJson(element);
        items.add(item);
      }).toList();
    }

    return items;
  }

  static OrderModel fromJson(data) {
    OrderModel item = new OrderModel();
    item.id = 0;
    if (data['id'] != null) {
      try {
        item.id = int.parse(data['id'].toString());
      } catch (e) {
        item.id = 0;
      }
    }

    item.created_at = data['created_at'].toString();
    item.customer_name = data['customer_name'].toString();
    item.customer_phone = data['customer_phone'].toString();
    item.customer_address = data['customer_address'].toString();
    item.product_price = data['product_price'].toString();
    item.product_name = data['product_name'].toString();
    item.product_id = data['product_id'].toString();
    item.product_photos = data['product_photos'].toString();

    return item;
  }
}
