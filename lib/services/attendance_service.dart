import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/models/attendance_model.dart';

class AttendanceService {
  CollectionReference attendance =
      FirebaseFirestore.instance.collection('Engineering');

  AttendanceModel at = AttendanceModel();
  List<AttendanceModel> attendanceList = [];

  Future<List<AttendanceModel>> getAttendanceData(
    DateTime date,
    String time,
    String venue,
  ) async {
    print("VALUES ${date.toLocal()} $time  $venue");
    attendanceList = [];
    List<AttendanceModel> listOfAttendance = [];
    try {
      QuerySnapshot userSnap = await attendance.get();

      List<QueryDocumentSnapshot<Object?>> newList = userSnap.docs
          .where((e) =>
              AttendanceModel.fromMap(e.data() as Map<String, dynamic>).venue ==
              venue)
          .toList();
      newList.forEach((e) {
        print(e.data().toString());
      });
      for (var e in newList) {
        final data = e.data() as Map<String, dynamic>;

        at = AttendanceModel.fromMap(data);
        attendanceList.add(at);
      }

      listOfAttendance =
          filterDateTimeListByTimePeriod(attendanceList, time, date);
      print(attendanceList.length);
    } catch (e) {
      print("ERROR $e");
    }
    return listOfAttendance;
  }

  List<AttendanceModel> filterDateTimeListByTimePeriod(
      List<AttendanceModel> attendanceList, String timePeriod, DateTime date) {
    String actualTimePeriod = actualTime(timePeriod);
    List<String> timePeriodParts = actualTimePeriod.split("-");
    String startTimeString = timePeriodParts[0];
    String endTimeString = timePeriodParts[1];
    DateTime startTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(startTimeString.split(".")[0]),
      int.parse(startTimeString.split(".")[1]),
    );
    DateTime endTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(endTimeString.split(".")[0]),
      int.parse(endTimeString.split(".")[1]),
    );
    print("START ${startTime.toLocal()} END ${endTime.toLocal()}");

    // List<AttendanceModel> filteredList = attendanceList.where((dateTime) {
    //   return convertStringToDateTime(dateTime.date!).isAfter(startTime) &&
    //       convertStringToDateTime(dateTime.date!).isBefore(endTime);
    // }).toList();

    List<AttendanceModel> filteredList = [];

    for (var e in attendanceList) {
      // if()
      bool val = convertStringToDateTime(e.date!).isAfter(startTime);
      bool val2 = convertStringToDateTime(e.date!).isBefore(endTime);
      print("$val $val2");
      if (val && val2) {
        filteredList.add(e);
      }
    }
    return filteredList;
  }

  DateTime convertStringToDateTime(String dateString) {
    String formattedDateString = dateString.replaceAll("::", ":");
    String formattedDate = formattedDateString.replaceAll("/", "-");
    String formattedDate2 = formattedDate.replaceFirst(":", " ");
    final f = DateFormat('yyyy-MM-dd hh:mm:ss');

    DateTime newDate = f.parse(formattedDate2);
    print(newDate.toLocal());
    return newDate;
  }

  String actualTime(String timePeriod) {
    List<String> timePeriodParts = timePeriod.split("-");
    String startTimeString = timePeriodParts[0];

    String? realStart;
    String? realEnd;

    switch (startTimeString) {
      case "7.45":
        realStart = "7.45";
        realEnd = "8.45";
        break;
      case "8.45":
        realStart = "8.45";
        realEnd = "9.45";
        break;
      case "9.45":
        realStart = "9.45";
        realEnd = "10.45";
        break;
      case "10.45":
        realStart = "10.45";
        realEnd = "11.45";
        break;
      case "11.45":
        realStart = "11.45";
        realEnd = "12.45";
        break;
      case "12.45":
        realStart = "12.45";
        realEnd = "13.45";
        break;
      case "1.45":
        realStart = "13.45";
        realEnd = "14.45";
        break;
      case "2.45":
        realStart = "14.45";
        realEnd = "15.45";
        break;
      case "3.45":
        realStart = "15.45";
        realEnd = "16.45";
        break;
      default:
    }
    String actualTime = "$realStart-$realEnd";
    return actualTime;
  }
}
