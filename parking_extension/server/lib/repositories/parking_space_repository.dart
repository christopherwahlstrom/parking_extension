import 'dart:convert';
import 'dart:io';

import 'package:server/models/parking_space.dart';
import 'package:server/repositories/file_repository.dart';

class ParkingSpaceRepository extends FileRepository<ParkingSpace> {
  ParkingSpaceRepository() : super('parking_spaces.json');

  @override
  ParkingSpace fromJson(Map<String, dynamic> json) {
    return ParkingSpace.fromJson(json);
  }

  @override
  String idFromType(ParkingSpace parkingSpace) {
    return parkingSpace.id;
  }

  @override
  Map<String, dynamic> toJson(ParkingSpace parkingSpace) {
    return parkingSpace.toJson();
  }
}