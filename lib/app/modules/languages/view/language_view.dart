import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/languages/controller/languages_controller.dart';
import 'package:presence/app/widgets/custom_appbar.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

import '../../../routes/app_pages.dart';
import '../../../style/app_color.dart';
import '../../../util/app_constants.dart';
import '../../../util/dinmensions.dart';
import '../../../util/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/language_widget.dart';

class LanguagesView extends StatelessWidget {
  const LanguagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        body: CustomeAppbar(
          backButton: true,
          backRout: () => Get.toNamed(Routes.HOME),
          mainWidget: Container(
            color: AppColor.greyShade200,
            width: MediaQuery.of(context).size.width,
            child:
                GetBuilder<LanguagesController>(builder: (LanguagesController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text('select_language'.tr, style: robotoMedium),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                    ),
                    itemCount: LanguagesController.languages.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LanguageWidget(
                      languageModel: LanguagesController.languages[index],
                      languagesController: LanguagesController,
                      index: index,
                    ),
                  ),
                  LanguageSaveButton(
                      localizationController: LanguagesController),
                ],
              );
            }),
          ),
        ));
  }
}

class LanguageSaveButton extends StatelessWidget {
  final LanguagesController localizationController;

  const LanguageSaveButton({
    Key? key,
    required this.localizationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: 'save'.tr,
      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      onPressed: () {
        if (localizationController.languages.length > 0 &&
            localizationController.selectedIndex != -1) {
          localizationController.setLanguage(Locale(
            AppConstants
                .languages[localizationController.selectedIndex].languageCode,
            AppConstants
                .languages[localizationController.selectedIndex].countryCode,
          ));
        } else {
          CustomToast.successToast('Language', 'select_a_language'.tr);
        }
      },
    );
  }
}
