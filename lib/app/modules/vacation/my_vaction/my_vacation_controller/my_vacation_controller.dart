import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class MyVacationController extends GetxController {
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVacationsNumber();
    getApprovedNumber();
    getDeniedNumber();
  }

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

  int? vacationsNumber;
  int? approvedNumber;
  int? deniedNumber;

  Future getVacationsNumber() async {
    await firestore
        .collection('vacationRequest')
        .get()
        .then((QuerySnapshot query) {
      vacationsNumber = query.size;

      print('number of Vacations$vacationsNumber');
      update();
    });
  }

  Future getApprovedNumber() async {
    await firestore
        .collection('vacationRequest')
        .where('status', isEqualTo: "Approved")
        .get()
        .then((QuerySnapshot query) {
      approvedNumber = query.size;

      print('number of Approved$approvedNumber');
      update();
    });
  }

  Future getDeniedNumber() async {
    await firestore
        .collection('vacationRequest')
        .where('status', isEqualTo: "Declined")
        .get()
        .then((QuerySnapshot query) {
      deniedNumber = query.size;

      print('number of Declined$deniedNumber');
      update();
    });
  }

  changeRequestValue(String value) {
    requestValue = value;
    update();
  }
}
