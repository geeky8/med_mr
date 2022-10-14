import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/bottom_navigation/controller/bottom_naviagtion_controller.dart';
import 'package:medrpha_trial/dashboard/screens/dashboard_screen.dart';
import 'package:medrpha_trial/dashboard/screens/dashboardscreen.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/screens/product_screen.dart';
import 'package:medrpha_trial/products/screens/product_screenA.dart';
import 'package:medrpha_trial/profile/controller/profile_controller.dart';
import 'package:medrpha_trial/profile/screens/profile_info_screen.dart';
import 'package:medrpha_trial/users/screens/user_list_screen.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  final pages = [
    // const DashBoardScreen(),
    const DashBoardScreenA(),
    // const OrderHistoryScreen(),
    const ProductScreenA(),
    const UserListScreen(),
    const ProfileInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.put(BottomNavigationController());
    // final profileController = Get.put(ProfileController());
    final pcontroller = Get.put(ProductController());
    pcontroller.init();
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: getScreenPercentSize(context, 7.2),
        child: Obx(
          () => BottomNavigationBar(
              onTap: (value) {
                bottomNavController.page.value = value;
                // bottomNavigationStore.currentPage = value;
              },
              backgroundColor: ConstantData.bgColor,
              elevation: 15,
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavController.page.value,
              selectedItemColor: ConstantData.primaryColor,
              unselectedItemColor: Colors.black45,
              iconSize: getScreenPercentSize(context, 3.2),
              selectedLabelStyle: TextStyle(
                fontFamily: ConstantData.fontFamily,
                fontSize: font12Px(context: context),
                fontWeight: FontWeight.w600,
                color: ConstantData.primaryColor,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: ConstantData.fontFamily,
                fontSize: font12Px(context: context),
                color: ConstantData.mainTextColor.withOpacity(0.5),
              ),
              items: [
                // BottomNavigationBarItem(
                //   icon: Image.asset(ConstantData.assetsPath + 'home.png'),
                //   activeIcon: Image.asset(
                //     '${ConstantData.assetsPath}home.png',
                //     color: ConstantData.primaryColor,
                //     colorBlendMode: BlendMode.srcIn,
                //   ),
                //   label: 'Home',
                // ),

                BottomNavigationBarItem(
                  icon: Image.asset(
                    '${ConstantData.assetsPath}dashboard.png',
                  ),
                  activeIcon: Image.asset(
                    '${ConstantData.assetsPath}dashboard.png',
                    colorBlendMode: BlendMode.srcIn,
                    color: ConstantData.primaryColor,
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('${ConstantData.assetsPath}shop.png'),
                  activeIcon: Image.asset(
                    '${ConstantData.assetsPath}shop.png',
                    color: ConstantData.primaryColor,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    '${ConstantData.assetsPath}group.png',
                  ),
                  activeIcon: Image.asset(
                    '${ConstantData.assetsPath}group.png',
                    colorBlendMode: BlendMode.srcIn,
                    color: ConstantData.primaryColor,
                  ),
                  label: 'Users',
                ),
                // BottomNavigationBarItem(
                //   icon: Image.asset(ConstantData.assetsPath + 'bag.png'),
                //   activeIcon: Image.asset(
                //     '${ConstantData.assetsPath}bag.png',
                //     color: ConstantData.primaryColor,
                //     colorBlendMode: BlendMode.srcIn,
                //   ),
                //   label: 'Orders',
                // ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    '${ConstantData.assetsPath}user.png',
                  ),
                  activeIcon: Image.asset(
                    '${ConstantData.assetsPath}user.png',
                    colorBlendMode: BlendMode.srcIn,
                    color: ConstantData.primaryColor,
                  ),
                  label: 'Profile',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.settings_outlined),
                //   activeIcon: Icon(Icons.settings),
                //   label: 'Settings',
                // ),
              ]),
        ),
      ),
      body: Obx(() => pages[bottomNavController.page.value]),
    );
  }
}
