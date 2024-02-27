import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/banners_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/banners_repo.dart';

part 'banners_event.dart';

part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  final BannersRepo bannersRepo;

  BannersBloc(this.bannersRepo) : super(BannersInitial());

  @override
  Stream<BannersState> mapEventToState(
    BannersEvent event,
  ) async* {
    if (event is GetBanners) {
      try {
        final bannersResponse = await bannersRepo.fetchBanners();
        if (bannersResponse.status == AppConstants.STATUS_SUCCESS &&
            bannersResponse.data != null)
          yield BannersLoaded(bannersResponse);
        else
          yield BannersError(bannersResponse.error);
      } on Error {
        yield BannersError("Couldn't fetch Banners. Is the device online?");
      }
    }
  }
}
