import 'package:e_commerce/controller/controllers.dart';
import 'package:e_commerce/view/category/components/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.categoryList.isNotEmpty) {
        return ListView.builder(
          itemBuilder: (context, index) =>
              CategoryCard(category: categoryController.categoryList[index]),
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
        );
      }else{
        return Container();
      }
    });
  }
}
