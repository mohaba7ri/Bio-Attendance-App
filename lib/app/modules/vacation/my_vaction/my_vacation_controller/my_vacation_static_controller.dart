import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyVacationStaticController extends GetxController {
  final SharedPreferences sharedPreferences;
  
  MyVacationStaticController({required this.sharedPreferences});
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
     await getVacationsNumber();
    await getApprovedNumber();
    await getDeniedNumber();
  }


  FirebaseFirestore firestore = FirebaseFirestore.instance;

 
  String? vacationsNumber = '';
  String? approvedNumber = '';
  String? deniedNumber = '';

  Future getVacationsNumber() async {
   
    await firestore
        .collection('vacationRequest')
        .where('userId', isEqualTo: sharedPreferences.getString('userId'))
        .get()
        .then((QuerySnapshot query) {
      vacationsNumber = query.size.toString();

      print('number of Vacations$vacationsNumber');
      update();
    });
  }

  Future getApprovedNumber() async {
  
    try {
      await firestore
          .collection('vacationRequest')
          .where('status', isEqualTo: "Approved")
          .where('userId', isEqualTo: sharedPreferences.getString('userId'))
          .get()
          .then((QuerySnapshot query) {
        approvedNumber = query.size.toString();

        print('number of Approved$approvedNumber');
        update();
      });
    } catch (e) {}
  }

  Future getDeniedNumber() async {

    await firestore
        .collection('vacationRequest')
        .where('status', isEqualTo: "Denied")
        .where('userId', isEqualTo: sharedPreferences.getString('userId'))
        .get()
        .then((QuerySnapshot query) {
      deniedNumber = query.size.toString();

      print('number of Declined$deniedNumber');
      update();
    });
  }


}
