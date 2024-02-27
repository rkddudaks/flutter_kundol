part of 'add_address_bloc.dart';

abstract class AddAddressState extends Equatable {
  const AddAddressState();
}

class AddAddressInitial extends AddAddressState {
  const AddAddressInitial();

  @override
  List<Object> get props => [];
}

class AddAddressLoading extends AddAddressState {
  const AddAddressLoading();

  @override
  List<Object> get props => [];
}

class AddAddressLoaded extends AddAddressState {
  final AddressData? addressData;

  const AddAddressLoaded(this.addressData);

  @override
  List<Object?> get props => [this.addressData];
}

class AddAddressError extends AddAddressState {
  final String error;

  const AddAddressError(this.error);

  @override
  List<Object> get props => [this.error];
}
