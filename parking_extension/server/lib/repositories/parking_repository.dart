import 'dart:convert';
import 'dart:io';

import 'package:server/models/parking.dart';
import 'package:server/repositories/file_repository.dart';

class ParkingRepository extends FileRepository<Parking> {
  ParkingRepository() : super('parkings.json');

  @override
  Parking fromJson(Map<String, dynamic> json) {
    return Parking.fromJson(json);
  }

  @override
  String idFromType(Parking parking) {
    return parking.id;
  }

  @override
  Map<String, dynamic> toJson(Parking parking) {
    return parking.toJson();
  }
}