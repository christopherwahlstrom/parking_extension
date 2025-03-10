import 'dart:io';

import 'package:server/handlers/person_handlers.dart';
import 'package:server/handlers/vehicle_handlers.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerConfig {
  ServerConfig._privateConstructor() {
    initialize();
  }

  static final ServerConfig _instance = ServerConfig._privateConstructor();

  static ServerConfig get instance => _instance;

  late Router router;

  Future initialize() async {
    router = Router();

    // Person routes
    router.post('/persons', postPersonHandler); // create a person
    router.get('/persons', getPersonsHandler); // get all persons
    router.get('/persons/<id>', getPersonHandler); // get specific person
    router.put('/persons/<id>', updatePersonHandler); // update specific person
    router.delete('/persons/<id>', deletePersonHandler); // delete specific person

    // Vehicle routes
    router.post('/vehicles', postVehicleHandler); // create a vehicle
    router.get('/vehicles', getVehiclesHandler); // get all vehicles
    router.get('/vehicles/<id>', getVehicleHandler); // get specific vehicle
    router.put('/vehicles/<id>', updateVehicleHandler); // update specific vehicle
    router.delete('/vehicles/<id>', deleteVehicleHandler); // delete specific vehicle

    // ParkingSpace routes
    // router.post('/parkingspaces', postParkingSpaceHandler);
    // router.get('/parkingspaces', getParkingSpacesHandler);
    // router.get('/parkingspaces/<id>'getParkingSpaceByIdHandler);
    // router.put('/parkingspaces/<id>', updateParkingSpaceHandler);
    // router.delete('/parkingspaces/<id>', deleteParkingSpaceHandler);

    // Parking routes
    // router.post('/parkings', postParkingHandler);
    // router.get('/parkings', getParkingsHandler);
    // router.get('/parkings/<id>', getParkingByIdHandler);
    // router.put('/parkings/<id>', updateParkingHandler);
    // router.delete('/parkings/<id>', deleteParkingHandler);
  }
}