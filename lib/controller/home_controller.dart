import 'package:e_commerce/model/ad_banner.dart';
import 'package:e_commerce/model/category.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/service/local_service/local_ad_banner_service.dart';
import 'package:e_commerce/service/local_service/local_category_service.dart';
import 'package:e_commerce/service/local_service/local_product_service.dart';
import 'package:e_commerce/service/remote_service/remote_banner_service.dart';
import 'package:e_commerce/service/remote_service/remote_popular_category_service.dart';
import 'package:e_commerce/service/remote_service/remote_popular_product_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Category> popularCategoryList =
      List<Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();
    getAdBanner();
    getPopularCategories();
    getPopularProducts();
    super.onInit();
  }

  Future<void> getAdBanner() async {
    try {
      isBannerLoading(true);

      //assigning local ad banners before call api
      if (_localAdBannerService.getAdBanners().isNotEmpty) {
        bannerList.assignAll(_localAdBannerService.getAdBanners());
      }

      //call api
      var result = await RemoteBannerService().get();

      if (result != null) {
        //assign api result
        bannerList.assignAll(adBannerListFromJson(result.body));

        //save api result to local database
        _localAdBannerService.assignAllAdBanners(
            adBanners: adBannerListFromJson(result.body));
      }
    } finally {
      isBannerLoading(false);
    }
  }

  Future<void> getPopularCategories() async {
    try {
      isPopularCategoryLoading(true);

      //assigning local ad banners before call api
      if (_localCategoryService.getPopularCategories().isNotEmpty) {
        popularCategoryList
            .assignAll(_localCategoryService.getPopularCategories());
      }

      //call api
      var result = await RemotePopularCategoryService().get();

      if (result != null) {
        //assign api result
        popularCategoryList.assignAll(popularCategoryListFormJson(result.body));

        //save api result to local database
        _localCategoryService.assignAllPopularCategories(
            popularCategories: popularCategoryListFormJson(result.body));
      }
    } finally {
      isPopularCategoryLoading(false);
    }
  }

  Future<void> getPopularProducts() async {
    try {
      isPopularProductLoading(true);

      //assigning local ad banners before call api
      if (_localProductService.getPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }

      //call api
      var result = await RemotePopularProductService().get();

      if (result != null) {
        //assign api result
        popularProductList.assignAll(popularProductListFromJson(result.body));

        //save api result to local database
        _localProductService.assignAllPopularProducts(
            popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      isPopularProductLoading(false);
    }
  }
}
