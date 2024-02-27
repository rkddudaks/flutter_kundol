// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
// import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
// import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/repos/address_repo.dart';
// import 'package:flutter_kundol/ui/add_address_screen.dart';
// import 'package:flutter_kundol/ui/payment_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Wallet", style: Theme.of(context).textTheme.titleLarge),
          elevation: 0.0,
        ),
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Current Credit"),
              Text(
                "\$0.00",
                style: TextStyle(color: Colors.black, fontSize: 21),
              )
            ],
          ),
        ));
  }
}
