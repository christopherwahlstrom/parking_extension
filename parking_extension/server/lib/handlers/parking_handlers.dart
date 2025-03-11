import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:server/repositories/parking_repository.dart';
import 'package:shared/shared.dart';

final parkingRepository = ParkingRepository();

Future<Response> postParkingHandler(Request request) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    var parking = Parking.fromJson(json);

    parking = await parkingRepository.create(parking);

    return Response.ok(
      jsonEncode(parking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error creating parking: $e');
  }
}

Future<Response> getParkingsHandler(Request request) async {
  try {
    final parkings = await parkingRepository.getAll();
    final json = parkings.map((e) => e.toJson()).toList();

    return Response.ok(
      jsonEncode(json),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error getting parkings: $e');
  }
}

Future<Response> getParkingHandler(Request request, String id) async {
  try {
    final parking = await parkingRepository.getById(id);
    if (parking == null) {
      return Response.notFound('Parking not found');
    }

    return Response.ok(
      jsonEncode(parking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error getting parking: $e');
  }
}

Future<Response> updateParkingHandler(Request request, String id) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    var parking = Parking.fromJson(json);

    parking = await parkingRepository.update(id, parking);

    return Response.ok(
      jsonEncode(parking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(body: 'Error updating parking: $e');
  }
}

Future<Response> deleteParkingHandler(Request request, String id) async {
  try {
    await parkingRepository.delete(id);
    return Response.ok('Parking deleted');
  } catch (e) {
    return Response.internalServerError(body: 'Error deleting parking: $e');
  }
}