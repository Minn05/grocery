import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/service/remote_service/remote_category_service.dart';
import 'package:e_commerce/service/remote_service/remote_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<Product> productList = List<Product>.empty(growable: true).obs;
  RxBool isProductLoading = false.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<void> getProducts() async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().get();

      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      print('da co product');
      print(productList.length);
      isProductLoading(false);
    }
  }

  Future<void> getProductByName({required String keyword}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByName(keyword: keyword);
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      print('vao getByName');
      isProductLoading(false);
    }
  }

  Future<void> getProductByCategory({required int id}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByCategory(id: id);
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      print('vao getByCategory');
      isProductLoading(false);
    }
  }
}
