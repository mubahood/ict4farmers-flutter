import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ict4farmers/models/CropCategory.dart';
import 'package:ict4farmers/models/PestModel.dart';
import 'package:ict4farmers/pages/account/logged_in_screen.dart';
import 'package:ict4farmers/pages/option_pickers/single_option_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/FormItemModel.dart';
import '../../models/UserModel.dart';
import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../location_picker/location_main.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  State<MyAccountScreen> createState() => MyAccountScreenState();
}

late CustomTheme customTheme;

class MyAccountScreenState extends State<MyAccountScreen> {
  String nature_of_off = "";
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    my_init();
  }

  @override
  void dipose() {}

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    String _title = "My Account";
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // remove back button in appbar.
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: CustomTheme.primary,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 1,
          titleSpacing: 0,
          title: FxContainer(
            borderRadiusAll: 0,
            color: CustomTheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: FxSpacing.x(0),
                      child: Icon(
                        CupertinoIcons.clear,
                        size: 25,
                        color: Colors.white,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText(
                        _title,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: 500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          child:  LoggedInScreen(),
        ),
      );
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  String error_message = "";
  List<String> photos_picked = [AppConfig.form_field_image_picker];

  Widget single_image_picker(int index, String _item, BuildContext context) {
    return (_item == AppConfig.form_field_image_picker)
        ? InkWell(
            onTap: () => {_show_bottom_sheet_photo(context)},
            child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: CustomTheme.primary,
                      width: 1,
                      style: BorderStyle.solid),
                  color: CustomTheme.primary.withAlpha(25),
                ),
                padding: EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 35, color: CustomTheme.primary),
                      Center(child: Text("add photo")),
                    ])))
        : Stack(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: CustomTheme.primary,
                      width: 1,
                      style: BorderStyle.solid),
                  color: CustomTheme.primary.withAlpha(25),
                ),
                padding: EdgeInsets.all(0),
                child: Image.file(
                  File(_item),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                  child: InkWell(
                    onTap: () => {romove_image_at(index)},
                    child: Container(
                      child: FxContainer(
                        width: 35,
                        alignment: Alignment.center,
                        borderRadiusAll: 17,
                        height: 35,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        color: Colors.red.shade700,
                        paddingAll: 0,
                      ),
                    ),
                  ),
                  right: 0),
            ],
          );
  }

  List<FormItemModel> form_data_to_upload = [];

  String category_text = "";
  String category_id = "";
  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

  Future<void> pick_location() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationMain()),
    );

    if (result != null) {
      if ((result['location_sub_id'] != null) &&
          (result['location_sub_name'] != null)) {
        location_sub_name = result['location_sub_name'];
        location_id = result['location_sub_id'];
        setState(() {});
      }
    }
  }

  List<PestModel> pests = [];

  Future<void> pick_category() async {
    if (categories.isEmpty) {
      categories = await CropCategory.get_items();
    }
    if (categories.isEmpty) {
      Utils.showSnackBar(
          "Please connect to internet and try again.", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    List<OptionPickerModel> local_items = [];

    categories.forEach((element) {
      if (element.parent < 1) {
        OptionPickerModel item = new OptionPickerModel();
        item.parent_id = "1";
        item.id = element.id.toString();
        item.name = element.name.toString();
        local_items.add(item);
      }
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SingleOptionPicker("Select a category", local_items)),
    );

    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        category_id = result['id'];
        category_text = result['text'];
        setState(() {});
      }
    }
  }

  void do_upload_process() async {
    error_message = "";
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      Utils.showSnackBar("Please Check errors in the form and fix them first.",
          context, Colors.white,
          background_color: Colors.red);

      return;
    }

    Map<String, dynamic> form_data_map = {};
    form_data_to_upload.clear();
    form_data_to_upload = await FormItemModel.get_all();

    UserModel userModel = await Utils.get_logged_in();
    if (userModel.id < 1) {
      Utils.showSnackBar(
          "Login before  you proceed.", context, CustomTheme.onPrimary);
      return;
    }

    form_data_map['user_id'] = userModel.id;
    form_data_map["question"] =
        _formKey.currentState?.fields['description']?.value;

    if (category_id.isEmpty) {
      Utils.showSnackBar("Please pick a garden.", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    if (photos_picked.isEmpty) {
      Utils.showSnackBar("Add at least one photo.", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    form_data_map['category_id'] = category_id;

    bool first_found = false;

    if (!photos_picked.isEmpty) {
      for (int __counter = 0; __counter < photos_picked.length; __counter++) {
        if (first_found) {
          try {
            var img = await MultipartFile.fromFile(photos_picked[__counter],
                filename: 'image_${__counter}');
            if (img != null) {
              form_data_map['image_${__counter}'] =
                  await MultipartFile.fromFile(photos_picked[__counter],
                      filename: photos_picked[__counter].toString());
            } else {}
          } catch (e) {}
        }
        first_found = true;
      }
    }

    var formData = FormData.fromMap(form_data_map);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    setState(() {
      is_uploading = true;
    });

    var response =
        await dio.post('${AppConfig.BASE_URL}/api/questions', data: formData);

    setState(() {
      is_uploading = false;
    });

    if (response == null) {
      Utils.showSnackBar("Failed to upload product. Please try again.", context,
          Colors.red.shade700);
      return;
    }

    if (response.data['status'] == null) {
      Utils.showSnackBar("Failed to upload product. Please try again.", context,
          Colors.red.shade700);
      return;
    }

    if (response.data['status'].toString() != '1') {
      Utils.showSnackBar(
          response.data['message'].toString(), context, Colors.white,
          background_color: Colors.red.shade700);
      return;
    } else {
      Utils.showSnackBar(
          response.data['message'].toString(), context, Colors.white,
          background_color: Colors.green.shade700);
    }

    Navigator.pop(context, {"task": 'success'});
  }

  void _show_bottom_sheet_photo(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () => {do_pick_image_from_camera()},
                      dense: false,
                      leading: Icon(
                        Icons.camera_alt,
                      ),
                      title: FxText.b1("Camera", fontWeight: 600),
                    ),
                    ListTile(
                        dense: false,
                        onTap: () => {do_pick_image()},
                        leading: Icon(
                          Icons.photo_library_sharp,
                        ),
                        title: FxText.b1("Gallery", fontWeight: 600)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  do_pick_image_from_camera() async {
    Navigator.pop(context);
    if (photos_picked.length > 15) {
      Utils.showSnackBar('Too many photos.', context, Colors.red.shade700);
      return;
    }

    final ImagePicker _picker = ImagePicker();
    final XFile? pic =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pic != null) {
      if (photos_picked.length < 16) {
        photos_picked.add(pic.path);
      }
    }
    setState(() {});
  }

  do_pick_image() async {
    Navigator.pop(context);
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    images?.forEach((element) {
      if (element.path == null) {
        return;
      }
      if (photos_picked.length < 16) {
        photos_picked.add(element.path);
      }
      // /data/user/0/jotrace.com/cache/image_picker3734385312125071389.jpg
    });
    setState(() {});
  }

  void romove_image_at(int image_position) {
    photos_picked.removeAt((image_position));
    setState(() {});
  }

  Future<void> pick_gps() async {
    Position p = await Utils.get_device_location();
    if (p != null) {
      latitude = p.latitude;
      longitude = p.longitude;
      setState(() {});
    }
  }

  List<CropCategory> categories = [];

  UserModel loggedUser = new UserModel();

  void my_init() async {
    loggedUser = await Utils.get_logged_in();
    loggedUser.init();
    if (loggedUser.id < 1) {
      Utils.showSnackBar("Login before you proceed.", context, Colors.red);
      Navigator.pop(context);
      return;
    }

    if (!loggedUser.profile_is_complete) {
      Utils.navigate_to(AppConfig.AccountEdit, context);
      return;
    }

    categories = await CropCategory.get_items();
    pests = await PestModel.get_items();
  }
}
