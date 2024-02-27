import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_currencies_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/currency_date.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc(WooCurrency currencyData) : super(CurrencyState(currencyData));

  @override
  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is CurrencyLoadStarted) {
      yield* _mapCurrencyLoadStartedToState();
    } else if (event is CurrencySelected) {
      yield* _mapCurrencySelectedToState(event.currency);
    } else if (event is CurrencyLoadServer) {
      yield* _mapCurrencyLoadServerToState(event.currency);
    }
  }

  Stream<CurrencyState> _mapCurrencyLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    WooCurrency currencyData = WooCurrency();
    String? selectedCurrencyTitle = sharedPrefService!.selectedCurrencyTitle;
    //int selectedCurrencyId = sharedPrefService.selectedCurrencyId;
    String? selectedCurrencySymbol = sharedPrefService.selectedCurrencySymbol;

    currencyData.name = selectedCurrencyTitle;
    //currencyData.currencyId = selectedCurrencyId;
    currencyData.symbol = selectedCurrencySymbol;

    if (selectedCurrencyTitle == null) {
      currencyData.name = "USD";
      //currencyData.currencyId = 1;
      currencyData.symbol = "USD";
    }

    yield CurrencyState(currencyData);
  }

  Stream<CurrencyState> _mapCurrencySelectedToState(
      WooCurrency currency) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    await sharedPrefService!.setSelectedCurrencyTitle(currency.name!);
    //await sharedPrefService.setSelectedCurrencyId(currency.currencyId);
    await sharedPrefService.setSelectedCurrencySymbol(currency.symbol!);
    yield CurrencyState(currency);
  }

  Stream<CurrencyState> _mapCurrencyLoadServerToState(
      WooCurrency currency) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    String? selectedCurrencyTitle = sharedPrefService!.selectedCurrencyTitle;
    //int selectedCurrencyId = sharedPrefService.selectedCurrencyId;
    String? selectedCurrencySymbol = sharedPrefService.selectedCurrencySymbol;

    WooCurrency currencyData = WooCurrency();

    currencyData.name = selectedCurrencyTitle;
    //currencyData.currencyId = selectedCurrencyId;
    currencyData.symbol = selectedCurrencySymbol;

    if (selectedCurrencyTitle == null) {
      await sharedPrefService
          .setSelectedCurrencyTitle(AppData.settingsResponse.currency!.name!);

      currencyData.name = AppData.settingsResponse.currency!.name;
      currencyData.symbol = AppData.settingsResponse.currency!.name;
/*
      await sharedPrefService.setSelectedCurrencyTitle(AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_SYMBOL).trim());
      await sharedPrefService.setSelectedCurrencyId(int.parse(AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_ID).toString()));
      await sharedPrefService.setSelectedCurrencySymbol(AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_SYMBOL).trim());

      currencyData.title = AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_CODE).trim();
      currencyData.currencyId = int.parse(AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_ID).toString());
      currencyData.code = AppData.settingsResponse.getKeyValue(SettingsResponse.CURRENCY_SYMBOL).trim();
*/
    }

    yield CurrencyState(currencyData);
  }
}
