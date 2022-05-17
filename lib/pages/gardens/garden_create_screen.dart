import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ict4farmers/models/CropCategory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/FormItemModel.dart';
import '../../models/ProductModel.dart';
import '../../models/UserModel.dart';
import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../location_picker/location_main.dart';
import '../option_pickers/multiple_option_picker.dart';

class GardenCreateScreen extends StatefulWidget {
  @override
  State<GardenCreateScreen> createState() => GardenCreateScreenState();
}

late CustomTheme customTheme;

class GardenCreateScreenState extends State<GardenCreateScreen> {
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
    String _title = "Creating new garden";
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
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 15,
                              top: 5,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                    name: "name",
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: "Name is required.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        context,
                                        2,
                                        errorText: "Name too short.",
                                      ),
                                      FormBuilderValidators.maxLength(
                                        context,
                                        45,
                                        errorText: "Title too long.",
                                      ),
                                    ]),
                                    decoration: customTheme.input_decoration_2(
                                        labelText: "Garden name",
                                        hintText:
                                            "What is the name of this item?")),
                                FxDashedDivider(
                                  color: Colors.grey.shade300,
                                ),
                                FormBuilderTextField(
                                    name: "size",
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: "Garden size is required",
                                      ),
                                    ]),
                                    decoration: customTheme.input_decoration_2(
                                        labelText: "Garden size (in Acres)",
                                        hintText:
                                            "How much is big is the land?")),
                                FxDashedDivider(
                                  color: Colors.grey.shade300,
                                ),
                                FormBuilderDateTimePicker(
                                    name: "plant_date",
                                    textInputAction: TextInputAction.next,
                                    inputType: InputType.date,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: "Planting date is required",
                                      ),
                                    ]),
                                    decoration: customTheme.input_decoration_2(
                                        labelText: "Planting date",
                                        hintText:
                                            "When did you plant this crop?")),
                                FxDashedDivider(
                                  color: Colors.grey.shade300,
                                ),
                                FormBuilderDateTimePicker(
                                    name: "harvest_date",
                                    textInputAction: TextInputAction.next,
                                    inputType: InputType.date,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: "Harvest date is required",
                                      ),
                                    ]),
                                    decoration: customTheme.input_decoration_2(
                                        labelText: "Harvest date",
                                        hintText:
                                            "When did you expect to harvest?")),
                                FxDashedDivider(
                                  color: Colors.grey.shade300,
                                ),
                                FormBuilderTextField(
                                    name: "details",
                                    minLines: 2,
                                    maxLines: 4,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: "Description is required.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        context,
                                        5,
                                        errorText: "Description too short.",
                                      ),
                                    ]),
                                    decoration: customTheme.input_decoration_2(
                                        labelText: "Garden description",
                                        hintText:
                                            "Write something about this garden")),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade100,
                            height: 25,
                          ),
                          InkWell(
                            onTap: () => {pick_crop()},
                            child: Container(
                              padding: FxSpacing.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FxSpacing.width(16),
                                  Expanded(
                                    child: FxText.b1(
                                      'Crop',
                                      fontSize: 18,
                                      fontWeight: 500,
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        FxText(
                                          category_text,
                                          color: Colors.grey.shade500,
                                        ),
                                        Icon(CupertinoIcons.right_chevron,
                                            size: 22,
                                            color: Colors.grey.shade600),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: 1,
                          ),
                          Container(
                            padding: FxSpacing.all(20),
                            child: InkWell(
                              onTap: () {
                                pick_location();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FxSpacing.width(16),
                                  Expanded(
                                    child: FxText.b1(
                                      'Location',
                                      fontSize: 18,
                                      fontWeight: 500,
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        FxText(
                                          location_sub_name,
                                          color: Colors.grey.shade500,
                                        ),
                                        Icon(CupertinoIcons.right_chevron,
                                            size: 22,
                                            color: Colors.grey.shade600),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: 1,
                          ),
                          InkWell(
                            onTap: () {
                              pick_gps();
                            },
                            child: Container(
                              padding: FxSpacing.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FxSpacing.width(16),
                                  Expanded(
                                    child: FxText.b1(
                                      'Garden GPS',
                                      fontSize: 18,
                                      fontWeight: 500,
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        FxText(
                                          '${latitude},${longitude}',
                                          color: Colors.grey.shade500,
                                        ),
                                        Icon(CupertinoIcons.right_chevron,
                                            size: 22,
                                            color: Colors.grey.shade600),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: 1,
                          ),
                          Container(
                            color: Colors.grey.shade100,
                            height: 25,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            color: Colors.white,
                            child: Text(
                                "Add garden's photos. Not more than 15 photos."),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return single_image_picker(
                        index, photos_picked[index].toString(), context);
                  },
                  childCount: photos_picked.length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              right: 20,
                            ),
                            child: (is_uploading)
                                ? CircularProgressIndicator(
                                    color: CustomTheme.primary,
                                    strokeWidth: 2,
                                  )
                                : FxButton.block(
                                    borderRadiusAll: 8,
                                    onPressed: () {
                                      do_upload_process();
                                    },
                                    backgroundColor: CustomTheme.primary,
                                    child: FxText.l1(
                                      "SUBMIT",
                                      fontSize: 20,
                                      color: customTheme.cookifyOnPrimary,
                                    )),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
            ],
          ),
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
            onTap: () => {do_pick_image()},
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

  String crop_category_id = "";
  String category_text = "";
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

  Future<void> pick_crop() async {
    if (crop_categories.isEmpty) {
      crop_categories = await CropCategory.get_items();
    }
    if (crop_categories.isEmpty) {
      Utils.showSnackBar(
          "Please connect to internet and try again.", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    List<OptionPickerModel> local_items = [];

    crop_categories.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = element.parent.toString();
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultipleOptionPicker(
              "Select crop category", "Select crop", local_items)),
    );

    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        crop_category_id = result['id'];
        category_text = result['text'];
        setState(() {});
      }
    }
  }

  void do_upload_process() async {
    error_message = "";
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      print("First fix shit");
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

    bool first_found = false;
    form_data_map['administrator_id'] = userModel.id;

    form_data_map["name"] =
        _formKey.currentState?.fields['name']?.value;

    form_data_map["plant_date"] =
        _formKey.currentState?.fields['plant_date']?.value;


    form_data_map["harvest_date"] =
        _formKey.currentState?.fields['harvest_date']?.value;

    form_data_map['size'] =
        _formKey.currentState?.fields['size']?.value;
    form_data_map['details']  =
        _formKey.currentState?.fields['details']?.value;

    if (crop_category_id.isEmpty) {
      Utils.showSnackBar(
          "Please pick crop planted in this garden.", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    if (location_id.isEmpty) {
      Utils.showSnackBar("Please pick item location", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    if (latitude == 0.00 || longitude == 0.0) {
      Utils.showSnackBar("Please collect garden's GPS", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    if (photos_picked.length < 2) {
      Utils.showSnackBar("Please add at least one photo", context, Colors.white,
          background_color: Colors.red);
      return;
    }

    form_data_map['crop_category_id'] = crop_category_id;
    form_data_map['location_id'] = location_id;

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




    print(form_data_map);
    print("Good to go!");
    return;

    var formData = FormData.fromMap(form_data_map);
    var dio = Dio();
    setState(() {
      is_uploading = true;
    });

    var response =
        await dio.post('${AppConfig.BASE_URL}/api/products', data: formData);

    await ProductModel.get_user_products(userModel.id);
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
          response.data['status'].toString(), context, Colors.red.shade700);
      return;
    }
    await ProductModel.get_user_products(userModel.id);
    //await FormItemModel.delete_all();
    Utils.showSnackBar(
        response.data['message'].toString(), context, CustomTheme.onPrimary);

    Navigator.pop(context, {"task": 'success'});
  }

  do_pick_image() async {
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

  List<CropCategory> crop_categories = [];

  void my_init() async {
    crop_categories = await CropCategory.get_items();
  }
}
/*






-> image


-> administrator_id

 */