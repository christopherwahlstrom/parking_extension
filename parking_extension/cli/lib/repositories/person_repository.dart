import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared/shared.dart';


class PersonRepository implements RepositoryInterface<Person> {

  @override
  Future<Person> getById(String id) async {
    final uri = Uri.parse("http://localhost:8080/perons/${id}");

    Response response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<Person> create(Person person) async {
    // send person serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/persons");

    Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<List<Person>> getAll() async {
    final uri = Uri.parse("http://localhost:8080/persons");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return (json as List).map((person) => Person.fromJson(person)).toList();
  }

  @override
  Future<Person> delete(String id) async {
    final uri = Uri.parse("http://localhost:8080/persons/${id}");

    Response response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<Person> update(String id, Person person) async {
    // send person serialized as json over http to server at localhost:8080
    final uri = Uri.parse("http://localhost:8080/persons/${id}");

    Response response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }
}
