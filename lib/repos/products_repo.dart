import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/product_detail_response.dart';
// import 'package:flutter_kundol/api/responses/products_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_product_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_reviews_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_variations/woo_variations_response.dart';

abstract class ProductsRepo {
  Future<WooProductsResponse> fetchProducts(int? pageNo);
  Future<WooProductsResponse> fetchTopSellingProducts(int? pageNo);
  Future<WooProductsResponse> fetchSuperDealsProducts(int? pageNo);
  Future<WooProductsResponse> fetchFeaturedProducts(int? pageNo);
  Future<WooProductsResponse> fetchProductsByCat(
      int? pageNo,
      int? categoryId,
      String? sortBy,
      String? sortType,
      String filters,
      String? attributeSlug,
      String? variationId);
  Future<WooProductsResponse> fetchSearchProducts(String? keyword, int? pageNo);
  Future<ProductDetailResponse> fetchProductById(int productId);
  Future<List<WooReview>> fetchProductReviews(int? productId);
  Future<WooProductsResponse> fetchGroupedProduct(List<int>? productIds);
  Future<List<WooVariationsResponse>> fetchProductVariations(int? productId);
}

class RealProductsRepo implements ProductsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WooProductsResponse> fetchProducts(int? pageNo) {
    return _apiProvider.getWooProducts(pageNo);
  }

  @override
  Future<WooProductsResponse> fetchProductsByCat(
      int? pageNo,
      int? categoryId,
      String? sortBy,
      String? sortType,
      String filters,
      String? attributeSlug,
      String? variationId) {
    return _apiProvider.getWooProductsByCat(pageNo, categoryId, sortBy,
        sortType, filters, attributeSlug, variationId);
  }

  @override
  Future<WooProductsResponse> fetchSearchProducts(
      String? keyword, int? pageNo) {
    return _apiProvider.getWooSearchProducts(keyword, pageNo);
  }

  @override
  Future<ProductDetailResponse> fetchProductById(int productId) {
    return _apiProvider.getProductById(productId);
  }

  @override
  Future<WooProductsResponse> fetchFeaturedProducts(int? pageNo) {
    return _apiProvider.getWooFeaturedProducts(pageNo);
  }

  @override
  Future<WooProductsResponse> fetchSuperDealsProducts(int? pageNo) {
    return _apiProvider.getWooDealsProducts(pageNo);
  }

  @override
  Future<WooProductsResponse> fetchTopSellingProducts(int? pageNo) {
    return _apiProvider.getWooTopSellingProducts(pageNo);
  }

  @override
  Future<List<WooReview>> fetchProductReviews(int? productId) {
    return _apiProvider.getWooReviews(productId);
  }

  @override
  Future<WooProductsResponse> fetchGroupedProduct(List<int>? productIds) {
    return _apiProvider.getWooGroupedProducts(productIds!);
  }

  @override
  Future<List<WooVariationsResponse>> fetchProductVariations(int? productId) {
    return _apiProvider.getWooProductsVariations(productId);
  }
}

class FakeProductsRepo implements ProductsRepo {
  @override
  Future<WooProductsResponse> fetchProducts(int? pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchProductsByCat(
      int? pageNo,
      int? categoryId,
      String? sortBy,
      String? sortType,
      String filters,
      String? attributeSlug,
      String? variationId) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchSearchProducts(
      String? keyword, int? pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<ProductDetailResponse> fetchProductById(int productId) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchFeaturedProducts(int? pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchSuperDealsProducts(int? pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchTopSellingProducts(int? pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<List<WooReview>> fetchProductReviews(int? productId) {
    throw UnimplementedError();
  }

  @override
  Future<WooProductsResponse> fetchGroupedProduct(List<int>? productIds) {
    throw UnimplementedError();
  }

  @override
  Future<List<WooVariationsResponse>> fetchProductVariations(int? productId) {
    throw UnimplementedError();
  }
}
