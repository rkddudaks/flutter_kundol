import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/categories_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_categories_response.dart';

abstract class CategoriesRepo {
  Future<WooCategoriesResponse> fetchCategories();
}

class RealCategoriesRepo implements CategoriesRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooCategoriesResponse> fetchCategories() {
    return _apiProvider.getWooCategories();
  }
}

class FakeCategoriesRepo implements CategoriesRepo {
  @override
  Future<WooCategoriesResponse> fetchCategories() {
    throw UnimplementedError();
  }
}
