import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/products/controller/product_repository.dart';
import 'package:medrpha_trial/products/enums/home_state.dart';
import 'package:medrpha_trial/products/models/category_model.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/utils/storage.dart';
import 'package:medrpha_trial/utils/wigets.dart';

import '../enums/category_type.dart';
import '../models/cart_model.dart';

class ProductController extends GetxController {
  final categoryList = <CategoryModel>[].obs;

  final currCategory = CategoriesType.ETHICAL.obs;

  var productList = <ProductModel>[].obs;

  var homeState = HomeState.SUCCESS.obs;

  var searchState = HomeState.SUCCESS.obs;

  final firmId = ''.obs;

  final ethicalProductList = <ProductModel>[].obs;

  final genericProductList = <ProductModel>[].obs;

  final surgicalProductList = <ProductModel>[].obs;

  final veterinaryProductList = <ProductModel>[].obs;

  final ayurvedicProductList = <ProductModel>[].obs;

  final generalProductList = <ProductModel>[].obs;

  var ethicalPageIndex = 1.obs;
  var genericPageIndex = 1.obs;
  var surgicalPageIndex = 1.obs;
  var vetPageIndex = 1.obs;
  var ayurvedicPageIndex = 1.obs;
  var generalPageIndex = 1.obs;
  var searchIndex = 1.obs;

  final cartModel = CartModel(
    totalSalePrice: '0.0',
    noOfProducts: 0,
    productList: [],
  ).obs;

  void setCurrCategory(String item) {
    currCategory.value = categoriesfromValue(item);
  }

  Future<void> init() async {
    homeState.value = HomeState.LOADING;
    ethicalPageIndex.value = 1;
    generalPageIndex.value = 1;
    surgicalPageIndex.value = 1;
    ayurvedicPageIndex.value = 1;
    vetPageIndex.value = 1;
    genericPageIndex.value = 1;
    await getCategories();
    await _getProducts();
    await getCartItems();
    homeState.value = HomeState.SUCCESS;
    productList
      ..clear()
      ..addAll(ethicalProductList);
  }

  Future<void> _getProducts() async {
    homeState.value = HomeState.LOADING;
    await getEthicalProducts();
    homeState.value = HomeState.SUCCESS;
    await getGenerallProducts();
    await getGenericProducts();
    await getSurgicalProducts();
    await getVeterinaryProducts();
    await getAyurvedicProducts();
  }

  Future<void> getCategories() async {
    final list = await ProductRepository().getCategories();
    if (list.isNotEmpty) {
      categoryList
        ..clear()
        ..addAll(list);
    } else {}
  }

  Future<void> getEthicalProducts({bool? load}) async {
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '1',
        pageIndex: ethicalPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            ethicalProductList.addAll(productRespModel.productList);
          } else {
            ethicalProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (ethicalPageIndex > 1) {
          ethicalPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  Future<ProductModel> getProductDetails({required ProductModel model}) async {
    // final sessId = DataStorage().readSessId();
    final fetchModel = await ProductRepository().getProductDetails(
      model: model,
      firmId: firmId.value,
      // sessId: "34c4efad30e6e2d4",
      // sessId: sessId,
    );
    return fetchModel;
  }

  Future<void> getGenericProducts({bool? load}) async {
    // if (load == null) prodState = StoreState.LOADING;
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '2',
        pageIndex: genericPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            genericProductList.addAll(productRespModel.productList);
          } else {
            genericProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (genericPageIndex > 1) {
          genericPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  Future<void> getSurgicalProducts({bool? load}) async {
    // if (load == null) prodState = StoreState.LOADING;
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '3',
        pageIndex: surgicalPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            surgicalProductList.addAll(productRespModel.productList);
          } else {
            surgicalProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (surgicalPageIndex > 1) {
          surgicalPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  Future<void> getVeterinaryProducts({bool? load}) async {
    // if (load == null) prodState = StoreState.LOADING;
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '4',
        pageIndex: vetPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            veterinaryProductList.addAll(productRespModel.productList);
          } else {
            veterinaryProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (vetPageIndex > 1) {
          vetPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  Future<void> getAyurvedicProducts({bool? load}) async {
    // if (load == null) prodState = StoreState.LOADING;
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '5',
        pageIndex: ayurvedicPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            ayurvedicProductList.addAll(productRespModel.productList);
          } else {
            ayurvedicProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (ayurvedicPageIndex > 1) {
          ayurvedicPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  Future<void> getGenerallProducts({bool? load}) async {
    // if (load == null) prodState = StoreState.LOADING;
    final productRespModel = await ProductRepository().getProducts(
        categoryId: '6',
        pageIndex: generalPageIndex.value,
        firmId: firmId.value.toString());
    // print(productRespModel!.message);
    if (productRespModel != null) {
      if (productRespModel.message ==
          'product not serviceable in your area !!!') {
      } else {
        if (productRespModel.productList.isNotEmpty) {
          if (load != null) {
            generalProductList.addAll(productRespModel.productList);
          } else {
            generalProductList
              ..clear()
              ..addAll(productRespModel.productList);
          }
        } else if (generalPageIndex > 1) {
          generalPageIndex--;
          Fluttertoast.showToast(msg: 'No more products to show');
        }
      }
    } else {}
  }

  //--------------------------------Cart-------------------------------

  Future<void> getCartItems({
    bool? isRemove,
    bool? cartOpt,
  }) async {
    final model = await ProductRepository().getCart(firmId: firmId.value);
    if (isRemove != null) {
      cartModel.value = cartModel.value.copyWith(
        totalSalePrice: model.totalSalePrice,
        noOfProducts: model.noOfProducts,
      );
    } else {
      // cartModel = model;
      cartModel.value.copyWith(productList: model.productList);
      final list = <ProductModel>[];
      if (cartOpt != null) {
        for (final i in model.productList) {
          final updatedModel = await _updateProductsAccordingToCart(model: i);
          list.add(updatedModel);
        }
        cartModel.value = model.copyWith(productList: list);
      }
    }

    debugPrint('----- cart total----${cartModel.value.totalSalePrice}');
  }

  Future<ProductModel> _updateProductsAccordingToCart(
      {required ProductModel model}) async {
    if (model.subTotal == '0.00') {
      final currModel = model.copyWith(
        subTotal: '0.00',
        totalQtyPrice: '0.00',
        productName: 'Remove the product',
        description: 'Prices have been changes or ',
      );

      return currModel;
    }

    final category = categoriesfromValue(model.category);
    print(model.cartQuantity);
    final index = searchList.indexWhere((element) => element.pid == model.pid);
    // final fModel = ethicalProductList.f
    if (index != -1) {
      final cartModel = searchList[index]
          .copyWith(cartQuantity: model.cartQuantity, subTotal: model.subTotal);
      searchList
        ..removeAt(index)
        ..insert(index, cartModel);
    }

    switch (category) {
      case CategoriesType.ETHICAL:
        final index = ethicalProductList
            .indexWhere((element) => element.pid == model.pid);
        // final fModel = ethicalProductList.f
        if (index != -1) {
          final cartModel = ethicalProductList[index].copyWith(
              cartQuantity: model.cartQuantity, subTotal: model.subTotal);
          ethicalProductList
            ..removeAt(index)
            ..insert(index, cartModel);
          return cartModel;
        }
        return model;
      // ethicalProductList[index] = cartModel;
      case CategoriesType.GENERIC:
        final index = genericProductList
            .indexWhere((element) => element.pid == model.pid);
        if (index != -1) {
          final cartModel = genericProductList[index].copyWith(
              cartQuantity: model.cartQuantity, subTotal: model.subTotal);
          genericProductList
            ..removeAt(index)
            ..insert(index, cartModel);
          return cartModel;
        }
        return model;
      case CategoriesType.SURGICAL:
        final index = surgicalProductList
            .indexWhere((element) => element.pid == model.pid);
        if (index != -1) {
          final cartModel = surgicalProductList[index].copyWith(
              cartQuantity: model.cartQuantity, subTotal: model.subTotal);
          surgicalProductList
            ..removeAt(index)
            ..insert(index, cartModel);

          return cartModel;
        }
        return model;
      case CategoriesType.VETERINARY:
        final index = veterinaryProductList
            .indexWhere((element) => element.pid == model.pid);
        if (index != -1) {
          final cartModel = veterinaryProductList[index].copyWith(
              cartQuantity: model.cartQuantity, subTotal: model.subTotal);
          veterinaryProductList
            ..removeAt(index)
            ..insert(index, cartModel);
          return cartModel;
        }
        return model;
      case CategoriesType.AYURVEDIC:
        final index = ayurvedicProductList
            .indexWhere((element) => element.pid == model.pid);
        final cartModel = ayurvedicProductList[index].copyWith(
            cartQuantity: model.cartQuantity, subTotal: model.subTotal);
        ayurvedicProductList
          ..removeAt(index)
          ..insert(index, cartModel);
        return cartModel;
      case CategoriesType.GENERAL:
        final index = generalProductList
            .indexWhere((element) => element.pid == model.pid);
        final cartModel = generalProductList[index].copyWith(
            cartQuantity: model.cartQuantity, subTotal: model.subTotal);
        generalProductList
          ..removeAt(index)
          ..insert(index, cartModel);
        return cartModel;
    }
  }

  Future<void> updateCartQunatity({
    required ProductModel model,
    required String value,
    required BuildContext context,
  }) async {
    SnackBar snackBar;
    print('$value ------- ${model.quantity}');
    if (int.parse(value) > int.parse(model.quantity)) {
      snackBar = ConstantWidgets()
          .customSnackBar(text: 'Quantity not available', context: context);
    } else if (int.parse(value) <= 0) {
      snackBar = ConstantWidgets()
          .customSnackBar(text: 'Quantity not available', context: context);
    } else {
      cartTotal(
        totalPrice: double.parse(cartModel.value.totalSalePrice),
        oldTotal: (double.parse(model.newMrp) * model.cartQuantity!),
        newTotal: (double.parse(model.newMrp) * int.parse(value)),
      );

      final currModel = model.copyWith(
        cartQuantity: int.parse(value),
        subTotal: (double.parse(model.newMrp) * int.parse(value)).toString(),
      );

      final index = cartModel.value.productList
          .indexWhere((element) => element.pid == currModel.pid);
      if (index != -1) {
        cartModel.value.productList
          ..removeAt(index)
          ..insert(index, currModel);
      }

      await _updateProductsAccordingToCart(model: currModel);

      ProductRepository()
          .updateQuantity(model: currModel, firmId: firmId.value);

      snackBar = ConstantWidgets()
          .customSnackBar(text: 'Qunatity updated', context: context);
      // plusMinusToCart(model: currModel);
      Navigator.pop(context);
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void cartTotal({
    required double totalPrice,
    required double oldTotal,
    required double newTotal,
  }) {
    final total = (totalPrice - oldTotal) + newTotal;
    cartModel.value =
        cartModel.value.copyWith(totalSalePrice: total.toStringAsFixed(2));
  }

  Future<void> plusToCart({
    required ProductModel model,
    required BuildContext context,
  }) async {
    // plusMinusRemoveState = StoreState.LOADING;
    Stopwatch stopwatch = Stopwatch()..start();
    int qty = model.cartQuantity! + 1;
    if (int.parse(model.quantity) > 0) {
      if (qty > int.parse(model.quantity)) {
        final snackBar = ConstantWidgets()
            .customSnackBar(text: 'Quantity not available', context: context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        cartTotal(
          totalPrice: double.parse(cartModel.value.totalSalePrice),
          oldTotal: (double.parse(model.newMrp) * (qty - 1)),
          newTotal: (double.parse(model.newMrp) * qty),
        );

        final currModel = model.copyWith(
          cartQuantity: qty,
          subTotal: (double.parse(model.newMrp) * qty).toString(),
        );

        debugPrint('-----added qty ${currModel.cartQuantity}');

        final index = cartModel.value.productList
            .indexWhere((element) => element.pid == currModel.pid);
        if (index != -1) {
          cartModel.value.productList
            ..removeAt(index)
            ..insert(index, currModel);
        }

        await _updateProductsAccordingToCart(model: currModel);

        final value = ProductRepository()
            .plusTheCart(model: currModel, firmId: firmId.value);
        SnackBar snackBar;
        if (value == null) {
          snackBar = ConstantWidgets().customSnackBar(
            text: 'Failed to update the cart',
            context: context,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        stopwatch.stop();
        if (kDebugMode) {
          print('plus cart seconds ${stopwatch.elapsedMilliseconds}');
        }
        // plusMinusToCart(model: currModel);
      }
    }

    // plusMinusRemoveState = StoreState.SUCCESS;
  }

  Future<void> minusToCart({
    required ProductModel model,
    required BuildContext context,
  }) async {
    final stopWatch = Stopwatch()..start();
    SnackBar snackBar;
    if (model.cartQuantity! > 1) {
      int qty = model.cartQuantity! - 1;
      cartTotal(
        totalPrice: double.parse(cartModel.value.totalSalePrice),
        oldTotal: (double.parse(model.newMrp) * (qty + 1)),
        newTotal: (double.parse(model.newMrp) * qty),
      );

      final currModel = model.copyWith(
        cartQuantity: qty,
        subTotal: (double.parse(model.newMrp) * qty).toString(),
      );
      final index = cartModel.value.productList
          .indexWhere((element) => element.pid == currModel.pid);
      cartModel.value.productList
        ..removeAt(index)
        ..insert(index, currModel);

      await _updateProductsAccordingToCart(model: currModel);

      final value = ProductRepository()
          .minusTheCart(model: currModel, firmId: firmId.value);
      if (value == null) {
        snackBar = ConstantWidgets().customSnackBar(
          text: 'Failed to update the cart',
          context: context,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      stopWatch.stop();
      print('subtract seconds ------ ${stopWatch.elapsedMilliseconds}');
    } else if (model.cartQuantity == 1) {
      await removeFromCart(
        model: model,
        context: context,
      );
      snackBar = ConstantWidgets().customSnackBar(
        text: 'Removed from cart',
        context: context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      snackBar = ConstantWidgets()
          .customSnackBar(text: 'Quantity not available', context: context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> addToCart({
    required ProductModel model,
    required BuildContext context,
  }) async {
    if (int.parse(model.quantity) > 0) {
      final stopWatch = Stopwatch()..start();

      int qty = 1;

      cartTotal(
        totalPrice: double.parse(cartModel.value.totalSalePrice),
        oldTotal: 0.0,
        newTotal: double.parse(model.newMrp) * qty,
      );
      final currModel = model.copyWith(
        cartQuantity: qty,
        subTotal: (double.parse(model.newMrp) * qty).toString(),
      );

      cartModel.value.productList.add(currModel);
      await _updateProductsAccordingToCart(model: currModel);

      ProductRepository().addToCart(model: currModel, firmId: firmId.value);
      // await getCartItems();
      print(cartModel.value.totalSalePrice);
      stopWatch.stop();
      print('adding to cart --- ${stopWatch.elapsedMilliseconds}');
    } else {
      final snackBar = ConstantWidgets().customSnackBar(
        text: 'Product quantity not available',
        context: context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> removeFromCart({
    required ProductModel model,
    required BuildContext context,
  }) async {
    cartTotal(
      totalPrice: double.parse(cartModel.value.totalSalePrice),
      oldTotal: (double.parse(model.newMrp) * model.cartQuantity!),
      newTotal: 0.00,
    );

    final currModel = model.copyWith(
      cartQuantity: 0,
      subTotal: 0.00.toString(),
    );
    final index = cartModel.value.productList
        .indexWhere((element) => element.pid == currModel.pid);
    if (index != -1) cartModel.value.productList.removeAt(index);

    await _updateProductsAccordingToCart(model: currModel);

    // await getCartItems(isRemove: true);
    if (index != -1) {
      final value = ProductRepository()
          .removeFromCart(model: model, firmId: firmId.value);
      SnackBar snackBar;
      if (value != null) {
        snackBar = ConstantWidgets().customSnackBar(
          text: 'Removed from cart',
          context: context,
        );
      } else {
        snackBar = ConstantWidgets().customSnackBar(
          text: 'Failed to remove from cart',
          context: context,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  // StoreState searchState = StoreState.EMPTY;

  List<ProductModel> searchList = <ProductModel>[].obs;

  Future<void> getSearchedResults({required String term, bool? load}) async {
    searchState.value = HomeState.LOADING;
    // print(term);
    if (term.isNotEmpty) {
      if (kDebugMode) {
        print(term);
      }
      // if (load == null) searchState = StoreState.LOADING;
      Future.delayed(Duration.zero, () async {
        final productRespModel = await ProductRepository().getProducts(
            term: term,
            pageIndex: searchIndex.value,
            firmId: firmId.value.toString());
        if (productRespModel != null) {
          if (productRespModel.message == 'successful !!') {
            if (productRespModel.productList.isNotEmpty) {
              if (load != null) {
                searchList
                  ..clear()
                  ..addAll(productRespModel.productList);
              } else {
                searchList.addAll(productRespModel.productList);
              }
            } else if (searchIndex > 1) {
              searchIndex--;
              Fluttertoast.showToast(msg: 'No more products to show');
            }
            // searchState = StoreState.SUCCESS;
          } else if (productRespModel.message ==
              'product not serviceable in your area !!!') {
            // message = 'Products not servicable in your selected area!';
            // searchState = StoreState.ERROR;
          } else {
            // message = 'Admin Status Pending';
            // searchState = StoreState.ERROR;
          }
        } else {
          // searchState = StoreState.EMPTY;
        }
      });
    } else {
      searchList.clear();
      // searchState = StoreState.EMPTY;
    }
    searchState.value = HomeState.SUCCESS;
  }
}
