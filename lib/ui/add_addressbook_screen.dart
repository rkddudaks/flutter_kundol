import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter_kundol/models/country.dart';

class AddAddressBookScreen extends StatefulWidget {
  final AddressData? addressData;

  AddAddressBookScreen(this.addressData);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressBookScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  WooCountry? selectedCountry;
  WooState? selectedState;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountriesBloc>(context).add(GetCountries());
/*
    if (widget.addressData != null) {
      _firstNameController.text = widget.addressData.customer.customerFirstName;
      _lastNameController.text = widget.addressData.customer.customerLastName;
      _addressController.text = widget.addressData.streetAddress;
      _cityController.text = widget.addressData.city;
      _postCodeController.text = widget.addressData.postcode;
      _phoneController.text = widget.addressData.phone;
    }
*/
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
        title:
            Text("Add Address", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: BlocListener<AddAddressBookBloc, AddAddressBookState>(
        listener: (context, state) {
          if (state is AddAddressBookLoaded) {
/*
            AddressData addressData = AddressData();
            addressData.customer = AddressCustomer();
            addressData.customer.customerFirstName = _firstNameController.text;
            addressData.customer.customerLastName = _lastNameController.text;
            addressData.streetAddress = _addressController.text;
            addressData.city = _cityController.text;
            addressData.phone = _phoneController.text;
            addressData.postcode = _postCodeController.text;

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.addAddressResponse.message)));
            Navigator.pop(context);
*/
          } else if (state is AddAddressBookError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
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
                          child: Text("*First Name")),
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
                              hintText: "First Name",
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
                          child: Text("*Last Name")),
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
                              hintText: "Last Name",
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
                          child: Text("*Country")),
                      BlocBuilder<CountriesBloc, CountriesState>(
                        builder: (context, state) {
                          if (state is CountriesLoaded) {
/*
                            List<CountryData> countryDataList = state.countriesResponse.countries;
                            CountryData otherCountryData = CountryData();
                            otherCountryData.countryName = "Other";
                            otherCountryData.countryId = 0;
                            otherCountryData.states = [];
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
                                        mode: Mode.DIALOG,
                                        showSearchBox: true,
                                        dropDownButton: Text(""),
                                        items:
                                            state.countriesResponse.countries,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Country",
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
                                            States otherState = States();
                                            otherState.id = 0;
                                            otherState.name = "Other";
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
                                          child: Text("*State")),
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
                                              mode: Mode.DIALOG,
                                              showSearchBox: true,
                                              dropDownButton: Text(""),
                                              items: selectedCountry!.states,
                                              itemAsString: (WooState? u) =>
                                                  u!.name!,
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                hintText: "State",
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
                                if (selectedCountry != null) Container(),
                              ],
                            );
                          } else if (state is CountriesLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text("Something went wrong"));
                          }
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 8),
                          child: Text("*Address")),
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
                              hintText: "Address",
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
                          child: Text("*City")),
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
                              hintText: "City",
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
                          child: Text("*Phone")),
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
                              hintText: "Phone*",
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
                          child: Text("*Post Code")),
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
                              hintText: "Post Code",
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
/*
                    if (widget.addressData == null)
                      BlocProvider.of<AddAddressBookBloc>(context).add(
                        AddAddressBook(
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
                            "123",
                            "123",
                            _phoneController.text),
                      );
                    else
                      BlocProvider.of<AddAddressBookBloc>(context).add(
                        UpdateAddressBook(
                            widget.addressData.id,
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
                            "123",
                            "123",
                            _phoneController.text),
                      );
*/
                  },
                  child: Text("Save & Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
