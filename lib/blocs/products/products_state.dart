part of 'products_bloc.dart';

enum ProductsStatus { initial, success, failure }

class ProductsState extends Equatable {
  final List<WooProduct>? products;
  final ProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const ProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  ProductsState copyWith(
      {ProductsStatus? status,
        List<WooProduct>? products,
      bool? hasReachedMax,
      int? pageNo,}) {
    return ProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object?> get props =>
      [this.products, this.status, this.hasReachedMax, this.pageNo];
}
