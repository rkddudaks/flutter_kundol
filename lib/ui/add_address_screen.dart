import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_cart_data.dart';
import 'package:flutter_kundol/api/wooResponses/woo_coupon.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/constants/app_config.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
// import 'package:flutter_kundol/models/country.dart';
// import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
// import 'package:flutter_kundol/ui/payment_screen.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/ui/shipping_methods_screen.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class AddAddressScreen extends StatefulWidget {
  final List<WooCartData?> cartItems;
  final List<WooCoupon> couponData;

  AddAddressScreen(this.cartItems, this.couponData);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  double latitude = 0.0, longitude = 0.0;
  WooCountry? selectedCountry;
  WooState? selectedState;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountriesBloc>(context).add(GetCountries());

    if (AppData.wooUser!.billing!.firstName!.isNotEmpty)
      _firstNameController.text = AppData.wooUser!.billing!.firstName!;
    if (AppData.wooUser!.billing!.lastName!.isNotEmpty)
      _lastNameController.text = AppData.wooUser!.billing!.lastName!;
    if (AppData.wooUser!.billing!.address1!.isNotEmpty)
      _addressController.text = AppData.wooUser!.billing!.address1!;
    if (AppData.wooUser!.billing!.city!.isNotEmpty)
      _cityController.text = AppData.wooUser!.billing!.city!;
    if (AppData.wooUser!.billing!.postcode!.isNotEmpty)
      _postCodeController.text = AppData.wooUser!.billing!.postcode!;
    if (AppData.wooUser!.billing!.phone!.isNotEmpty)
      _phoneController.text = AppData.wooUser!.billing!.phone!;
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
        title: Text(AppLocalizations.of(context)!.translate('add_address')!,
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocListener<AddAddressBloc, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressLoaded) {
            //BlocProvider.of<AddressBloc>(context).add(GetAddress());
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShippingMethodsScreen(
                      widget.cartItems, widget.couponData, state.addressData)),
            );
          } else if (state is AddAddressError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         padding: EdgeInsets.only(left: 15, right: 15),
                      //         child: TextFormField(
                      //           controller: _firstNameController,
                      //           decoration: InputDecoration(
                      //             hintText: "First Name",
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey[400], fontSize: 12),
                      //             border: InputBorder.none,
                      //           ),
                      //           validator: (value) {
                      //             if (value == null || value.isEmpty) {
                      //               return 'Please enter Your First name';
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         padding: EdgeInsets.only(left: 15, right: 15),
                      //         child: TextFormField(
                      //           controller: _lastNameController,
                      //           decoration: InputDecoration(
                      //             hintText: "Last Name",
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey[400], fontSize: 12),
                      //             border: InputBorder.none,
                      //           ),
                      //           validator: (value) {
                      //             if (value == null || value.isEmpty) {
                      //               return 'Please enter Your Last Name';
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('first_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('first_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your First name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('last_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('last_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 12),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Last Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('country_name_title')!)),
                      BlocBuilder<CountriesBloc, CountriesState>(
                        builder: (context, state) {
                          if (state is CountriesLoaded) {
                            List<WooCountry> countryDataList =
                                state.countriesResponse.countries!;
                            countryDataList.forEach((element) {
                              if (element.value ==
                                  AppData.wooUser!.billing!.country) {
                                selectedCountry = element;
                              }
                            });

                            if (selectedCountry != null)
                              selectedCountry!.states!.forEach((element) {
                                if (AppData.wooUser!.billing!.state ==
                                    element.value) {
                                  selectedState = element;
                                }
                              });
/*
                            WooCountry otherCountryData = WooCountry();
                            otherCountryData.name = "Other";
                            otherCountryData.value = "Other";
                            countryDataList.add(otherCountryData);
*/
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0), // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0)), // set rounded corner radius
                                    ),
                                    child: SizedBox(
                                      height: 45,
                                      child: DropdownSearch<WooCountry>(
                                        selectedItem: selectedCountry,
                                        mode: Mode.DIALOG,
                                        dropDownButton: Text(""),
                                        showSearchBox: true,
                                        items:
                                            state.countriesResponse.countries,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: AppLocalizations.of(
                                                  context)!
                                              .translate('country_name_hint'),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              12, 8, 12, 12),
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14),
                                          border: InputBorder.none,
                                        ),
                                        itemAsString: (WooCountry? u) =>
                                            u!.name!,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCountry = value;
/*
                                            WooState otherState = WooState();
                                            otherState.name = "Other";
                                            otherState.value = "Other";
                                            selectedCountry.states.add(otherState);
*/
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                if (selectedCountry != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 8,
                                              top: 8),
                                          child: Text(AppLocalizations.of(
                                                  context)!
                                              .translate('state_name_title')!)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.0), // set border width
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0)), // set rounded corner radius
                                          ),
                                          child: SizedBox(
                                            height: 45,
                                            child: DropdownSearch<WooState>(
                                              selectedItem: selectedState,
                                              mode: Mode.DIALOG,
                                              showSearchBox: true,
                                              dropDownButton: Text(""),
                                              items: selectedCountry!.states,
                                              itemAsString: (WooState? u) =>
                                                  u!.name!,
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'state_name_hint'),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 8, 12, 12),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 14),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedState = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectedCountry != null)
                                  // Divider(
                                  //   color: Colors.grey[400],
                                  // ),
                                  Container(),
                              ],
                            );
                          } else if (state is CountriesLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text("Something went wrong"));
                          }
                        },
                      ),
/*
                      Padding(
                          padding: EdgeInsets.only(left: 15, right: 15,bottom: 8,top: 8),
                          child: Text("*Pick Location")),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: AppConfig.PLACE_PICKER_API_KEY,
                                onPlacePicked: (result) {
                                  print(result.geometry.location.lat
                                          .toString() +
                                      "---" +
                                      result.geometry.location.lng.toString());
                                  setState(() {
                                    latitude = result.geometry.location.lat;
                                    longitude = result.geometry.location.lng;

                                    _addressController.text =
                                        result.formattedAddress;
                                  });
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(0.0, 0.0),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            padding: EdgeInsets.only(left:12 ),
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0), // set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      10.0)), // set rounded corner radius
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (latitude == null)
                                    ? "Location"
                                    : latitude.toString() +
                                        ", " +
                                        longitude.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white :  Colors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
*/
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('address_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('address_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('city_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 6, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('city_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Your City';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('phone_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 6, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('phone_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Phone';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text(AppLocalizations.of(context)!
                              .translate('post_code_name_title')!)),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 6, left: 12),
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // set rounded corner radius
                          ),
                          child: TextFormField(
                            controller: _postCodeController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .translate('post_code_name_hint'),
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Zip Code';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ))),
                  onPressed: () {
                    if (_firstNameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _addressController.text.isEmpty ||
                        _cityController.text.isEmpty ||
                        _postCodeController.text.isEmpty ||
                        selectedCountry == null ||
                        selectedState == null ||
                        _phoneController == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid Inputs")));
                      return;
                    }

                    AddressData addressData = AddressData();
                    addressData.firstName = _firstNameController.text;
                    addressData.lastName = _lastNameController.text;
                    addressData.company = "";
                    addressData.address1 = _addressController.text;
                    addressData.address2 = "";
                    addressData.city = _cityController.text;
                    addressData.postcode = _postCodeController.text;
                    addressData.country = selectedCountry;
                    addressData.state = selectedState;
                    addressData.email = AppData.wooUser!.email;
                    addressData.phone = _phoneController.text;
/*
                    addressData.lattitude = latitude.toString();
                    addressData.longitude = longitude.toString();
*/
                    BlocProvider.of<AddAddressBloc>(context)
                        .add(AddAddress(addressData));

/*
                    if (latitude != null)
                      BlocProvider.of<AddAddressBloc>(context).add(
                        AddAddress(
                            _firstNameController.text,
                            _lastNameController.text,
                            "Male",
                            "company",
                            _addressController.text,
                            "suburb",
                            _postCodeController.text,
                            "1994-12-12",
                            _cityController.text,
                            selectedCountry.countryId,
                            selectedState.id,
                            latitude.toString(),
                            longitude.toString(),
                            _phoneController.text),
                      );
                    else
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select Location")));
*/
                  },
                  child: Text(AppLocalizations.of(context)!
                      .translate('save_and_continue')!)),
            ),
          ],
        ),
      ),
    );
  }
}
