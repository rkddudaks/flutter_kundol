// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/api/wooResponses/woo_shipping_method.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/checkout_repo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/checkout_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class PaymentScreen extends StatefulWidget {
  final List<WooCartData?> cartItems;
  final List<WooCoupon> couponData;
  final AddressData? addressData;
  final WooShippingMethod shippingMethod;

  PaymentScreen(
      this.cartItems, this.couponData, this.addressData, this.shippingMethod);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentScreen> {
  PaymentMethodsBloc? paymentMethodsBloc;

  @override
  void initState() {
    super.initState();

    paymentMethodsBloc = BlocProvider.of<PaymentMethodsBloc>(context);
    paymentMethodsBloc!.add(GetPaymentMethods());
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
        title: Text(AppLocalizations.of(context)!.translate('payment')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
        bloc: paymentMethodsBloc,
        builder: (context, state) {
          if (state is PaymentMethodsLoaded)
            return ListView.builder(
              itemCount: state.paymentMethods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
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
                                  widget.shippingMethod,
                                  state.paymentMethods[index],
                                  AppData.settingsResponse.onePageCheckout ==
                                      AppConstants.CHECKOUT_TYPE_DEFAULT))),
                    );
                  },
                  enabled: true,
                  leading: Icon(Icons.payment),
                  title: Text(state.paymentMethods[index].title!),
                );
              },
            );
          else if (state is PaymentMethodsError)
            return Text(state.error);
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
