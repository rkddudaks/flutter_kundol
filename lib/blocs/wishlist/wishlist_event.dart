part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class GetWishlistOnStart extends WishlistEvent {
  const GetWishlistOnStart();

  @override
  List<Object> get props => [];
}

class LikeProduct extends WishlistEvent {
  final WooProduct? product;

  const LikeProduct(this.product);

  @override
  List<Object> get props => [this.product!];
}

class UnLikeProduct extends WishlistEvent {
  final WooProduct? product;

  const UnLikeProduct(this.product);

  @override
  List<Object?> get props => [this.product];
}
