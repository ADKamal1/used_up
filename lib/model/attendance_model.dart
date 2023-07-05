import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin_app/shared/helper/mangers/constants.dart';

class AttendanceModel {
  String? id;
  String? userId;
  String? dateAttend;
  String? dateLeave;
  String? timeAttend;
  String? timeLeave;
  double? lat;
  double? lon;
  String? location;
  bool? isAttend;
  bool? isLeave;

  AttendanceModel(
      {this.id = ConstantsManger.DEFULT,
      required this.userId,
      this.dateAttend = ConstantsManger.DEFULT,
      this.dateLeave = ConstantsManger.DEFULT,
      this.timeAttend = ConstantsManger.DEFULT,
      this.timeLeave = ConstantsManger.DEFULT,
      this.lat = 0,
      this.lon = 0,
      this.location = ConstantsManger.DEFULT,
      this.isAttend = false,
      this.isLeave = false});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    dateAttend = json['dateAttend'];
    dateLeave = json['dateLeave'];
    timeAttend = json['timeAttend'];
    timeLeave = json['timeLeave'];
    lat = json['lat'];
    lon = json['lon'];
    location = json['location'];
    isAttend = json['isAttend'];
    isLeave = json['isLeave'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "dateAttend": dateAttend,
      "dateLeave": dateLeave,
      "timeAttend": timeAttend,
      "timeLeave": timeLeave,
      "lat": lat,
      "lon": lon,
      "location": location,
      "isAttend": isAttend,
      "isLeave": isLeave,
    };
  }
}
