import 'package:e_commerce/controller/auth_controller.dart';
import 'package:e_commerce/controller/category_controller.dart';
import 'package:e_commerce/controller/dashboard_controller.dart';
import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:get/get.dart';

class DashboardBinDing extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(CategoryController());
    Get.put(AuthController());
  }
}
