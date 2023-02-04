import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EmployeeDetailController extends GetxController {
  dynamic EmpList = Get.arguments;
  String? branchName;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> employee() async* {
    //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }

  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBranch();
    print('branchName$branchName');
  }

  Future getBranch() async {
    await firestore
        .collection('branch')
        .where('branchId', isEqualTo: EmpList['branchId'])
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        branchName = data['name'];
        update();
        print('the name${data['name']}');
      });
    });
  }
}
