import 'package:server/models/person_entity.dart';
import 'package:server/repositories/file_repository.dart';

class PersonRepository extends FileRepository<PersonEntity> {
  PersonRepository() : super('bags.json');

  @override
  PersonEntity fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return PersonEntity.fromJson(json);
  }

  @override
  String idFromType(PersonEntity person) {
    // TODO: implement idFromType
    return person.id;
  }

  @override
  Map<String, dynamic> toJson(PersonEntity person) {
    // TODO: implement toJson
    return person.toJson();
  }
}
