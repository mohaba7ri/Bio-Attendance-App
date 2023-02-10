import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManageVacationController extends GetxController {
  dynamic VacList = Get.arguments;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Stream<DocumentSnapshot<Map<String, dynamic>>> vacationRequests() async* {
  //   //  yield* firestore.collection('vacationRequest').snapshots();
  // }
}
