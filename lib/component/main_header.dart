import 'package:e_commerce/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(0, 0),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Obx(() => TextField(
                    autofocus: false,
                    controller: productController.searchTextEditController,
                    onSubmitted: (val) {
                      productController.getProductByName(keyword: val);
                      dashboardController.updateIndex(1);
                    },
                    onChanged: (val) {
                      productController.searchVal.value = val;
                    },
                    decoration: InputDecoration(
                      suffixIcon: productController.searchVal.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                productController.searchTextEditController
                                    .clear();
                                productController.searchVal.value = '';
                                productController.getProducts();
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 16),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search...",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          badges.Badge(
            badgeContent: const Text(
              "1",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            badgeStyle:
                badges.BadgeStyle(badgeColor: Theme.of(context).primaryColor),
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                    )
                  ]),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
