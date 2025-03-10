import 'dart:io';

import 'package:cli/repositories/vehicle_repository.dart';
import 'package:cli/utils/validator.dart';
import 'package:shared/shared.dart';

VehicleRepository repository = VehicleRepository();

class VehiclesOperations {
  static Future create() async {
    print('Enter description: ');

    var input = stdin.readLineSync();

    if (Validator.isString(input)) {
      Vehicle vehicle = Vehicle(input!);
      await repository.create(vehicle);
      print('Vehicle created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async {
    List<Vehicle> allvehicles = await repository.getAll();
    for (int i = 0; i < allvehicles.length; i++) {
      print('${i + 1}. ${allvehicles[i].description}');
    }
  }

  static Future update() async {
    print('Pick an index to update: ');
    List<Vehicle> allvehicles = await repository.getAll();
    for (int i = 0; i < allvehicles.length; i++) {
      print('${i + 1}. ${allvehicles[i].description}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allvehicles)) {
      int index = int.parse(input!) - 1;
      Vehicle vehicle = allvehicles[index];

      print('Enter new description: ');
      var description = stdin.readLineSync();

      if (Validator.isString(description)) {
        vehicle.description = description!;
        await repository.update(allvehicles[index].id, vehicle);
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
    List<Vehicle> allvehicles = await repository.getAll();
    for (int i = 0; i < allvehicles.length; i++) {
      print('${i + 1}. ${allvehicles[i].description}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allvehicles)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allvehicles[index].id);
      print('Vehicle deleted');
    } else {
      print('Invalid input');
    }
  }
}
