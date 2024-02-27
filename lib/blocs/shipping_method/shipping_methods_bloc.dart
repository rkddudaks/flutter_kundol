import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_shipping_method.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/repos/shipping_methods_repo.dart';

part 'shipping_methods_event.dart';

part 'shipping_methods_state.dart';

class ShippingMethodsBloc extends Bloc<ShippingMethodsEvent, ShippingMethodsState> {
  final ShippingMethodsRepo shippingMethodsRepo;

  ShippingMethodsBloc(this.shippingMethodsRepo) : super(ShippingMethodsInitial());

  @override
  Stream<ShippingMethodsState> mapEventToState(
      ShippingMethodsEvent event,
      ) async* {
    if (event is GetShippingMethods) {
      try {
        final shippingMethodsResponse = await shippingMethodsRepo.fetchShippingMethods(event.addressData);
        if (shippingMethodsResponse != null)
          yield ShippingMethodsLoaded(shippingMethodsResponse);
        else
          yield ShippingMethodsError("some error occurred");
      } on Error {
        yield ShippingMethodsError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

