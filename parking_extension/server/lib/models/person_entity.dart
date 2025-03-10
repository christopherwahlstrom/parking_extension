import 'package:server/repositories/vehicle_repository.dart';
import 'package:shared/shared.dart';

class PersonEntity {
  final String description;
  final List<String> vehiclesIds;
  final String id;

  PersonEntity(
      {required this.description, required this.vehiclesIds, required this.id});


  factory PersonEntity.fromJson(Map<String, dynamic> json) {
    return PersonEntity(
      description: json['description'],
      vehiclesIds: (json['vehiclesIds'] as List).map((e) => e as String).toList(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "vehiclesIds": vehiclesIds,
      "id": id,
    };
  }

  Future<Person> toModel() async {
    final vehicles =
        await Future.wait(vehiclesIds.map((id) => VehicleRepository().getById(id)));
    return Person(
        description: description, vehicles: vehicles.nonNulls.toList(), id: id);
  }
}

extension EntityCoversion on Person {
  PersonEntity toEntity() {
    return PersonEntity(
        description: description,
        vehiclesIds: vehicles.map((vehicle) => vehicle.id).toList(),
        id: id);
  }
}
