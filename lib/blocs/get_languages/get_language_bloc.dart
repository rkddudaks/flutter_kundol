import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/languages_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/get_language_repo.dart';

part 'get_language_event.dart';

part 'get_language_state.dart';

class GetLanguageBloc extends Bloc<GetLanguageEvent, GetLanguageState> {
  final GetLanguageRepo getLanguageRepo;

  GetLanguageBloc(this.getLanguageRepo) : super(GetLanguageInitial());

  @override
  Stream<GetLanguageState> mapEventToState(GetLanguageEvent event) async* {
    if (event is GetLanguages) {
      try {
/*
        final languagesResponse = await getLanguageRepo.fetchLanguages();
        if (languagesResponse.status == AppConstants.STATUS_SUCCESS &&
            languagesResponse.data != null)
          yield GetLanguageLoaded(languagesResponse);
        else
          yield GetLanguageError(languagesResponse.message);
*/
      LanguagesResponse response = LanguagesResponse();
      response.data = AppData.languagesData;
      response.status = AppConstants.STATUS_SUCCESS;
      yield GetLanguageLoaded(response);
      } on Error {
        yield GetLanguageError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
