import 'package:flutter_kundol/api/api_provider.dart';
// import 'package:flutter_kundol/api/responses/banners_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';

abstract class BannersRepo {
  Future<WooBannerResponse> fetchBanners();
}

class RealBannersRepo implements BannersRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooBannerResponse> fetchBanners() {
    return _apiProvider.getWooBanners();
  }
}

class FakeBannersRepo implements BannersRepo {
  @override
  Future<WooBannerResponse> fetchBanners() {
    throw UnimplementedError();
  }
}
