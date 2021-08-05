import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vinto/data/blocs/cart.dart';
import 'package:vinto/data/blocs/order-bloc.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/cart/service.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:vinto/utils/ui/essentials.dart';
import 'package:vinto/widgets/loader.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

final _cartBloc = getIt.get<CartBloc>();
// final _order = getIt.get<OrderBloc>();
final _cartService = new CartServices();

class MainCartScreen extends StatefulWidget {
  final Product product;

  const MainCartScreen({Key key, this.product}) : super(key: key);
  @override
  _MainCartScreenState createState() => _MainCartScreenState();
}

class _MainCartScreenState extends State<MainCartScreen> {
  bool _loading = false;
  bool _paying = false;
  Map<String, dynamic> intentData = {};

  Future prepareSheet() async {
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: intentData['client_secret'],
              style: ThemeMode.system,
              merchantCountryCode: "US",
              merchantDisplayName: "Near To Me Delivery"));
      await displayPaymentSheet();
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: intentData['client_secret'], confirmPayment: true));

      Get.snackbar('Payment Success'.tr, "Successfully paid for orders",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Mycolors.green,
          colorText: Colors.white);
      await clearCart();
      Logger().d("Reached");
    } on Exception catch (e) {
      Logger().e(e);
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error from Stripe: ${(e as StripeException).error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unknown error: $e'),
          ),
        );
      }
    }
  }

  Future clearCart() async {
    setState(() {
      _loading = true;
    });
    final _result = await _cartService.clearCart();

    _result.fold((l) {
      Get.snackbar('Cart Error'.tr, l.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }, (r) {
      Get.snackbar('Cart Cleared'.tr, "Cart Successfully cleared",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Mycolors.green,
          colorText: Colors.white);
      _cartBloc.getOrders(reload: true);
    });

    setState(() {
      _loading = false;
    });
  }

  Future payForCart() async {
    setState(() {
      _paying = true;
    });
    final _result = await _cartService.pay();

    _result.fold((l) {
      Get.snackbar('Payment Error'.tr, l.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      setState(() {
        _paying = false;
      });
    }, (r) async {
      setState(() {
        intentData = r;
      });

      await prepareSheet();
    });

    setState(() {
      _paying = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cartBloc.getOrders();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Cart',
          style: TextStyle(
              // fontSize: ,
              fontFamily: 'Gill medium',
              color: Mycolors.blacktext,
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: StreamBuilder<OrderState>(
          stream: _cartBloc.nearbyStream,
          builder: (BuildContext context, snapshot) {
            return _cartBloc.nearby.data == null
                ? Container()
                : _cartBloc.nearby.data.fold((l) => Container(), (r) {
                    return r.isEmpty
                        ? Container()
                        : Wrap(
                            spacing: 10,
                            children: [
                              FloatingActionButton.extended(
                                  elevation: 0,
                                  icon: Icon(Icons.clear),
                                  backgroundColor: Mycolors.green,
                                  onPressed: _loading
                                      ? () {}
                                      : () async => await clearCart(),
                                  label: _loading
                                      ? Loader(
                                          color: Colors.white,
                                        )
                                      : Text("clear")),
                              FloatingActionButton.extended(
                                  elevation: 0,
                                  icon: Icon(Icons.payment),
                                  backgroundColor: Mycolors.green,
                                  onPressed: _paying
                                      ? () {}
                                      : () async => payForCart(),
                                  label: _paying
                                      ? Loader(
                                          color: Colors.white,
                                        )
                                      : Text("Pay"))
                            ],
                          );
                  });
          }),
      body: StreamBuilder<OrderState>(
        stream: _cartBloc.nearbyStream,
        builder: (BuildContext context, snapshot) {
          if (_cartBloc.nearby.status == LoadingState.loading) {
            return SingleChildScrollView(
              child: Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                    width: 30,
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('loading orders'),
                  )
                ]),
              ),
            );
          } else {
            return _cartBloc.nearby.data.fold(
              (l) => SingleChildScrollView(
                child: Center(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(
                      Icons.error_outlined,
                      color: Colors.amber,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(l.message),
                    ),
                    TextButton(
                        onPressed: () => _cartBloc.getOrders(reload: true),
                        child: Text('retry'))
                  ]),
                ),
              ),
              (r) => r.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () async => await _cartBloc.getOrders(),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 300,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.greenAccent,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text("Cart is Empty."),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        _cartBloc.getOrders(reload: true),
                                    child: Text('retry'))
                              ]),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          var _or = r[index];
                          return ListTile(
                            leading: networkImageLoader(
                                height: 50,
                                width: 50,
                                url: ApiEndPoints.IMAGE_URL +
                                    "/" +
                                    _or.product.image),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "QTY",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(_or.quantity.toString()),
                              ],
                            ),
                            title: Text(_or.product.name),
                            subtitle: Text(_or.product.description),
                          );
                        },
                        itemCount: r.length,
                      )),
            );
          }
        },
      ),
    );
  }
}

class QRVIEWERR extends StatelessWidget {
  final ScrollController controller;
  final String code;
  const QRVIEWERR({Key key, this.controller, this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        "QR Code",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                          ),
                          onPressed: () => Navigator.pop(context))
                    ],
                  )),
            )),
            SliverToBoxAdapter(
              child: Center(
                child: QrImage(
                  data: code,
                  version: QrVersions.auto,
                  size: 220,
                  gapless: false,
                ),
              ),
            )
          ],
        ));
  }
}
