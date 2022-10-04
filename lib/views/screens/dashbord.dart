import 'package:fabdashboard/controller/dashborde_controller.dart';
import 'package:fabdashboard/core/constant/style.dart';
import 'package:fabdashboard/data/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_navigation/side_navigation.dart';

class DashbordPage extends StatelessWidget {
  const DashbordPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashbordeControllerImpl
        dashbordeControllerImpl =
        Get.put(DashbordeControllerImpl());
    return Scaffold(
      body: GetBuilder<DashbordeControllerImpl>(
        init: dashbordeControllerImpl,
        builder: (controller) {
          return Row(
            children: [
              /// Pretty similar to the BottomNavigationBar!
              SideNavigationBar(
                header: SideNavigationBarHeader(
                  title: const Text(
                    'FabLab',
                    style: TextStyle(
                        fontFamily: AppText.light,
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w600),
                  ),
                  subtitle:
                      const Text('Dashboard'),
                  image: Image.asset(
                    'assets/images/fablablogo.png',
                    width: 50,
                    height: 50,
                  ),
                ),

                footer:
                    const SideNavigationBarFooter(
                  label: Text('FabLab'),
                ),
                //them section
                theme:
                    const SideNavigationBarTheme(
                  backgroundColor:
                      AppColor.background,

                  // item theme section
                  itemTheme:
                      SideNavigationBarItemTheme(
                          iconSize: 30,
                          selectedItemColor:
                              AppColor.secondry,
                          labelTextStyle:
                              TextStyle(
                                  fontFamily:
                                      AppText
                                          .light,
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight
                                          .w600),
                          unselectedItemColor:
                              Colors.black54),

                  //toggle theme section
                  togglerTheme:
                      SideNavigationBarTogglerTheme(
                    expandIconColor:
                        AppColor.secondry,
                    shrinkIconColor:
                        AppColor.secondry,
                  ),
                  //divider theme section
                  dividerTheme:
                      SideNavigationBarDividerTheme(
                          showFooterDivider: true,
                          showHeaderDivider: true,
                          showMainDivider: true),
                ),
                selectedIndex:
                    controller.selectedIndex,
                items: items,
                onTap: (index) {
                  controller.nextPage(index);
                },
              ),

              Expanded(
                child: screens.elementAt(
                    controller.selectedIndex),
              )
            ],
          );
        },
      ),
    );
  }
}
