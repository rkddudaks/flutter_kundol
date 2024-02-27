import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/woo_countries_response.dart';
import 'package:flutter_kundol/repos/countriesRepo.dart';

part 'countries_event.dart';

part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepo countriesRepo;

  CountriesBloc(this.countriesRepo) : super(CountriesInitial());

  @override
  Stream<CountriesState> mapEventToState(
      CountriesEvent event,
      ) async* {
    if (event is GetCountries) {

        yield CountriesLoading();
        String countriesResponse = await rootBundle.loadString('assets/json/countries_states.json');
        WooCountriesResponse data = WooCountriesResponse.fromJson(jsonDecode(countriesResponse));
        if (data != null)
          yield CountriesLoaded(data);
        else
          yield CountriesError("Not found Countries");

    }
  }
}
