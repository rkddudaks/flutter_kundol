part of 'detail_screen_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();
}

class GetQuantity extends DetailPageEvent {
  final int productId;
  final String productType;
  final int combinationId;

  const GetQuantity(this.productId, this.productType, this.combinationId);

  @override
  List<Object> get props =>
      [this.productId, this.productType, this.combinationId];
}

class AddToCart extends DetailPageEvent {
  final WooCartData cartItem;

  const AddToCart(this.cartItem);

  @override
  List<Object> get props => [this.cartItem];
}

class AddToCartGrouped extends DetailPageEvent {
  final List<WooCartData> cartItem;

  const AddToCartGrouped(this.cartItem);

  @override
  List<Object> get props => [this.cartItem];
}

class GetProductById extends DetailPageEvent {
  final int productId;

  const GetProductById(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetProductReviews extends DetailPageEvent {
  final int? productId;

  GetProductReviews(this.productId);

  @override
  List<Object?> get props => [productId];
}

class GetGroupedProducts extends DetailPageEvent {
  final List<int>? productIds;

  GetGroupedProducts(this.productIds);

  @override
  List<Object?> get props => [productIds];
}

class GetProductVariations extends DetailPageEvent {
  final int? productId;

  GetProductVariations(this.productId);

  @override
  List<Object?> get props => [productId];
}
