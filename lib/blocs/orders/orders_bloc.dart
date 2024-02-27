import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_order.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_order_detail.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersBloc(this.ordersRepo) : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is GetOrders && AppData.wooUser != null) {
      try {
        final ordersResponse = await ordersRepo.getOrders(AppData.wooUser!.id);
        if (ordersResponse != null && ordersResponse.isNotEmpty)
          yield OrdersLoaded(ordersResponse);
        else
          yield OrdersError("Empty");
      } on Error {
        yield OrdersError("Couldn't fetch Orders. Is the device online?");
      }
    }
  }
}
