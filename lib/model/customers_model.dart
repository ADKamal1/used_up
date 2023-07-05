import '../shared/helper/mangers/constants.dart';

class CustomerModel {
  String? id;
  String? userId;
  String? name;
  String? searchName;
  String? phone;
  double? lat;
  double? lon;
  String? note;
  String? image;
  String? date;
  String? time;
  bool? isMocking;

  CustomerModel({
    this.id = ConstantsManger.DEFULT,
    required this.userId,
    required this.name,
    required this.phone,
    required this.searchName,
    required this.lat,
    required this.lon,
    required this.note,
    required this.image,
    required this.date,
    required this.time,
    required this.isMocking,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    note = json['note'];
    lat = json['lat'];
    lon = json['lon'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
    isMocking = json['isMocking'];
    searchName = json['searchName'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "name": name,
      "phone": phone,
      "note": note,
      "lat": lat,
      "lon": lon,
      "image": image,
      "time": time,
      "date": date,
      "isMocking": isMocking,
      "searchName": searchName,
    };
  }
}
