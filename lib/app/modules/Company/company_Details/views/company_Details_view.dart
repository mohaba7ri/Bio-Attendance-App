import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/images.dart';
import '../controllers/company_Details_controller.dart';
import 'widgets/buttonArrow.dart';
import 'widgets/draggableContainer.dart';

class CompanyDetailsView extends GetView<CompanyDetailsController> {
  final detialEmployee = Get.put(CompanyDetailsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(Images.comExample),
          ),
          buttonArrow(context),
          DraggableScreen(),
        ],
      ),
    ));
    // CompanyDetailsController _companyDetailsController =
    //     CompanyDetailsController();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         'Company_Details'.tr,
    //         style: TextStyle(
    //           color: AppColor.secondary,
    //           fontSize: 18,
    //           fontWeight: FontWeight.w800,
    //         ),
    //       ),
    //       actions: [
    //         IconButton(
    //           onPressed: () => Get.toNamed(Routes.HOME),
    //           icon: Icon(Icons.home),
    //           color: AppColor.blackColor,
    //         )
    //       ],
    //       leading: backButton,
    //       backgroundColor: Colors.white,
    //       elevation: 0,
    //       centerTitle: true,
    //       bottom: PreferredSize(
    //         preferredSize: Size.fromHeight(1),
    //         child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           height: 1,
    //           color: AppColor.greyShade200,
    //         ),
    //       ),
    //     ),
    //     body: GetBuilder<CompanyDetailsController>(
    //       builder: (controller) => Container(
    //         color: Colors.grey[200],
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.0),
    //               color: Colors.white,
    //               boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
    //             ),
    //             padding:
    //                 EdgeInsets.only(left: 24, top: 20, right: 8, bottom: 20),
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Text(
    //                                 "Name".tr,
    //                                 style: TextStyle(fontSize: 18),
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.only(left: 15.0),
    //                               ),
    //                               Icon(Icons.adobe_rounded),
    //                             ],
    //                           ),
    //                           SizedBox(height: 6),
    //                           Text(
    //                             controller.companyInfo['name'],
    //                             style: TextStyle(
    //                               fontSize: 20,
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "Email".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.email_outlined),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6),
    //                             Text(
    //                               controller.companyInfo['email'],
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "address".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.location_pin),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6),
    //                             Text(
    //                               controller.companyInfo['address'],
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "Phone".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.phone_android_outlined),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6),
    //                             Text(
    //                               controller.companyInfo['phone'],
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "Number_of_Branches".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.numbers_outlined),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6),
    //                             Text(
    //                               '${controller.branchNumbers.toString()}', //date[index]['phone'],
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "Number_of_Employees".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.people_alt_outlined),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6),
    //                             Text(
    //                               '${controller.userNumbers.toString()}', //date[index]['phone'],
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   SizedBox(width: 24),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Text(
    //                                   "Location".tr,
    //                                   style: TextStyle(fontSize: 18),
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                       const EdgeInsets.only(left: 15.0),
    //                                 ),
    //                                 Icon(Icons.location_searching_outlined),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           width: 10,
    //                         ),
    //                         Expanded(
    //                           child: Text(
    //                             "Latitude".tr,
    //                             style: TextStyle(
    //                               fontSize: 10,
    //                               color: AppColor.blackColor,
    //                             ),
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: Text(
    //                             "Longitude",
    //                             style: TextStyle(
    //                               fontSize: 10,
    //                               color: AppColor.blackColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                   StreamBuilder(
    //                     stream: controller.getCompanySettings(),
    //                     builder: (context, snapshot) {
    //                       if (snapshot.hasError) {
    //                         return Text('Something went wrong');
    //                       }

    //                       if (snapshot.connectionState ==
    //                           ConnectionState.waiting) {
    //                         return Text("Loading".tr);
    //                       }

    //                       return ListView(
    //                           shrinkWrap: true,
    //                           physics: BouncingScrollPhysics(),
    //                           children: snapshot.data!.docs.map(
    //                             (DocumentSnapshot document) {
    //                               Map<String, dynamic> data =
    //                                   document.data()! as Map<String, dynamic>;
    //                               return Padding(
    //                                 padding: const EdgeInsets.only(top: 10.0),
    //                                 child: Column(
    //                                   children: [
    //                                     Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   'Start_Time'.tr,
    //                                                   style: TextStyle(
    //                                                       fontSize: 18),
    //                                                 ),
    //                                                 Padding(
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 15.0),
    //                                                 ),
    //                                                 Icon(
    //                                                   Icons
    //                                                       .access_time_outlined,
    //                                                   size: 30,
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                             SizedBox(height: 6),
    //                                             Text(
    //                                               "${DateFormat.jm().format(DateTime.parse(data["startTime"]))}", //date[index]['phone'],
    //                                               style: TextStyle(
    //                                                 fontSize: 20,
    //                                                 fontWeight: FontWeight.w600,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   'End_Time'.tr,
    //                                                   style: TextStyle(
    //                                                       fontSize: 18),
    //                                                 ),
    //                                                 Padding(
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 15.0),
    //                                                 ),
    //                                                 Icon(
    //                                                   Icons
    //                                                       .access_time_outlined,
    //                                                   size: 30,
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                             SizedBox(height: 6),
    //                                             Text(
    //                                               "${DateFormat.jm().format(DateTime.parse(data["endTime"]))}", //date[index]['phone'],
    //                                               style: TextStyle(
    //                                                 fontSize: 20,
    //                                                 fontWeight: FontWeight.w600,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     Divider(
    //                                       thickness: 2,
    //                                     ),
    //                                     Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   'Late_Time'.tr,
    //                                                   style: TextStyle(
    //                                                       fontSize: 18),
    //                                                 ),
    //                                                 Padding(
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 15.0),
    //                                                 ),
    //                                                 Icon(
    //                                                   Icons
    //                                                       .access_time_outlined,
    //                                                   size: 30,
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                             SizedBox(height: 6),
    //                                             Text(
    //                                               "${DateFormat.jm().format(DateTime.parse(data["lateTime"]))}", //date[index]['phone'],
    //                                               style: TextStyle(
    //                                                 fontSize: 20,
    //                                                 fontWeight: FontWeight.w600,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   'Overly_Time'.tr,
    //                                                   style: TextStyle(
    //                                                       fontSize: 18),
    //                                                 ),
    //                                                 Padding(
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 15.0),
    //                                                 ),
    //                                                 Icon(
    //                                                   Icons
    //                                                       .access_time_outlined,
    //                                                   size: 30,
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                             SizedBox(height: 6),
    //                                             Text(
    //                                               "${DateFormat.jm().format(DateTime.parse(data["overlyTime"]))}", //date[index]['phone'],
    //                                               style: TextStyle(
    //                                                 fontSize: 20,
    //                                                 fontWeight: FontWeight.w600,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                               );
    //                             },
    //                           ).toList());
    //                     },
    //                   ),
    //                   Divider(
    //                     thickness: 2,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ));
  }
}
