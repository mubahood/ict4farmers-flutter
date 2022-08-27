import 'dart:convert';

class RespondModel {
  String raw;
  int code = 0;
  String message =
      "Failed to connect to internet. Check your connection and try again";
  dynamic data;

  RespondModel(this.raw) {
    if (this.raw == null) {
      return;
    }

    if (this.raw.toString().isEmpty) {
      return;
    }

    if (raw != null && !raw.isEmpty) {
      dynamic resp = json.decode(raw);

      if (resp != null) {
        if (resp['status'] != null) {
          this.code = (resp['status'].toString() == '1') ? 1 : 0;
          this.message = resp['message'].toString();

          this.data = resp['data'];
        } else if (resp['message'] != null) {
          this.code = 0;
          this.message = resp['message'].toString();

          this.data = resp['data'];
        }
      }
    }
  }
}
