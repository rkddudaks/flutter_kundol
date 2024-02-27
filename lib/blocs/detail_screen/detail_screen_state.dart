part of 'detail_screen_bloc.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
}

class DetailPageInitial extends DetailPageState {
  const DetailPageInitial();

  @override
  List<Object> get props => [];
}

class GetQuantityLoaded extends DetailPageState {
  final QuantityData? quantityData;

  const GetQuantityLoaded(this.quantityData);

  @override
  List<Object?> get props => [this.quantityData];
}

class DetailPageError extends DetailPageState {
  final String? error;

  const DetailPageError(this.error);

  @override
  List<Object?> get props => [this.error];
}

class ItemCartAdded extends DetailPageState {
  final List<WooCartData?> cartItems;

  const ItemCartAdded(this.cartItems);

  @override
  List<Object> get props => [this.cartItems];
}

class ProductDetailsLoaded extends DetailPageState {
  final Product? product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [this.product];
}

class ProductReviewsLoaded extends DetailPageState {

  final List<WooReview> reviews;

  ProductReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class GroupedProductsLoaded extends DetailPageState {

  final List<WooProduct>? products;

  GroupedProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductVariationsLoaded extends DetailPageState {

  final List<WooVariationsResponse> variations;

  ProductVariationsLoaded(this.variations);

  @override
  List<Object> get props => [variations];
}