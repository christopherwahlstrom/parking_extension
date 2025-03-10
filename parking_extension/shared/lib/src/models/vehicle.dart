import 'package:uuid/uuid.dart';

class Vehicle {
  String description;
  String id;

  Vehicle(this.description, [String? id]) : id = id ?? Uuid().v4();

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(json['description'], json['id']);
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "id": id};
  }
}
