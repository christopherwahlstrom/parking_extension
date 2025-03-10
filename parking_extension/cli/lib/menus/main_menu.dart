import 'dart:io';

import 'package:cli/utils/console.dart';
import 'package:cli/menus/persons_menu.dart';
import 'package:cli/menus/vehicles_menu.dart';

class MainMenu {
  static Future prompt() async {
    Console.clear();

    while (true) {
      // clear the console

      // prompt options to edit items, bags, or exit
      print('Main Menu');
      print('1. Manage Persons');
      print('2. Manage Vehicles');
      print('3. Exit');
      var input = Console.choice();
      switch (input) {
        case 1:
          await PersonsMenu.prompt();
        case 2:
          await VehiclesMenu.prompt();
        case 3:
          return;
        default:
          print('Invalid choice');
      }
      print("\n------------------------------------\n");
    }
  }


}
