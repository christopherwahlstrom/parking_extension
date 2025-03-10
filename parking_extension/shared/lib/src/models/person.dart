import 'package:uuid/uuid.dart';

import 'vehicle.dart';

class Person {
  String description;
  List<Vehicle> vehicles;
  String id;

  Person({required this.description, List<Vehicle>? vehicles, String? id})
      : vehicles = vehicles ?? [],
        id = id ?? Uuid().v4();


  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      description: json['description'],
      vehicles: (json['vehicles'] as List).map((e) => Vehicle.fromJson(e)).toList(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "vehicles": vehicles.map((e) => e.toJson()).toList(),
      "id": id,
    };
  }
}
