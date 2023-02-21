import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/attendance_service.dart';
import '../../services/auth_service.dart';
import '../authenticate/sign_in.dart';
import '../constant.dart';
import '../models/attendance_model.dart';
import '../widgets/attendance_line.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> dataList = [
    "7.45-8.45",
    "8.45-9.45",
    "9.45-10.45",
    "10.45-11.45",
    "11.45-12.45",
    "12.45-1.45",
    "1.45-2.45",
    "2.45-3.45",
    "3.45-4.45"
  ];
  final List<String> venueList = [
    "LecRoom1",
    "LecRoom2",
    "LecRoom3",
    "LecRoom4"
  ];
  final Authentication auth = Authentication();
  final AttendanceService atService = AttendanceService();
  String date = "";
  DateTime? selectedDate;
  DateTime selectedDateTest = DateTime.now();
  bool isDateSelected = false;
  final formKey = GlobalKey<FormState>();
  String? venue;
  String? timeRange;

  bool isLoading = false;
  List<AttendanceModel> listOfAttendance = [];
  void loading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> fetchData() async {
    loading(true);
    listOfAttendance =
        await atService.getAttendanceData(selectedDate!, timeRange!, venue!);

    loading(false);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDateTest,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        isDateSelected = true;
        selectedDate = selected;
        selectedDateTest = selected;
      });
    }
    print("SELECTET DATE 01 ${selectedDate?.day}");
  }

  bool isDateNull = false;
  bool isDateInvalid = false;
  bool isDateValidated = false;

  bool dateValidation(DateTime? date) {
    if (date == null) {
      setState(() {
        isDateNull = true;
      });
    } else {
      setState(() {
        isDateInvalid = false;
        isDateNull = false;
        isDateValidated = true;
      });
    }

    return isDateValidated;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), actions: [
        IconButton(
            onPressed: () async {
              await auth.logOut();
              Get.off(() => const SignIn());
            },
            icon: const Icon(Icons.logout)),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField2(
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Venue',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 25,
                      buttonHeight: 50,
                      // buttonPadding: const EdgeInsets.only(left: 0, right: 5),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: venueList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select venue';
                        }
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        venue = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Time',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 25,
                      buttonHeight: 50,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: dataList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select time';
                        }
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        timeRange = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: decoratedBorder,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: inputDecoration.copyWith(
                                hintText: isDateSelected
                                    ? "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}"
                                    : '  Date',
                              ),
                              onTap: () {
                                _selectDate(context);
                                print("SELECTET DATE 02 ${selectedDate?.day}");
                              },
                            ),
                          ),
                        ),
                        if (isDateNull)
                          Text("Please enter a date.", style: errorTextStyle),
                        if (isDateInvalid)
                          Text("Please enter valid date.",
                              style: errorTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: ElevatedButton(
                  style: elevatedButtonShape,
                  onPressed: isLoading
                      ? null
                      : () async {
                          bool? validate = formKey.currentState?.validate();
                          dateValidation(selectedDate);
                          if (validate == true && isDateValidated) {
                            formKey.currentState?.save();
                            await fetchData();
                          }
                        },
                  child: Ink(
                    decoration: buttonDecoration,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: const Text(
                        'Get Attendance',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: decoratedBorder.copyWith(color: Colors.green[200]),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Attendance Count",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(listOfAttendance.length.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: decoratedBorder,
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Date Time"),
                    Text('E no'),
                    Text('Name'),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SingleChildScrollView(
                child: isLoading
                    ? const Center(
                        child: SingleChildScrollView(),
                      )
                    : SizedBox(
                        height: size.height * 0.54,
                        child: Column(
                          children: listOfAttendance
                              .map((e) => AttendanceLine(
                                  dateTime: e.date, eNo: e.regNo, name: e.name))
                              .toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
