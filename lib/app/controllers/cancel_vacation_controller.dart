import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../modules/home/controllers/home_controller.dart';
import '../widgets/toast/custom_toast.dart';

class CancelVacationController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future cancel(data) async {
    final inputString = data['startDate'];
    final inputFormat = DateFormat('MMM dd, yyyy');
    final inputDate = inputFormat.parse(inputString);

    try {
      await firestore
          .collection('vacationRequest')
          .doc(data['vacationId'])
          .delete();

      await firestore
          .collection('user')
          .doc(data['userId'])
          .collection('presence')
          .where('date', isGreaterThanOrEqualTo: inputDate)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print('the error$e');
    }
  }
    //   Future accept(data) async {
    //     final inputString = data['startDate'];
    //     final inputFormat = DateFormat('MMM dd, yyyy');
    //     final outputFormat = DateFormat('M-d-yyyy');

    //     final inputDate = inputFormat.parse(inputString);
    //     final outputString = outputFormat.format(inputDate);

    //     final startDate = inputDate;
    //     final endDate = inputFormat.parse(data['endDate']);

    //     final duration = endDate.difference(startDate);
    //     final numberOfDays = duration.inDays + 1; // add 1 to include the end day

    //     try {
    //       await firestore
    //           .collection('vacationRequest')
    //           .doc(data['vacationId'])
    //           .update({'status': "Approved"});

    //       // Loop through each day in the vacation period and create a new document
    //       // in the presence collection for that day
    //       for (var i = 0; i < numberOfDays; i++) {
    //         final date = startDate.add(Duration(days: i));
    //         String formattedDate =
    //             DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSS').format(date);
    //         final dateString = outputFormat.format(date);

    //         await firestore
    //             .collection('user')
    //             .doc(data['userId'])
    //             .collection('presence')
    //             .doc(dateString)
    //             .delete();
    //       }
    //     } catch (e) {
    //       print('the error$e');
    //     }
    //   }
    // }
  }

