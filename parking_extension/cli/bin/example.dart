import '../../shared/lib/src/models/vehicle.dart';
import '../lib/repositories/vehicle_repository.dart';

void main() async {
  VehicleRepository repository = VehicleRepository();

  repository.create(Vehicle('Vehicle 1'));
  repository.create(Vehicle('Vehicle 2'));
  repository.create(Vehicle('Vehicle 3'));

  // Get all vehicles
  List<Vehicle> allVehicles = await repository.getAll();
  print('All vehicles:');
  allVehicles.forEach((vehicle) => print(vehicle.description));

  // Get vehicle by index
  Vehicle? vehicle = allVehicles.elementAt(0);
  print('\nVehicle at index 0: ${vehicle?.description}');

  Vehicle? vehicle2 = allVehicles.elementAt(1);

  // Update an vehicle
  Vehicle updatedVehicle = Vehicle('Updated Vehicle 2', vehicle2.id);
  repository.update(updatedVehicle.id, updatedVehicle);

  allVehicles = await repository.getAll();

  print('\nUpdated vehicle at index 1: ${allVehicles.elementAt(1).description}');

  Vehicle? vehicle3 = allVehicles.elementAt(2);

  // Delete an vehicle
  repository.delete(vehicle3.id);
  print('\nAll vehicles after deleting vehicle at index 2:');
  allVehicles = await repository.getAll();
  allVehicles.forEach((vehicle) => print(vehicle.description));
}
