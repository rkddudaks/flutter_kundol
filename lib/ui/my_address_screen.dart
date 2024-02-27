// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/repos/countriesRepo.dart';
// import 'package:flutter_kundol/ui/add_address_screen.dart';
import 'package:flutter_kundol/ui/add_addressbook_screen.dart';
// import 'package:flutter_kundol/ui/payment_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class MyAddressScreen extends StatefulWidget {
  MyAddressScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<MyAddressScreen> {
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
          title: Text("Address book",
              style: Theme.of(context).textTheme.titleLarge),
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) =>
                                  AddAddressBookBloc(RealAddressRepo())),
                          BlocProvider(
                              create: (context) =>
                                  CountriesBloc(RealCountriesRepo())),
                        ],
                        child: AddAddressBookScreen(null),
                      );
                    },
                  ));
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(AppStyles
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
              Expanded(
                child: BlocConsumer<AddressBloc, AddressState>(
                  bloc: BlocProvider.of<AddressBloc>(context),
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is AddressLoaded) {
                      if (state.addressData.isNotEmpty)
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
/*
                                    if (state.addressData[index].defaultAddress != 1)
                                      BlocProvider.of<AddressBloc>(context).add(
                                          SetDefaultAddress(
                                              state.addressData[index].id,
                                              state.addressData[index].customer
                                                  .customerFirstName,
                                              state.addressData[index].customer
                                                  .customerLastName,
                                              state.addressData[index].gender,
                                              state.addressData[index].company,
                                              state.addressData[index].streetAddress,
                                              state.addressData[index].suburb,
                                              state.addressData[index].postcode,
                                              state.addressData[index].dob,
                                              state.addressData[index].city,
                                              state.addressData[index].countryId
                                                  .countryId,
                                              state
                                                  .addressData[index].stateId.countryId,
                                              state.addressData[index].lattitude,
                                              state.addressData[index].longitude,
                                              state.addressData[index].phone));
*/
                                  },
                                  enabled: true,
                                  isThreeLine: true,
                                  leading: Icon(Icons.location_pin),
                                  trailing:
                                      /*(state.addressData[index].defaultAddress == 1)
                                          ?*/
                                      Icon(Icons.check) /*: null*/,
                                  title: Text(
                                      state.addressData[index].firstName! +
                                          " " +
                                          state.addressData[index].lastName!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(state.addressData[index].city!),
                                      Text(state.addressData[index].address1!),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
/*
                                                BlocProvider.of<AddressBloc>(context)
                                                    .add(DeleteAddress(
                                                        state.addressData[index].id));
*/
                                              },
                                              icon: Icon(Icons.delete)),
                                          SizedBox(width: 12.0),
                                          IconButton(
                                              onPressed: () {
/*
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider(
                                                            create: (context) =>
                                                                AddAddressBookBloc(
                                                                    RealAddressRepo())),
                                                        BlocProvider(
                                                            create: (context) =>
                                                                CountriesBloc(RealCountriesRepo())),
                                                      ],
                                                      child: AddAddressBookScreen(
                                                          state.addressData[index]),
                                                    );
                                                  },
                                                ));
*/
                                              },
                                              icon: Icon(Icons.edit)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      else
                        return Center(child: Text("Empty"));
                    } else if (state is AddressError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                  listener: (context, state) {
                    if (state is AddressError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
