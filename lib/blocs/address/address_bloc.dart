import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user_billing.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:hive/hive.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo addressRepo;

  AddressBloc(this.addressRepo) : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is GetAddress && AppData.wooUser != null) {
      try {
        yield AddressLoading();
        var box =
            await Hive.openBox<WooUserBilling>(AppConstants.TBL_ADDRESSES);
        if (box.values.isNotEmpty)
          yield AddressLoaded(box.values.toList());
        else
          yield AddressError("Not Found any address");
      } on Error {
        yield AddressError("Couldn't fetch Addresses. Is the device online?");
      }
    }
    /*else if (event is SetDefaultAddress) {
      try {
        yield AddressLoading();
        final addressDefaultResponse = await addressRepo.setDefaultAddress(
            event.addressID,
            event.firstName,
            event.lastName,
            event.gender,
            event.company,
            event.streetAddress,
            event.suburb,
            event.postCode,
            event.dob,
            event.city,
            event.countryId,
            event.state_id,
            event.lat,
            event.lng,
            event.phone);
        final addressResponse = await addressRepo.getAddress();
        if (addressResponse.status == AppConstants.STATUS_SUCCESS &&
            addressResponse.data != null)
          yield AddressLoaded(addressResponse.data);
        else
          yield AddressError(addressResponse.message);
      } on Error {
        yield AddressError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is DeleteAddress) {
      try {
        yield AddressLoading();
        final deleteAddressResponse =
            await addressRepo.deleteAddress(event.addressId);
        final addressResponse = await addressRepo.getAddress();
        if (addressResponse.status == AppConstants.STATUS_SUCCESS &&
            addressResponse.data != null)
          yield AddressLoaded(addressResponse.data);
        else
          yield AddressError(addressResponse.message);
      } on Error {
        yield AddressError("Couldn't fetch weather. Is the device online?");
      }
    }*/
  }
}
