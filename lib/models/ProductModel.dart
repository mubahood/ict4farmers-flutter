import 'package:objectbox/objectbox.dart';

@Entity()
class ProductModel {
  int id = 0;
  String created_at = "";
  String name = "";
  String category_id = "";
  String user_id = "";
  String country_id = "";
  String city_id = "";
  String price = "";
  String slug = "";
  String status = "";
  String description = "";
  String quantity = "";
  String images = "";
  String thumbnail = "";
  String attributes = "";
  String sub_category_id = "";
  String fixed_price = "";

  static Future<List<ProductModel>> get(Store store) async {
    List<ProductModel> items = [];
    final query = await store.box<ProductModel>().query();
    final results = await query.build().find();
    return results;

    Stream<List<ProductModel>> data = await store
        .box<ProductModel>()
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());

    data.forEach((element) {
      element.forEach((k) {
        items.add(k);
        print("\n=============${k.id}. ${k.name}=============\n\n\n");
      });
    });

    print("FOUND ====>${items.length}<====");
    return items;
  }
}
