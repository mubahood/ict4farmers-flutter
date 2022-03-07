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

  static Future<List<ProductModel>> get() async {
    List<ProductModel> items = [];

    return [];
  }

  static ProductModel fromJson(Map<String, dynamic> jsonObject) {
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String address = jsonObject['address'].toString();
    String number = jsonObject['number'].toString();
    String properties = jsonObject['properties'].toString();
    String description = jsonObject['description'].toString();
    return ProductModel();
  }
}
