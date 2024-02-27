// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
// import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
// import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/blocs/shipping_method/shipping_methods_bloc.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
// import 'package:flutter_kundol/repos/checkout_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
// import 'package:flutter_kundol/ui/checkout_screen.dart';
import 'package:flutter_kundol/ui/payment_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class ShippingMethodsScreen extends StatefulWidget {
  final List<WooCartData?> cartItems;
  final List<WooCoupon> couponData;
  final AddressData? addressData;

  ShippingMethodsScreen(this.cartItems, this.couponData, this.addressData);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<ShippingMethodsScreen> {
  ShippingMethodsBloc? shippingMethodsBloc;

  @override
  void initState() {
    super.initState();

    shippingMethodsBloc = BlocProvider.of<ShippingMethodsBloc>(context);
    shippingMethodsBloc!.add(GetShippingMethods(widget.addressData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
            AppLocalizations.of(context)!.translate('shipping_methods')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocBuilder<ShippingMethodsBloc, ShippingMethodsState>(
        bloc: shippingMethodsBloc,
        builder: (context, state) {
          if (state is ShippingMethodsLoaded)
            return ListView.builder(
              itemCount: state.shippingMethodsResponse.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                              widget.cartItems,
                              widget.couponData,
                              widget.addressData,
                              state.shippingMethodsResponse[index])),
                    );
/*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (BuildContext context) {
                                return CheckoutBloc(RealCheckoutRepo());
                              },
                              child: CheckoutScreen(
                                  widget.cartItems,
                                  widget.couponData,
                                  widget.addressData,
                                  state.paymentMethodsResponse.data[index]))),
                    );
*/
                  },
                  enabled: true,
                  leading: Icon(Icons.local_shipping_outlined),
                  title: Text(state.shippingMethodsResponse[index].title!),
                  subtitle:
                      Text(state.shippingMethodsResponse[index].methodTitle!),
                  trailing: Text(
                      (state.shippingMethodsResponse[index].settings!.cost !=
                              null)
                          ? "\$" +
                              double.parse(state.shippingMethodsResponse[index]
                                      .settings!.cost!.value!)
                                  .toStringAsFixed(2)
                          : ""),
                );
              },
            );
          else if (state is ShippingMethodsError)
            return Text(state.error);
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
