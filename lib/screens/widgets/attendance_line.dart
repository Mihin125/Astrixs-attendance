// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AttendanceLine extends StatelessWidget {
  final String? dateTime;
  final String? eNo;
  final String? name;
  const AttendanceLine({
    Key? key,
    this.dateTime,
    this.eNo,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 0, bottom: 0),
      padding: const EdgeInsets.only(top: 0, left: 10, right: 5, bottom: 0),
      height: 30,
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dateTime.toString()),
          Text(eNo.toString()),
          Text(name.toString()),
        ],
      ),
    );
  }
}
