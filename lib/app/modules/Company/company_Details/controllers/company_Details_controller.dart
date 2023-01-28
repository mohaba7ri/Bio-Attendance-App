import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CompanyDetailsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    companyInfo;

    companySettings;
  }

  RxBool isloading = false.obs;
  dynamic companyInfo = Get.arguments;
  RxMap companySettings = {}.obs;
  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCompanySettings() async* {
    yield* firestore
        .collection('companySettings')
        .where('companyId', isEqualTo: companyInfo['companyId'])
        .snapshots();
  }
}
