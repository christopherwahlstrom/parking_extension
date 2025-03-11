import 'dart:io';

import 'package:cli/repositories/parking_repository.dart';
import 'package:cli/repositories/vehicle_repository.dart';
import 'package:cli/repositories/parking_space_repository.dart';
import 'package:cli/utils/validator.dart';
import 'package:shared/shared.dart';

ParkingRepository repository = ParkingRepository();
VehicleRepository vehicleRepository = VehicleRepository();
ParkingSpaceRepository parkingSpaceRepository = ParkingSpaceRepository();

class ParkingOperations {
  static Future create() async {
    print('Enter vehicle registreringsnummer: ');
    var registreringsnummer = stdin.readLineSync();

    print('Enter parking space address: ');
    var adress = stdin.readLineSync();

    if (Validator.isString(registreringsnummer) && Validator.isString(adress)) {
      List<Vehicle> allVehicles = await vehicleRepository.getAll();
      Vehicle? vehicle = allVehicles.firstWhere((v) => v.registreringsnummer == registreringsnummer, orElse: () => null);

      if (vehicle == null) {
        print('Vehicle not found. Please create the vehicle first.');
        return;
      }

      List<ParkingSpace> allParkingSpaces = await parkingSpaceRepository.getAll();
      ParkingSpace? parkingSpace = allParkingSpaces.firstWhere((p) => p.adress == adress, orElse: () => null);

      if (parkingSpace == null) {
        print('Parking space not found. Please create the parking space first.');
        return;
      }

      Parking parking = Parking(
        fordon: vehicle,
        parkeringsplats: parkingSpace,
        starttid: DateTime.now(),
      );

      await repository.create(parking);
      print('Parking created');
    }
  }
}