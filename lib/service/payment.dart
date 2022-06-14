import 'package:device_apps/device_apps.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/service/arifpay.dart';
import 'package:shop_app/service/checkout.dart';

class PaymentService {
  Arifpay arifpay = Arifpay.instance;
  Future<void> pay() async {
    bool isInstalled = await DeviceApps.isAppInstalled('net.arifpay.client');

    if (isInstalled) {
      //TODO:  call app by intent
    }
    arifpay.init(ArifPayOption(
        errorURL: "net.arifpay.sample",
        successURL: "net.arifpay.sample",
        cancleURL: "net.arifpay.sample"));

    List<ArifpayCheckoutItem> items = demoCarts
        .map((e) => new ArifpayCheckoutItem(
            description: e.product.description,
            image: e.url,
            price: e.product.price,
            quantity: e.numOfItem))
        .toList();

    var session = await arifpay.checkout.create(items);

    print(session.sessionId);
  }
}
