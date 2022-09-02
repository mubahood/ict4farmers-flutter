import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/UserModel.dart';
import '../../pages/location_picker/location_main.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../../widget/shimmer_loading_widget.dart';
import '../location_picker/product_category_picker.dart';

class AccountEdit extends StatefulWidget {
  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final _formKey = GlobalKey<FormBuilderState>();

  late CustomTheme customTheme;
  late ThemeData theme;
  String error_message = "";

  bool onLoading = false;

  UserModel item = new UserModel();



  Future<void> my_init() async {
    item = await Utils.get_logged_in();
    if (item.id < 1) {
      Utils.showSnackBar("Login before you proceed.", context, Colors.red);
      Navigator.pop(context);
      return;
    }

    if (item.email == "null") {
      item.email = "";
    }
    if (item.company_name == "null") {
      item.company_name = "";
    }
    if (item.phone_number == "null") {
      item.phone_number = "";
    }
    if (item.address == "null") {
      item.address = "";
    }
    if (item.services == "null") {
      item.services = "";
    }
    if (item.about == "null") {
      item.about = "";
    }


    if (item.whatsapp == "null") {
      item.whatsapp = "";
    }

    if (item.latitude == "null" ||
        item.longitude == "null" ||
        item.latitude.isEmpty ||
        item.longitude.isEmpty) {
      item.latitude = "0.00";
      item.longitude = "0.00";
    }

    item.email = item.username;

    _formKey.currentState!.patchValue({
      'name': item.name,
      'email': item.username,
      'company_name': item.company_name,
      'phone_number': item.phone_number,
      'address': item.address,
      'services': item.services,
      'about': item.about,
      'facebook': '',
      'whatsapp': item.whatsapp,
      'district': '',
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    my_init();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {


    Future<void> submit_form() async {
      error_message = "";
      setState(() {});
      if (!_formKey.currentState!.validate()) {
        Utils.showSnackBar(
            "Please Check errors in the form and fix them first.",
            context,
            Colors.white,
            background_color: Colors.red);

        return;
      }

      Map<String, dynamic> form_data_map = {};

      form_data_map = {
        'name': _formKey.currentState?.fields['name']?.value,
        'user_id': item.id.toString(),
        'company_name': _formKey.currentState?.fields['company_name']?.value,
        'email': _formKey.currentState?.fields['email']?.value,
        'phone_number': _formKey.currentState?.fields['phone_number']?.value,
        'address': _formKey.currentState?.fields['address']?.value,
        'services': _formKey.currentState?.fields['services']?.value,
        'about': _formKey.currentState?.fields['about']?.value,
        'district': '',
        'division': '',
        'twitter': '',
        'whatsapp': _formKey.currentState?.fields['whatsapp']?.value,
        'instagram': '',
      };

      if ((new_dp != null) && new_dp.length > 4) {
        try {
          var img =
              await MultipartFile.fromFile(new_dp, filename: 'profile_pic');
          if (img != null) {
            form_data_map['profile_pic'] = img;
          }
        } catch (e) {}
      }

      onLoading = true;
      setState(() {});

      var formData = FormData.fromMap(form_data_map);
      var dio = Dio();
      var response = null;

       try {
        response = await dio.post('${AppConfig.BASE_URL}/api/users-update',
            data: formData);
      } on DioError catch (e) {

      }

      onLoading = false;
      setState(() {});

      if (response == null) {
        Utils.showSnackBar("Failed to upload product. Please try again.",
            context, Colors.white);
        return;
      }

      Map<String, dynamic> resp_obg = response.data;
      if (resp_obg['status'].toString() != "1") {
        error_message = resp_obg['message'];

        Utils.showSnackBar(error_message, context, Colors.white,
            background_color: CustomTheme.primary);

        setState(() {});
        return;
      }

      UserModel u = UserModel.fromMap(resp_obg['data']);

      Utils.showSnackBar(
          "Profile updated successfully!.", context, Colors.white,
          background_color: CustomTheme.primary);

      u.status = 'logged_in';
      //await Utils.login_user(u);
      if (await Utils.login_user(u)) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/HomesScreen", (r) => false);
      } else {
        error_message =
            "Account created but failed to login. Please try again.";
        setState(() {});
      }
    }

    /*

    whatsapp

----
cover_photo
avatar
username
password

     */
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: CustomTheme.primary.withAlpha(40))),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: .5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "My Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  submit_form();
                },
                child: Container(
                    padding: FxSpacing.x(0),
                    child: onLoading ? Text("Loading...") : Icon(Icons.done)),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: FxSpacing.fromLTRB(20, 10, 20, 0),
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                        FxContainer.rounded(
                          paddingAll: 0,
                          width: 100,
                          height: 100,
                          child: (new_dp.length > 3)
                              ? Image.file(
                                  File(new_dp),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  imageUrl: item.avatar,
                                  placeholder: (context, url) =>
                                      ShimmerLoadingWidget(
                                    height: 100,
                                    width: 100,
                                  ),
                                  errorWidget: (context, url, error) => Image(
                                    image: AssetImage(
                                        './assets/project/no_image.jpg'),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        FxSpacing.height(8),
                        FxButton.text(
                            onPressed: () {
                              do_pick_image("gallery");
                              //_show_bottom_sheet_photo(context);
                            },
                            splashColor: CustomTheme.primary.withAlpha(40),
                            child: FxText.l2("Change Photo",
                                fontSize: 14,
                                textAlign: TextAlign.center,
                                color: CustomTheme.accent)),
                      ],
                    ),
                  ),
                  FxSpacing.height(15),
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
                          errorText: "Name too long.",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Name", icon: Icons.person)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "email",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "Email address required.",
                        ),
                        FormBuilderValidators.email(
                          context,
                          errorText: "Enter valid email address.",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Email address (Username)",
                          icon: Icons.alternate_email)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "phone_number",
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "Phone number required.",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Phone number", icon: Icons.phone)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "company_name",
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "Company name required.",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Business name",
                          icon: Icons.business)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "address",
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "Address required.",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Business address",
                          icon: Icons.map_outlined)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "services",
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 4,
                      minLines: 4,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "Services required",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "Services offered",
                          icon: Icons.volunteer_activism)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "about",
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 8,
                      minLines: 4,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: "About is required",
                        ),
                      ]),
                      decoration: customTheme.input_decoration(
                          labelText: "About Company/Business",
                          icon: Icons.info)),
                  FxSpacing.height(10),
                  FormBuilderTextField(
                      name: "whatsapp",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.url,
                      decoration: customTheme.input_decoration(
                          labelText: "Whatsapp number", icon: Icons.whatsapp)),
                  FxSpacing.height(10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade50,
                    ),
                    child: error_message.isEmpty
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : Container(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              error_message,
                              style: TextStyle(color: Colors.red.shade800),
                            ),
                          ),
                  ),
                  FxSpacing.height(10),
                  onLoading
                      ? Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        )
                      : FxButton.block(
                          borderRadiusAll: 8,
                          onPressed: () {
                            submit_form();
                          },
                          backgroundColor: CustomTheme.primary,
                          child: FxText.l1(
                            "UPDATE PROFILE",
                            color: customTheme.cookifyOnPrimary,
                          )),
                  FxSpacing.height(16),
                  FxButton.text(
                      onPressed: () {
                        Utils.navigate_to(AppConfig.PrivacyPolicy, context);
                      },
                      splashColor: CustomTheme.primary.withAlpha(40),
                      child: FxText.l2(
                          "I have read and accepted ${AppConfig.AppName} privacy policy.",
                          decoration: TextDecoration.underline,
                          textAlign: TextAlign.center,
                          color: CustomTheme.accent)),
                  FxSpacing.height(16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pick_category() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductCategoryPicker()),
    );

    if (result != null) {
      if ((result['category_id'] != null) &&
          (result['category_text'] != null)) {
        item.category_id = result['category_id'];
        item.division = result['category_text'];
        _formKey.currentState!.patchValue({
          'division': item.division,
        });
      }
    }
  }

  Future<void> pick_location() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationMain()),
    );

    if (result != null) {
      if ((result['location_sub_id'] != null) &&
          (result['location_sub_name'] != null)) {
        item.district = result['location_sub_name'];
        item.sub_county = result['location_sub_id'];
        _formKey.currentState!.patchValue({
          'district': item.district,
        });
      }
    }
  }

  void _show_bottom_sheet_photo(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /*ListTile(
                      onTap: () => {do_pick_image("camera")},
                      dense: false,
                      leading: Icon(Icons.camera_alt,
                          color: theme.colorScheme.onBackground),
                      title: FxText.b1("Camera", fontWeight: 600),
                    ),*/
                    ListTile(
                        dense: false,
                        onTap: () => {do_pick_image("gallery")},
                        leading: Icon(Icons.photo_library_sharp,
                            color: theme.colorScheme.onBackground),
                        title: FxText.b1("Gallery", fontWeight: 600)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  List<XFile>? temp_images = [];

  String new_dp = "";

  do_pick_image(String source) async {
    //SNavigator.pop(context);

    new_dp = "";

    final ImagePicker _picker = ImagePicker();
    temp_images = [];
    if (source == "camera") {
      final XFile? pic = await _picker.pickImage(
          source: ImageSource.camera, imageQuality: 100);
      if (pic != null) {
        temp_images?.add(pic);
        new_dp = pic.path;
      }
    } else {
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        temp_images?.add(pic);
      }
    }

    temp_images?.forEach((element) {
      if (element.path == null) {
        return;
      }
      new_dp = element.path;
    });

    setState(() {});
  }
}
