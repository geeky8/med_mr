import 'package:medrpha_trial/products/models/product_model.dart';

class ProductResponseModel {
  final String message;
  final List<ProductModel> productList;

  ProductResponseModel({
    required this.message,
    required this.productList,
  });

  factory ProductResponseModel.fromJson(
      {required String message, required List<ProductModel> productList}) {
    return ProductResponseModel(
      message: message,
      productList: productList,
    );
  }

  ProductResponseModel copyWith(
      {String? message, List<ProductModel>? productList}) {
    return ProductResponseModel(
      message: message ?? this.message,
      productList: productList ?? this.productList,
    );
  }
}
