
part of 'order_detail_bloc.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {
  const OrderDetailInitial();

  @override
  List<Object> get props => [];
}

class OrderDetailLoading extends OrderDetailState {
  const OrderDetailLoading();

  @override
  List<Object> get props => [];
}

class OrderDetailLoaded extends OrderDetailState {
  final WooOrderDetail ordersData;

  const OrderDetailLoaded(this.ordersData);

  @override
  List<Object> get props => [this.ordersData];
}

class OrderDetailError extends OrderDetailState {
  final String error;

  const OrderDetailError(this.error);

  @override
  List<Object> get props => [this.error];
}
