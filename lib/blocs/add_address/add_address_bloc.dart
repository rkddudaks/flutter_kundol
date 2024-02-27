import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:hive/hive.dart';

part 'add_address_event.dart';

part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRepo addressRepo;

  AddAddressBloc(this.addressRepo) : super(AddAddressInitial());

  @override
  Stream<AddAddressState> mapEventToState(AddAddressEvent event) async* {
    if (event is AddAddress) {
      if (AppData.wooUser == null) {
        yield AddAddressLoaded(null);
        return;
      }
      try {
        WooUserBilling address = new WooUserBilling();
        address.firstName = event.addressData.firstName;
        address.lastName = event.addressData.lastName;
        address.country = event.addressData.country!.value;
        address.state = event.addressData.state!.value;
        address.address1 = event.addressData.address1;
        address.city = event.addressData.city;
        address.phone = event.addressData.phone;
        address.postcode = event.addressData.postcode;
        var box =
            await Hive.openBox<WooUserBilling>(AppConstants.TBL_ADDRESSES);
        if (box.values.toList().isEmpty) {
          box.add(address);
        } else {
          box.values.toList().asMap().forEach((key, value) {
            if (value == address) {
              box.putAt(key, address);
            }
          });
        }
        yield AddAddressLoaded(event.addressData);
      } on Error {
        yield AddAddressError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
