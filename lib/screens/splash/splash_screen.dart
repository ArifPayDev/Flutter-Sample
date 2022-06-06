import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/checkout_fail/checkout_error_screen.dart';
import 'package:shop_app/screens/checkout_success/checkout_success_screen.dart';
import 'package:shop_app/screens/splash/components/body.dart';
import 'package:shop_app/size_config.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    initUniLinks(context);
    return Scaffold(
      body: Body(),
    );
  }

  Future<void> initUniLinks(context) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      print(initialLink);
      if (initialLink == "/app/success") {
        Navigator.of(context).pushNamed(CheckoutSuccessScreen.routeName);
      }
      if (initialLink == "/app/fail") {
        Navigator.of(context).pushNamed(CheckoutFailScreen.routeName);
      }
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
      rethrow;
    }
  }
}
