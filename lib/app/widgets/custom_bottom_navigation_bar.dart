import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/page_index_controller.dart';
import '../modules/menu/management_screen.dart';
import '../style/app_color.dart';

class CustomBottomNavigationBar extends GetView<PageIndexController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        alignment: new FractionalOffset(.5, 1.0),
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.secondaryExtraSoft, width: 1),
                ),
              ),
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: (controller.pageIndex.value == 0)
                                    ? SvgPicture.asset(
                                        'assets/icons/home-active.svg')
                                    : SvgPicture.asset('assets/icons/home.svg'),
                                margin: EdgeInsets.only(bottom: 4),
                              ),
                              Text(
                                "Home".tr,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text(
                        "Presence".tr,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () => controller.changePage(2),
                          child: IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                    ManagementScreen(
                                      sharedPreferences: Get.find(),
                                    ),
                                    backgroundColor: Colors.transparent);
                              },
                              icon: Icon(Icons.menu))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: Obx(
              () => SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  backgroundColor: AppColor.primary,
                  onPressed: () => controller.changePage(1),
                  elevation: 0,
                  child: (controller.presenceController.isLoading.isFalse)
                      ? SvgPicture.asset(
                          'assets/icons/fingerprint.svg',
                          color: Colors.white,
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
