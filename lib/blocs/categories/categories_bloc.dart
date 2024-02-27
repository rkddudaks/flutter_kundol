import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/categories_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_categories_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/categories_repo.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesBloc(this.categoriesRepo) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCategories) {
      try {
        final categoriesResponse = await categoriesRepo.fetchCategories();
        if (categoriesResponse.status == AppConstants.STATUS_SUCCESS &&
            categoriesResponse.data != null)
          yield CategoriesLoaded(categoriesResponse);
        else
          yield CategoriesError(categoriesResponse.error);
      } on Error {
        yield CategoriesError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
