import 'package:device_apps/device_apps.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/service/arifpay.dart';
import 'package:shop_app/service/checkout.dart';

class PaymentService {
  Arifpay arifpay = Arifpay.instance;
  Future<ArifpayCheckoutReponse> pay() async {
    bool isInstalled = await DeviceApps.isAppInstalled('net.arifpay.client');

    if (isInstalled) {
      //TODO:  call app by intent
    }
    arifpay.init(ArifPayOption(
        errorURL: "aps://net.arifpay.sample/error",
        successURL: "aps://net.arifpay.sample/success",
        cancleURL: "aps://net.arifpay.sample/cancle"));

    List<ArifpayCheckoutItem> items = demoCarts
        .map((e) => new ArifpayCheckoutItem(
            description: e.product.description,
            image: e.url,
            name: e.product.title,
            price: e.product.price,
            quantity: e.numOfItem))
        .toList();

    var session = await arifpay.checkout.create(items);
    print(session.sessionId);
    return session;
  }
}
