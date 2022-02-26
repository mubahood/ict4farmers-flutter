import 'dart:convert';

import 'package:ict4farmers/utils/Utils.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class BannerModel {
  int local_id = 0;

  int id = 0;
  String created_at = "";
  String section = "";
  String position = "";
  String name = "";
  String sub_title = "";
  String type = "";
  String category_id = "";
  String product_id = "";
  String clicks = "";
  String image = "";

  static Future<List<BannerModel>> get(Store store) async {
    List<BannerModel> items = [];
    get_online_items(store);
    items = await BannerModel.get_local_banners(store);
    if (items == null || items.isEmpty) {
      items = await get_online_items(store);
    } else {
      return items;
    }
    if (items.isEmpty) {
      items = await BannerModel.get_local_banners(store);
    }

    items = await get_online_items(store);

    if (items == null) {
      return [];
    }
    return items;
  }

  static Future<List<BannerModel>> get_online_items(Store store) async {
    List<BannerModel> items = [];
    String resp = await Utils.http_get('api/banners', {});
    if (resp != null && !resp.isEmpty) {
      json.decode(resp).map((element) {
        BannerModel item = new BannerModel();
        item = BannerModel.fromJson(element);
        items.add(item);
      }).toList();
    }

    if (await Utils.is_connected()) {
      await BannerModel.save_to_local_db(items, store, true);
    }

    return items;
  }

  static Future<void> save_to_local_db(
      List<BannerModel> data, Store _store, bool clear_db) async {
    if (clear_db) {
      await _store.box<BannerModel>().removeAll();
    }
    if (data != null) {
      if (!data.isEmpty) {
        data.forEach((element) {
          element.id = 0;

          _store.box<BannerModel>().put(element);
        });
      }
    }

    return;
  }

  static BannerModel fromJson(data) {
    BannerModel item = new BannerModel();
    item.id = 0;
    if (data['id'] != null) {
      try {
        item.id = int.parse(data['id'].toString());
      } catch (e) {
        item.id = 0;
      }
    }

    item.created_at = data['created_at'].toString();
    item.section = data['section'].toString();
    item.position = data['position'].toString();
    item.name = data['name'].toString();
    item.sub_title = data['sub_title'].toString();
    item.type = data['type'].toString();
    item.category_id = data['category_id'].toString();
    item.product_id = data['product_id'].toString();
    item.clicks = data['clicks'].toString();
    item.image = data['image'].toString();

    return item;
  }

  static Future<List<BannerModel>> get_local_banners(Store store) async {
    final query = await store.box<BannerModel>().query();
    return await query.build().find();
  }
}
