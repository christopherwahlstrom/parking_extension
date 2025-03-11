import 'package:uuid/uuid.dart';
import 'person.dart';

class Vehicle {
  String registreringsnummer;
  String typ;
  Person owner;
  String id;

  Vehicle({
    required this.registreringsnummer,
    required this.typ,
    required this.owner,
    String? id,
  }) : id = id ?? Uuid().v4();

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      registreringsnummer: json['registreringsnummer'],
      typ: json['typ'],
      owner: Person.fromJson(json['owner']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registreringsnummer': registreringsnummer,
      'typ': typ,
      'owner': owner.toJson(),
      'id': id,
    };
  }
}