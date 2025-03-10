import 'dart:convert';
import 'dart:io';

import 'package:shared/shared.dart';

abstract class FileRepository<T> implements RepositoryInterface<T> {
  final String filePath;

  FileRepository(this.filePath);

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T vehicle);

  String idFromType(T vehicle);

  Future<List<T>> readFile() async {
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsString('[]');

      return [];
    }

    final content = await file.readAsString();

    final List<dynamic> jsonList = jsonDecode(content);

    return jsonList.map((json) => fromJson(json)).toList();
  }


  Future<void> writeFile(List<T> vehicles) async {
    final file = File(filePath);

    final jsonList = vehicles.map((vehicle) => toJson(vehicle)).toList();

    await file.writeAsString(jsonEncode(jsonList));
  }

  @override
  Future<T> create(T vehicle) async {
    var vehicles = await readFile();
    vehicles.add(vehicle);
    await writeFile(vehicles);
    return vehicle;
  }

  @override
  Future<List<T>> getAll() async {
    var vehicles = await readFile();
    return vehicles;
  }

  @override
  Future<T?> getById(String id) async {
    var vehicles = await readFile();
    for (var vehicle in vehicles) {
      if (idFromType(vehicle) == id) {
        return vehicle;
      }
    }
    return null;
  }

  @override
  Future<T> update(String id, T newVehicle) async {
    var vehicles = await readFile();
    for (var i = 0; i < vehicles.length; i++) {
      if (idFromType(vehicles[i]) == id) {
        vehicles[i] = newVehicle;
        await writeFile(vehicles);
        return newVehicle;
      }
    }
    throw Exception('Vehicle not found');
  }

  @override
  Future<T> delete(String id) async {
    var vehicles = await readFile();

    var index = vehicles.indexWhere((vehicle) => idFromType(vehicle) == id);
    if (index == -1) {
      throw Exception('Vehicle not found');
    } else {
      var vehicle = vehicles.removeAt(index);
      await writeFile(vehicles);
      return vehicle;
    }
  }
}
