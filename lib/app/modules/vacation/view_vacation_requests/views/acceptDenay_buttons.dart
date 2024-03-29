import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';
import '../controllers/view_vacation_request_controller.dart';

class acceptDeny_buttons extends GetView<ViewVacationRequestsController> {
  final data;

  const acceptDeny_buttons(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewVacationRequestsController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            //  check in
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () async {
                          await controller.deny(data['vacationId']);
                          await controller.getNotefication(
                              data['vacationId'], 'Denied');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('decline'.tr, style: robotoMediumWhite),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.accept(data);
                          await controller.getNotefication(
                              data['vacationId'], 'Accepted');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('accept'.tr, style: robotoMediumWhite),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // check out
          ],
        ),
      ),
    );
  }
}
