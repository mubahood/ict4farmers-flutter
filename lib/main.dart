import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/themes/app_theme_notifier.dart';
import '../../localizations/app_localization_delegate.dart';
import '../../localizations/language.dart';
import '../../pages/account/onboarding_widget.dart';
import '../../pages/homes/homes_screen.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../utils/Utils.dart';
import 'package:provider/provider.dart';

//I love romina
//FROM DISK D
void main() {
  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();

  AppTheme.init();

  //
  Utils.init_databse();
  Utils.boot_system();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: ChangeNotifierProvider<FxAppThemeNotifier>(
        create: (context) => FxAppThemeNotifier(),
        child: MyApp(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          builder: (context, child) {
            return Directionality(
              textDirection: AppTheme.textDirection,
              child: child!,
            );
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context), // Add this line
          ],
          supportedLocales: Language.getLocales(),
          home: OnBoardingWidget2(),
          routes: {
            '/OnBoardingWidget': (context) => OnBoardingWidget2(),
            '/HomesScreen': (context) => HomesScreen(),
          },
        );
      },
    );
  }
}

class GlobalMaterialLocalizations {}
