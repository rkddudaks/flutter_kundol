import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/redeem_response.dart';
// import 'package:flutter_kundol/api/responses/reward_point_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_reward_response.dart';

abstract class RewardRepo {
  Future<WooRewardResponse> getRewardPoints();
  Future<RedeemResponse> redeemRewardPoints();
}

class RealRewardPoints implements RewardRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooRewardResponse> getRewardPoints() {
    return _apiProvider.getWooRewards();
  }

  @override
  Future<RedeemResponse> redeemRewardPoints() {
    return _apiProvider.redeemRewardPoints();
  }
}
