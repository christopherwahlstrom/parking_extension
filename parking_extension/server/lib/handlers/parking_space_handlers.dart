import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:server/repositories/parking_space_repository.dart';
import 'package:shared/shared.dart';

final parkingSpaceRepository = ParkingSpaceRepository();

Future<Response> postParkingSpaceHandler(Request request) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    var parkingSpace = ParkingSpace.fromJson(json);

    parkingSpace = await parkingSpaceRepository.create(parkingSpace);

    return Response.ok(
      jsonEncode(parkingSpace.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error creating parking space: $e');
  }
}

Future<Response> getParkingSpacesHandler(Request request) async {
  try {
    final parkingSpaces = await parkingSpaceRepository.getAll();
    final json = parkingSpaces.map((e) => e.toJson()).toList();

    return Response.ok(
      jsonEncode(json),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error getting parking spaces: $e');
  }
}

Future<Response> getParkingSpaceByIdHandler(Request request, String id) async {
  try {
    final parkingSpace = await parkingSpaceRepository.getById(id);
    if (parkingSpace == null) {
      return Response.notFound('Parking space not found');
    }

    return Response.ok(
      jsonEncode(parkingSpace.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error getting parking space: $e');
  }
}

Future<Response> updateParkingSpaceHandler(Request request, String id) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    var parkingSpace = ParkingSpace.fromJson(json);

    parkingSpace = await parkingSpaceRepository.update(id, parkingSpace);

    return Response.ok(
      jsonEncode(parkingSpace.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error updating parking space: $e');
  }
}

Future<Response> deleteParkingSpaceHandler(Request request, String id) async {
  try {
    await parkingSpaceRepository.delete(id);
    return Response.ok('Parking space deleted');
  } catch (e) {
    return Response.internalServerError(body: 'Error deleting parking space: $e');
  }
}