import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:ict4farmers/theme/app_theme.dart';
import 'package:ict4farmers/widgets/images.dart';

class AccountRegister extends StatefulWidget {
  @override
  _AccountRegisterState createState() => _AccountRegisterState();
}

class _AccountRegisterState extends State<AccountRegister> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: CustomTheme.primary.withAlpha(40))),
      child: Scaffold(
        body: ListView(
          padding: FxSpacing.fromLTRB(24, 110, 24, 0),
          children: [
            Container(
              child: Image.asset(
                Images.logo_2,
                height: 70,
              ),
            ),
            FxSpacing.height(16),
            FxText.h3(
              "Create an Account",
              color: CustomTheme.primary,
              fontWeight: 800,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(32),
            FxTextField(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              autoFocusedBorder: true,
              textFieldStyle: FxTextFieldStyle.outlined,
              textFieldType: FxTextFieldType.name,
              filled: true,
              fillColor: CustomTheme.primary.withAlpha(40),
              enabledBorderColor: CustomTheme.primary,
              focusedBorderColor: CustomTheme.primary,
              prefixIconColor: CustomTheme.primary,
              labelTextColor: CustomTheme.primary,
              cursorColor: CustomTheme.primary,
            ),
            FxSpacing.height(24),
            FxTextField(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              autoFocusedBorder: true,
              textFieldStyle: FxTextFieldStyle.outlined,
              textFieldType: FxTextFieldType.email,
              filled: true,
              fillColor: CustomTheme.primary.withAlpha(40),
              enabledBorderColor: CustomTheme.primary,
              focusedBorderColor: CustomTheme.primary,
              prefixIconColor: CustomTheme.primary,
              labelTextColor: CustomTheme.primary,
              cursorColor: CustomTheme.primary,
            ),
            FxSpacing.height(24),
            FxTextField(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              autoFocusedBorder: true,
              textFieldStyle: FxTextFieldStyle.outlined,
              textFieldType: FxTextFieldType.password,
              filled: true,
              fillColor: CustomTheme.primary.withAlpha(40),
              enabledBorderColor: CustomTheme.primary,
              focusedBorderColor: CustomTheme.primary,
              prefixIconColor: CustomTheme.primary,
              labelTextColor: CustomTheme.primary,
              cursorColor: CustomTheme.primary,
            ),
            FxSpacing.height(16),
            Align(
              alignment: Alignment.centerRight,
              child: FxButton.text(
                  padding: FxSpacing.zero,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              Text("CookifyForgotPasswordScreen")),
                    );
                  },
                  splashColor: CustomTheme.primary.withAlpha(40),
                  child:
                      FxText.b3("Forgot Password?", color: CustomTheme.accent)),
            ),
            FxSpacing.height(16),
            FxButton.block(
                borderRadiusAll: 8,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => Text("CookifyFullApp")),
                  );
                },
                backgroundColor: CustomTheme.primary,
                child: FxText.l1(
                  "Create an Account",
                  color: customTheme.cookifyOnPrimary,
                )),
            FxSpacing.height(16),
            FxButton.text(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => Text("CookifyLoginScreen")),
                  );
                },
                splashColor: CustomTheme.primary.withAlpha(40),
                child: FxText.l2("I have already an account",
                    decoration: TextDecoration.underline,
                    color: CustomTheme.accent)),
            FxSpacing.height(16),
          ],
        ),
      ),
    );
  }
}
