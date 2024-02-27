
part of 'order_detail_bloc.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();
}

class GetOrderDetails extends OrderDetailsEvent {
  final int orderId;

  const GetOrderDetails(this.orderId);

  @override
  List<Object> get props => [this.orderId];
}
