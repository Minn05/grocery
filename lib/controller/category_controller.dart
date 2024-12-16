import 'package:e_commerce/model/category.dart';
import 'package:e_commerce/service/local_service/local_category_service.dart';
import 'package:e_commerce/service/remote_service/remote_category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  RxList<Category> categoryList = List<Category>.empty(growable: true).obs;
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  RxBool isCategoryLoading = false.obs;

  @override
  void onInit() async {
    await _localCategoryService.init();
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    try {
      isCategoryLoading(true);
      if (_localCategoryService.getCategories().isNotEmpty) {
        categoryList.assignAll(_localCategoryService.getCategories());
      }
      var result = await RemoteCategoryService().get();

      if (result != null) {
        categoryList.assignAll(categoryListFormJson(result.body));
        _localCategoryService.assignAllCategories(
            categories: categoryListFormJson(result.body));
      }
    } finally {
      isCategoryLoading(false);
      print('da vao category');
    }
  }
}
