import 'package:flutter/cupertino.dart';
import 'package:ict4farmers/pages/HomPage.dart';

import 'AppConfig.dart';

class Utils {
  static navigate_to(String screen, context, {dynamic data: null}) {
    switch (screen) {
      case AppConfig.HomePage:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }
}
