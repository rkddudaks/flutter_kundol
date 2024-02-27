import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/api/wooResponses/WooPaymentMethod.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/payment_methods_repo.dart';

part 'payment_methods_event.dart';

part 'payment_methods_state.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final PaymentMethodsRepo paymentMethodsRepo;

  PaymentMethodsBloc(this.paymentMethodsRepo) : super(PaymentMethodsInitial());

  @override
  Stream<PaymentMethodsState> mapEventToState(
    PaymentMethodsEvent event,
  ) async* {
    if (event is GetPaymentMethods) {
      try {
        final paymentMethodsResponse =
            await paymentMethodsRepo.fetchPaymentMethods();
        if (paymentMethodsResponse != null && paymentMethodsResponse.isNotEmpty)
          yield PaymentMethodsLoaded(paymentMethodsResponse);
        else
          yield PaymentMethodsError("Empty");
      } on Error {
        yield PaymentMethodsError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
