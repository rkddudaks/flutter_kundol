import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_settings_response.dart';

abstract class ServerSettingsRepo {
  Future<WooSettingsResponse> fetchServerSettings();
}

class RealServerSettingsRepo implements ServerSettingsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooSettingsResponse> fetchServerSettings() {
    return _apiProvider.getWooSettings();
  }
}

class FakeServerSettingsRepo implements ServerSettingsRepo {
  @override
  Future<WooSettingsResponse> fetchServerSettings() {
    throw UnimplementedError();
  }
}
