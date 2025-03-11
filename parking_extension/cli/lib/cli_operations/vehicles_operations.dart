import 'dart:io';

import 'package:cli/repositories/vehicle_repository.dart';
import 'package:cli/utils/validator.dart';
import 'package:shared/shared.dart';

VehicleRepository repository = VehicleRepository();

class VehiclesOperations {
  static Future create() async {
    print('Enter registreringsnummer: ');
    var registreringsnummer = stdin.readLineSync();

    print('Enter typ (car, motorcycle, etc.): ');
    var typ = stdin.readLineSync();

    print('Enter owner name: ');
    var ownerName = stdin.readLineSync();

    print('Enter owner personnummer: ');
    var ownerPersonnummer = stdin.readLineSync();

    if (Validator.isString(registreringsnummer) && Validator.isString(typ) && Validator.isString(ownerName) && Validator.isString(ownerPersonnummer)) {
      Person owner = Person(
        namn: ownerName!,
        personnummer: ownerPersonnummer!,
        vehicles: [],
      );

      Vehicle vehicle = Vehicle(
        registreringsnummer: registreringsnummer!,
        typ: typ!,
        owner: owner,
      );

      await repository.create(vehicle);
      print('Vehicle created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async {
    List<Vehicle> allVehicles = await repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].registreringsnummer} - ${allVehicles[i].typ} - Owner: ${allVehicles[i].owner.namn}');
    }
  }

  static Future update() async {
    print('Pick an index to update: ');
    List<Vehicle> allVehicles = await repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].registreringsnummer} - ${allVehicles[i].typ} - Owner: ${allVehicles[i].owner.namn}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      Vehicle vehicle = allVehicles[index];

      print('Enter new registreringsnummer: ');
      var registreringsnummer = stdin.readLineSync();

      print('Enter new typ (car, motorcycle, etc.): ');
      var typ = stdin.readLineSync();

      print('Enter new owner name: ');
      var ownerName = stdin.readLineSync();

      print('Enter new owner personnummer: ');
      var ownerPersonnummer = stdin.readLineSync();

      if (Validator.isString(registreringsnummer) && Validator.isString(typ) && Validator.isString(ownerName) && Validator.isString(ownerPersonnummer)) {
        vehicle.registreringsnummer = registreringsnummer!;
        vehicle.typ = typ!;
        vehicle.owner = Person(
          namn: ownerName!,
          personnummer: ownerPersonnummer!,
          vehicles: [],
        );

        await repository.update(allVehicles[index].id, vehicle);
        print('Vehicle updated');
      } else {
        print('Invalid input');
      }
    } else {
      print('Invalid input');
    }
  }

  static Future delete() async {
    print('Pick an index to delete: ');
    List<Vehicle> allVehicles = await repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].registreringsnummer} - ${allVehicles[i].typ} - Owner: ${allVehicles[i].owner.namn}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allVehicles[index].id);
      print('Vehicle deleted');
    } else {
      print('Invalid input');
    }
  }
}
