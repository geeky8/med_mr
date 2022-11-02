import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:medrpha_trial/products/utils/urls.dart';
import 'package:medrpha_trial/utils/storage.dart';

import '../../enums/payment_options.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/productresponse_model.dart';

class ProductRepository {
  final _httpClient = http.Client();

  Future<List<CategoryModel>> getCategories() async {
    final catlist = <CategoryModel>[];
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "sessid": sessId,
    };
    final resp =
        await _httpClient.post(Uri.parse(Urls.categoryUrl), body: body);

    if (kDebugMode) {
      print('category resp -----------${resp.body}');
    }

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        for (final i in list) {
          final model = CategoryModel.fromJson(json: i);
          catlist.add(model);
        }
      }
    }
    return catlist;
  }

  Future<ProductResponseModel?> getProducts({
    String? categoryId,
    bool? refresh,
    String? term,
    int? pageIndex,
    required String firmId,
  }) async {
    final productlist = <ProductModel>[];
    final sessId = DataStorage().readSessId();
    final body = {
      "firm_id": firmId,
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "sessid": sessId,
      "term": term ?? '',
      "catcheck": categoryId ?? '',
      "PageIndex": (pageIndex ?? '1').toString(),
      "PageSize": '6'
    };

    final resp =
        await _httpClient.post(Uri.parse(Urls.productsUrl), body: body);

    debugPrint('--- prod resp ---------${resp.body}');

    if (term != null) {}
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      ProductResponseModel productRespModel = ProductResponseModel.fromJson(
        message: respBody['message'] as String,
        productList: [],
      );
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        for (final i in list) {
          final model = ProductModel.fromJson(json: i);
          productlist.add(model);
        }
        debugPrint('------products lenght ${productlist.length}');
        productRespModel = productRespModel.copyWith(productList: productlist);
      }
      return productRespModel;
    }
    return null;
  }

  Future<ProductModel> getProductDetails({
    required ProductModel model,
    required String firmId,
    // required String sessId,
  }) async {
    final sessId = DataStorage().readSessId();

    final body = {
      "sessid": sessId,
      // "firm_id":firmId,
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "pid": model.pid,
      "price_id": model.priceId
    };

    ProductModel currModel = model;

    final resp =
        await _httpClient.post(Uri.parse(Urls.productDetailsUrl), body: body);

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final data = respBody['data'] as Map<String, dynamic>;
        // print(_data);
        currModel = model.copyWith(
          expiryDate: data['dtExpiryDate'] as String,
          description: data['Description'] as String,
          productName: data['product_name'] as String,
          productImg: data['product_img'] as String,
          prodSaleTypeDetails: data['prodsaletypedetails'] as String,
          company: data['compnaystr'] as String,
          category: data['categorystr'] as String,
        );
      }
    }
    return currModel;
  }

  Future<int?> plusTheCart(
      {required ProductModel model, required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId,
      "pid": model.pid,
      "priceID": model.priceId,
      "quantity": model.quantity
    };

    final resp = await _httpClient.post(Uri.parse(Urls.plusCart), body: body);

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      // print(respBody);
      if (respBody['status'] == '1') {
        return 1;
      }
    }
    return null;
  }

  Future<int?> minusTheCart(
      {required ProductModel model, required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId,
      "pid": model.pid,
      "priceID": model.priceId,
    };

    final resp = await _httpClient.post(Uri.parse(Urls.minusCart), body: body);

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);

      if (respBody['status'] == '1') {
        return 1;
      }
    }
    return null;
  }

  Future<int?> updateQuantity(
      {required ProductModel model, required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId,
      "pid": model.pid,
      "priceID": model.priceId,
      "quantity": model.quantity,
      "qtyfield": model.cartQuantity.toString(),
    };

    final resp = await _httpClient
        .post(Uri.parse(Urls.updateProductQuantityUrl), body: body);

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        return 1;
      }
    }
    return null;
  }

  Future<int?> addToCart(
      {required ProductModel model, required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId,
      "pid": model.pid,
      "priceID": model.priceId,
      "WPID": model.wpid,
      "saleprice": model.salePrice,
    };

    final resp =
        await _httpClient.post(Uri.parse(Urls.addToCartUrl), body: body);

    // print('------ add to cart${resp.body}');

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      // print(respBody);
      if (respBody['status'] == '1') {
        return 1;
      }
    }
    return null;
  }

  Future<int?> removeFromCart(
      {required ProductModel model, required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId,
      "pid": model.pid,
      "priceID": model.priceId
    };

    final resp =
        await _httpClient.post(Uri.parse(Urls.removeCartUrl), body: body);

    debugPrint('------ removal from cart -------${resp.body}');

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);

      if (respBody['status'] == '1') {
        return 1;
      }
    }

    return null;
  }

  Future<CartModel> getCart({required String firmId}) async {
    final sessId = DataStorage().readSessId();

    final body = {
      //"sessid": "c9fc796d50917bf1",
      // "sessid": "34c4efad30e6e2d4",
      "firm_id": firmId,
      "sessid": sessId
    };

    final List<ProductModel> prodList = [];
    int count = 0;
    String total = '';

    final resp = await _httpClient.post(Uri.parse(Urls.getCartUrl), body: body);

    if (kDebugMode) {
      print('------ get cart${resp.body}');
    }

    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      debugPrint('------getCart--------${resp.body}');
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        count = int.parse(respBody['count'] as String);
        total = (respBody['final'] as String);
        for (final i in list) {
          final model = ProductModel.fromJson(
            json: i,
          );
          prodList.add(model);
        }
      }
    }
    return CartModel(
        totalSalePrice: total, noOfProducts: count, productList: prodList);
  }

  //------------------------Checkout----------------------------------
  Future<String> checkoutConfirm({
    // required PaymentOptions paymentOptionsType,
    required String firmId,
    required String finalPrice,
  }) async {
    final sessId = DataStorage().readSessId();
    final body = {
      "firm_id": firmId,
      "sessid": sessId,
      "paylater": "0",
      "paymode": "1",
      // "paymode": paymentOptionsType.toPaymentOption(),
      // "final": "2000.00",
      "final": finalPrice,
    };

    String confirm = '';
    final resp =
        await _httpClient.post(Uri.parse(Urls.checkoutUrl), body: body);
    if (kDebugMode) {
      print('---------- Confirm checkout ---------- ${resp.body}');
    }
    print(resp);
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
      print(respBody);
      if (respBody['status'] == '1') {
        confirm = respBody['order_id'] as String;
      }
    }
    return confirm;
  }
  //TODO: Add checkout (CartScreen - Checkout ---> checkout_screen - confirm_checkout ----> payment_screen - if(online)-paymentConfirmation else skip ----> success/failure message ----> back to product screen).

}
