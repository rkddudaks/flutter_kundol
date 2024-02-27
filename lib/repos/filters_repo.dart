import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/filters_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_filter.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_filter.dart';

abstract class FiltersRepo {
  Future<List<WooFilter>> getFilters();
}

class RealFiltersRepo implements FiltersRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<List<WooFilter>> getFilters() {
    return _apiProvider.getWooFilters();
  }
}
