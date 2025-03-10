import 'package:server/repositories/file_repository.dart';
import 'package:shared/shared.dart';

class VehicleRepository extends FileRepository<Vehicle> {
  VehicleRepository() : super('vehicles.json');

  @override
  Vehicle fromJson(Map<String, dynamic> json) {
    return Vehicle.fromJson(json);
  }

  @override
  String idFromType(Vehicle vehicle) {
    return vehicle.id;
  }

  @override
  Map<String, dynamic> toJson(Vehicle vehicle) {
    return vehicle.toJson();
  }
}