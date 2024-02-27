// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/countriesRepo.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
import 'package:flutter_kundol/ui/add_address_screen.dart';
// import 'package:flutter_kundol/ui/payment_screen.dart';
import 'package:flutter_kundol/ui/shipping_methods_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final List<WooCartData> cartItems;
  final List<WooCoupon> couponData;

  ShippingScreen(this.cartItems, this.couponData);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<ShippingScreen> {
  // int _activeStepIndex = 0;

/*
  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Shipping'),
            content: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                        create: (BuildContext context) {
                                      return AddAddressBloc(RealAddressRepo());
                                    }),
                                    BlocProvider(
                                        create: (context) =>
                                            CountriesBloc(RealCountriesRepo())),
                                  ],
                                  child: AddAddressScreen(
                                      widget.cartItems, widget.couponData))),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppStyles.CARD_RADIUS),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppStyles
                                  .CARD_RADIUS) //                 <--- border radius here
                              ),
                        ),
                        padding: EdgeInsets.only(top: 40, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Add A New Address"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AddressBloc, AddressState>(
                  bloc: BlocProvider.of<AddressBloc>(context),
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is AddressLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.addressData.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 12, bottom: 0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppStyles.CARD_RADIUS),
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppStyles
                                        .CARD_RADIUS) //                 <--- border radius here
                                    ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
                                            widget.cartItems,
                                            widget.couponData,
                                            state.addressData[index])),
                                  );
                                },
                                enabled: true,
                                isThreeLine: true,
                                leading: Icon(Icons.location_pin),
                                title: Text(state.addressData[index].customer
                                        .customerFirstName +
                                    " " +
                                    state.addressData[index].customer
                                        .customerLastName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(state.addressData[index].city),
                                    Text(
                                        state.addressData[index].streetAddress),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is AddressError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Payment'),
            content: Container()),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Review'),
            content: Container())
      ];
*/

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
        title: Text(AppLocalizations.of(context)!.translate('shipping')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
/*
      body:Stepper(
        elevation: 0.0,
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
      ),
*/
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (BuildContext context) {
                                  return AddAddressBloc(RealAddressRepo());
                                }),
                                BlocProvider(
                                    create: (context) =>
                                        CountriesBloc(RealCountriesRepo())),
                              ],
                              child: AddAddressScreen(
                                  widget.cartItems, widget.couponData))),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppStyles.CARD_RADIUS)),
                    ),
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(AppLocalizations.of(context)!
                            .translate('add_new_address')!),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<AddressBloc, AddressState>(
              bloc: BlocProvider.of<AddressBloc>(context),
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.addressData.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 12, bottom: 0),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppStyles.CARD_RADIUS),
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppStyles
                                    .CARD_RADIUS) //                 <--- border radius here
                                ),
                          ),
                          child: ListTile(
                            onTap: () {
                              AddressData address = new AddressData();
                              address.firstName =
                                  state.addressData[index].firstName;
                              address.lastName =
                                  state.addressData[index].lastName;
                              address.country = WooCountry.fromValue(
                                  state.addressData[index].country);
                              address.state = WooState.fromValue(
                                  state.addressData[index].state);
                              address.address1 =
                                  state.addressData[index].address1;
                              address.city = state.addressData[index].city;
                              address.phone = state.addressData[index].phone;
                              address.postcode =
                                  state.addressData[index].postcode;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShippingMethodsScreen(
                                        widget.cartItems,
                                        widget.couponData,
                                        address)),
                              );
                            },
                            enabled: true,
                            isThreeLine: true,
                            leading: Icon(Icons.location_pin),
                            title: Text(state.addressData[index].firstName! +
                                " " +
                                state.addressData[index].lastName!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(state.addressData[index].city!),
                                Text(state.addressData[index].address1!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is AddressError) {
/*
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
*/
                  return Center(child: Text(state.error));
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
