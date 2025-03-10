import 'package:server/repositories/file_repository.dart';
import 'package:shared/shared.dart';

class VehicleRepository extends FileRepository<Vehicle> {
  VehicleRepository() : super('vehicles.json');

  @override
  Vehicle fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return Vehicle.fromJson(json);
  }

  @override
  String idFromType(Vehicle vehicle) {
    // TODO: implement idFromType
    return vehicle.id;
  }

  @override
  Map<String, dynamic> toJson(Vehicle vehicle) {
    // TODO: implement toJson
    return vehicle.toJson();
  }
}