part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  final List<int?> productIds;

  const GetCart(this.productIds);

  @override
  List<Object> get props => [productIds];
}

class DeleteCartItem extends CartEvent {
  final int? productId;
  final int? combinationId;

  const DeleteCartItem(this.productId, this.combinationId);

  @override
  List<Object?> get props => [this.productId, this.combinationId];
}

class ApplyCoupon extends CartEvent {
  final String coupon;

  ApplyCoupon(this.coupon);

  @override
  List<Object> get props => [this.coupon];
}
