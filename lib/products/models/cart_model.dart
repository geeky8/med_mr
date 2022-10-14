

import 'product_model.dart';

class CartModel {
  final String totalSalePrice;
  final int noOfProducts;
  final List<ProductModel> productList;
  
  
  CartModel({
    required this.totalSalePrice,
    required this.noOfProducts,
    required this.productList,
  });

  CartModel copyWith({
    String? totalSalePrice,
    int? noOfProducts,
    List<ProductModel>? productList,
  }) {
    return CartModel(
      totalSalePrice: totalSalePrice ?? this.totalSalePrice,
      noOfProducts: noOfProducts ?? this.noOfProducts,
      productList: productList ?? this.productList,
    );
  }

}
