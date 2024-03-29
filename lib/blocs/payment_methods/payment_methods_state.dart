
part of 'payment_methods_bloc.dart';

abstract class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

class PaymentMethodsInitial extends PaymentMethodsState {
  const PaymentMethodsInitial();

  @override
  List<Object> get props => [];
}

class PaymentMethodsLoading extends PaymentMethodsState {
  const PaymentMethodsLoading();

  @override
  List<Object> get props => [];
}

class PaymentMethodsLoaded extends PaymentMethodsState {
  final List<WooPaymentMethod> paymentMethods;

  const PaymentMethodsLoaded(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

class PaymentMethodsError extends PaymentMethodsState {
  final String error;

  const PaymentMethodsError(this.error);

  @override
  List<Object> get props => [error];
}
