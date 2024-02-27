import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/filters_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_filter.dart';
// import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/filters_repo.dart';

part 'filters_event.dart';

part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final FiltersRepo filtersRepo;

  FiltersBloc(this.filtersRepo) : super(FiltersInitial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is GetFilters) {
      try {
        final filtersResponse = await filtersRepo.getFilters();
        if (filtersResponse.isNotEmpty)
          yield FiltersLoaded(filtersResponse);
        else
          yield FiltersError("Empty");
      } on Error {
        yield FiltersError("Couldn't fetch Filters. Is the device online?");
      }
    }
  }
}
