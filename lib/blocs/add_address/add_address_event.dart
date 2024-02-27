part of 'add_address_bloc.dart';

abstract class AddAddressEvent extends Equatable {
  const AddAddressEvent();
}

class AddAddress extends AddAddressEvent {
  final AddressData addressData;

  AddAddress(this.addressData);

  @override
  List<Object> get props => [this.addressData];
}
