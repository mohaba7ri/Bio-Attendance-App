import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../employee_Details/controllers/employee_details_controller.dart';
import '../controllers/Employees_controller.dart';

class ListEmployeeView extends GetView<ListEmployeeController> {
  final detialEmployee = Get.put(employeeDetailController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    ListEmployeeController _listEmployeeController = ListEmployeeController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Employees',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _listEmployeeController.Employee(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var date = snapshot.data!.docs;

                  return date[index]['name'] == 'name'
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                detialEmployee.EmpList =
                                    snapshot.data!.docs[index];

                                print(detialEmployee.EmpList['name']);
                                Get.toNamed(Routes.EMP_DETAIL);
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.primarySoft,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/pattern-1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              'Name: ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              date[index]['name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Icon(
                                                (Icons
                                                    .arrow_forward_ios_outlined),
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              'Email:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 12),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['email'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        decoration: BoxDecoration(
                                          color: AppColor.primarySoft,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            //  check in
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 6),
                                                    child: Text(
                                                      "Phone",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    date[index]['role'],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1.5,
                                              height: 24,
                                              color: Colors.white,
                                            ),
                                            // check out
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 6),
                                                    child: Text(
                                                      "Address",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    date[index]['address'],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              )),
                        );
                },
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
