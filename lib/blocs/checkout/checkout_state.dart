
part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();

  @override
  List<Object> get props => [];
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();

  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  final int? orderId;

  const CheckoutLoaded(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CheckoutError extends CheckoutState {
  final String error;

  const CheckoutError(this.error);

  @override
  List<Object> get props => [error];
}
