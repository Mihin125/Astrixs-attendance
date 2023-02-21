import 'dart:convert';

class AttendanceModel {
  String? date;
  String? name;
  String? regNo;
  int? uid;
  String? venue;
  AttendanceModel({
    this.date,
    this.name,
    this.regNo,
    this.uid,
    this.venue,
  });

  AttendanceModel copyWith({
    String? date,
    String? name,
    String? regNo,
    int? uid,
    String? venue,
  }) {
    return AttendanceModel(
      date: date ?? this.date,
      name: name ?? this.name,
      regNo: regNo ?? this.regNo,
      uid: uid ?? this.uid,
      venue: venue ?? this.venue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Date': date,
      'Name': name,
      'Reg no': regNo,
      'Uid': uid,
      'Venue': venue,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      date: map['Date'] != null ? map['Date'] as String : null,
      name: map['Name'] != null ? map['Name'] as String : null,
      regNo: map['Reg no'] != null ? map['Reg no'] as String : null,
      uid: map['Uid'] != null ? map['Uid'] as int : null,
      venue: map['Venue'] != null ? map['Venue'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttendenceModel(Date: $date, Name: $name, Reg no: $regNo, Uid: $uid, Venue: $venue)';
  }

  @override
  bool operator ==(covariant AttendanceModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.name == name &&
        other.regNo == regNo &&
        other.uid == uid &&
        other.venue == venue;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        name.hashCode ^
        regNo.hashCode ^
        uid.hashCode ^
        venue.hashCode;
  }
}
