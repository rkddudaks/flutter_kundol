part of 'shipping_methods_bloc.dart';

abstract class ShippingMethodsEvent extends Equatable {
  const ShippingMethodsEvent();
}

class GetShippingMethods extends ShippingMethodsEvent {
  final AddressData? addressData;

  const GetShippingMethods(this.addressData);

  @override
  List<Object?> get props => [this.addressData];
}
