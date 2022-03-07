class UserModel {
  int id = 0;

  String username = "";
  String password = "";
  String name = "";
  String avatar = "";
  String remember_token = "";
  String created_at = "";
  String updated_at = "";
  String last_name = "";
  String company_name = "";
  String email = "";
  String phone_number = "";
  String address = "";
  String about = "";
  String services = "";
  String longitude = "";
  String latitude = "";
  String division = "";
  String opening_hours = "";
  String cover_photo = "";
  String facebook = "";
  String twitter = "";
  String whatsapp = "";
  String youtube = "";
  String instagram = "";
  String last_seen = "";
  String status = "";
  String linkedin = "";
  String category_id = "";
  String status_comment = "";
  String country_id = "";
  String region = "";
  String district = "";
  String sub_county = "";
  String logged_in_user = "0";

  static UserModel fromMap(data) {
    UserModel u = new UserModel();
    u.id = 0;
    if (data['id'] != null) {
      if (!data['id'].toString().toString().isEmpty) {
        try {
          u.id = int.parse(data['id'].toString());
        } catch (e) {
          u.id = 0;
        }
      }
    }

    u.username = data['username'].toString();
    u.password = data['password'].toString();
    u.name = data['name'].toString();
    u.avatar = data['avatar'].toString();
    u.remember_token = data['remember_token'].toString();
    u.created_at = data['created_at'].toString();
    u.updated_at = data['updated_at'].toString();
    u.last_name = data['last_name'].toString();
    u.company_name = data['company_name'].toString();
    u.email = data['email'].toString();
    u.phone_number = data['phone_number'].toString();
    u.address = data['address'].toString();
    u.about = data['about'].toString();
    u.services = data['services'].toString();
    u.longitude = data['longitude'].toString();
    u.latitude = data['latitude'].toString();
    u.division = data['division'].toString();
    u.opening_hours = data['opening_hours'].toString();
    u.cover_photo = data['cover_photo'].toString();
    u.facebook = data['facebook'].toString();
    u.twitter = data['twitter'].toString();
    u.whatsapp = data['whatsapp'].toString();
    u.youtube = data['youtube'].toString();
    u.instagram = data['instagram'].toString();
    u.last_seen = data['last_seen'].toString();
    u.status = data['status'].toString();
    u.linkedin = data['linkedin'].toString();
    u.category_id = data['category_id'].toString();
    u.status_comment = data['status_comment'].toString();
    u.country_id = data['country_id'].toString();
    u.region = data['region'].toString();
    u.district = data['district'].toString();
    u.sub_county = data['sub_county'].toString();
    u.logged_in_user = data['logged_in_user'].toString();

    return u;
  }
}
