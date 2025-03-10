import 'dart:io';

import 'package:cli/repositories/person_repository.dart';
import 'package:cli/repositories/vehicle_repository.dart';
import 'package:cli/utils/validator.dart';
import 'package:shared/shared.dart';

PersonRepository repository = PersonRepository();

class PersonsOperations {
  static Future create() async {
    print('Enter name: ');

    var input = stdin.readLineSync();

    if (Validator.isString(input)) {
      Person person = Person(description: input!);
      await repository.create(person);
      print('Person created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async {
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print(
          '${i + 1}. ${allPersons[i].description} - [${allPersons[i].vehicles.map((e) => e.description).join(', ')}]');
    }
  }

  static Future update() async {
    print('Pick an index to update: ');
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print('${i + 1}. ${allPersons[i].description}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allPersons)) {
      int index = int.parse(input!) - 1;

      while (true) {
        print("\n------------------------------------\n");

        Person person = await repository.getById(allPersons[index].id);

        print(
            "What would you like to update in person: ${person.description} - [${person.vehicles.map((e) => e.description).join(", ")}]?");
        print('1. Update description');
        print('2. Add vehicle to person');
        print('3. Remove vehicle from person');

        var input = stdin.readLineSync();

        if (Validator.isNumber(input)) {
          int choice = int.parse(input!);

          switch (choice) {
            case 1:
              await _updateDescription(person);
              break;
            case 2:
              await _addVehicleToPerson(person);
              break;
            case 3:
              await _removeVehiclesFromPerson(person);
              break;
            default:
              print('Invalid choice');
          }
        } else {
          print('Invalid input');
        }
        print("Would you like to update anything else? (y/n)");
        input = stdin.readLineSync();
        if (input == 'n') {
          break;
        }
      }
    } else {
      print('Invalid input');
    }
  }

  static Future _updateDescription(Person person) async {
    print('Enter new description: ');
    var description = stdin.readLineSync();

    if (Validator.isString(description)) {
      person.description = description!;
      await repository.update(person.id, person);
      print('Person updated');
    } else {
      print('Invalid input');
    }
  }

  static Future _addVehicleToPerson(Person person) async {
    // list all vehicles and pick a vehicle to add

    var allVehicles = await VehicleRepository().getAll();
    print('Pick a vehicle to add: ');

    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].description}');
    }

    var input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      person.vehicles.add(allVehicles[index]);
      await repository.update(person.id, person);
      print('Vehicle added to person');
    } else {
      print('Invalid input');
    }
  }

  static Future _removeVehiclesFromPerson(Person person) async {
    print('Pick a vehicle to remove: ');
    for (int i = 0; i < person.vehicles.length; i++) {
      print('${i + 1}. ${person.vehicles[i].description}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, person.vehicles)) {
      int index = int.parse(input!) - 1;
      person.vehicles.removeAt(index);
      await repository.update(person.id, person);
      print('Vehicle removed from person');
    } else {
      print('Invalid input');
    }
  }

  static Future delete() async {
    print('Pick an index to delete: ');
    List<Person> allPersons = await repository.getAll();
    for (int i = 0; i < allPersons.length; i++) {
      print('${i + 1}. ${allPersons[i].description}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allPersons)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allPersons[index].id);
      print('Person deleted');
    } else {
      print('Invalid input');
    }
  }
}