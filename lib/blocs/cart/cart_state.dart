part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();

  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<WooCartData> cartItems;

  const CartLoaded(this.cartItems);

  @override
  List<Object> get props => [this.cartItems];
}

class CartError extends CartState {
  final String? error;

  const CartError(this.error);

  @override
  List<Object?> get props => [this.error];
}

class CartCouponError extends CartState {
  final String error;

  const CartCouponError(this.error);

  @override
  List<Object> get props => [this.error];
}

class CartDeleted extends CartState {
  final List<WooCartData> cartItems;

  const CartDeleted(this.cartItems);

  @override
  List<Object> get props => [this.cartItems];
}

class CouponApplied extends CartState {
  final List<WooCoupon> couponData;
  final List<WooCartData> cartItems;

  const CouponApplied(this.couponData, this.cartItems);

  @override
  List<Object> get props => [this.couponData, this.cartItems];
}

