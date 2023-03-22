import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyVacationController extends GetxController {
  final SharedPreferences sharedPreferences;

  MyVacationController({required this.sharedPreferences});
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

  }

  String requestValue = 'All';
  List<String> requestItems = ['All', 'Pending', 'Approved', 'Denied'];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    if (requestValue == 'All') {
      yield* firestore
          .collection('vacationRequest')
          .where('userId', isEqualTo: sharedPreferences.getString('userId'))
          .snapshots();
      update();
    } else {
      yield* firestore
          .collection('vacationRequest')
          .where('status', isEqualTo: requestValue)
          .where('userId', isEqualTo: sharedPreferences.getString('userId'))
          .snapshots();
      update();
    }
  }

  String? vacationsNumber = '';
  String? approvedNumber = '';
  String? deniedNumber = '';


  changeRequestValue(String value) {
    requestValue = value;
    update();
  }
}
