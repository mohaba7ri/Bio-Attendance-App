import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class MyVacationController extends GetxController {
  String requestValue = 'All';
  List<String> requestItems = ['All', 'Pending', 'Approved', 'Denied'];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    if (requestValue == 'All') {
      yield* firestore.collection('vacationRequest').snapshots();
      update();
    } else {
      yield* firestore
          .collection('vacationRequest')
          .where('status', isEqualTo: requestValue)
          .snapshots();
      update();
    }
  }

  changeRequestValue(String value) {
    requestValue = value;
    update();
  }
}
