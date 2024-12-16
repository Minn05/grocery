import 'package:e_commerce/controller/controllers.dart';
import 'package:e_commerce/view/account/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 50),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 37,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 35,
                      backgroundImage:
                          const AssetImage("assets/user_image.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      authController.user.value?.fullName ??
                          "Sign in your account",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildAccountCard(
              title: "Profile Info",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              }),
          buildAccountCard(title: "Notification", onTap: () {}),
          buildAccountCard(title: "Settings", onTap: () {}),
          buildAccountCard(title: "About Us", onTap: () {}),
          buildAccountCard(title: "Terms of Service ", onTap: () {}),
          Obx(() => buildAccountCard(
              title: authController.user.value == null ? "Sign In" : "Sign Out",
              onTap: () {
                if (authController.user.value != null) {
                  authController.signOut();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                }
              })),
        ],
      ),
    );
  }

  Widget buildAccountCard({required String title, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0.1,
                    blurRadius: 7)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
