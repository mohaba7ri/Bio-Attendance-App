
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../style/app_color.dart';
import '../../controllers/list_vacation_requests_controller.dart';

class filter extends StatelessWidget {
  const filter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListVacationRequestsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
      child: ElevatedButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                height: 372,
                child: SfDateRangePicker(
                  headerHeight: 50,
                  headerStyle:
                      DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  selectionColor: AppColor.primary,
                  rangeSelectionColor: AppColor.primary.withOpacity(0.2),
                  viewSpacing: 10,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (data) {
                    if (data != null) {
                      PickerDateRange range = data as PickerDateRange;
                      if (range.endDate != null) {
                        controller.pickDate(range.startDate!, range.endDate!);
                      }
                    }
                    //else skip
                  },
                ),
              ),
            ),
          );
        },
        child: SvgPicture.asset('assets/icons/filter.svg'),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
