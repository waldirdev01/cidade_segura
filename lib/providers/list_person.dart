import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonListProvider with ChangeNotifier {
  final _baseUrl =
      'https://cidade-segura-8c427-default-rtdb.firebaseio.com/person';
  final List<Person> _personList = [];

  List<Person> get personList => [..._personList];

  List<Person> get assassins =>
      _personList.where((person) => person.isAssassin).toList();

  Future<void> personFromMap(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final person = Person(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      apelido: data['apelido'] as String,
      motherName: data['motherName'] as String,
      address: data['address'] as String,
      anotation: data['anotation'] as String,
      cellphone: data['cellPhone'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updatePerson(person);
    } else {
      return addPerson(person);
    }
  }

  Future<void> loadPerson() async {
    _personList.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((personId, personData) {
      _personList.add(
        Person(
            id: personId,
            name: personData['name'],
            apelido: personData['apelido'],
            imageUrl: personData['imageUrl'],
            motherName: personData['motherName'],
            isAssassin: personData['isAssassin'],
            anotation: personData['anotation'],
            address: personData['address'],
            cellphone: personData['cellphone']),
      );
    });
    notifyListeners();
  }

  Future<void> addPerson(Person person) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode(person.toJson()),
    );
    final id = jsonDecode(response.body)['name'];
    _personList.add(Person(
        id: id,
        name: person.name,
        apelido: person.apelido,
        motherName: person.motherName,
        address: person.address,
        anotation: person.anotation,
        cellphone: person.cellphone,
        imageUrl: person.imageUrl));
    notifyListeners();
  }

  Future<void> updatePerson(Person person) async {
    int index = _personList.indexWhere((element) => element.id == person.id);
    if (index >= 0) {
      final response =
          await http.patch(Uri.parse('$_baseUrl/${person.id}.json'),
              body: jsonEncode({
                'name': person.name,
                'apelido': person.apelido,
                'motherName': person.motherName,
                'address': person.address,
                'anotation': person.anotation,
                'cellphone': person.cellphone
              }));
      _personList[index] = person;
      notifyListeners();
    }
  }

  void deletePerson(Person person) {
    _personList.remove(person);
    notifyListeners();
  }
}
