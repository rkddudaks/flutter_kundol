import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order_detail.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

part 'order_detail_event.dart';

part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailsEvent, OrderDetailState> {
  final OrdersRepo ordersRepo;

  OrderDetailBloc(this.ordersRepo) : super(OrderDetailInitial());

  @override
  Stream<OrderDetailState> mapEventToState(OrderDetailsEvent event) async* {
    if (event is GetOrderDetails) {
      try {
        final ordersResponse = await ordersRepo.getOrderDetails(event.orderId);
        if (ordersResponse != null)
          yield OrderDetailLoaded(ordersResponse);
        else
          yield OrderDetailError("Empty");
      } on Error {
        yield OrderDetailError("Couldn't fetch Orders. Is the device online?");
      }
    }
  }
}
