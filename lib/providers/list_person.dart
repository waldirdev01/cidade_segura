import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonListProvider with ChangeNotifier {
  final _baseUrl = 'https://cidade-segura-8c427-default-rtdb.firebaseio.com/';
  bool showAssassinOnly = false;
  final List<Person> _personList = kItems;

  List<Person> get personList {
    if (showAssassinOnly) {
      return _personList.where((person) => person.isAssassin).toList();
    } else {
      return [..._personList];
    }
  }

  void showAssassinOnlyFunction() {
    showAssassinOnly = true;
  }

  void showAll() {
    showAssassinOnly = false;
  }

  void personFromMap(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final person = Person(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      apelido: data['apelido'] as String,
      motherName: data['motherName'] as String,
      address: data['address'] as String,
      anotation: data['anotation'] as String,
      cellphone: data['cellPhone'] as String,
      imageUrl:
          data['imageUrl'] as String,
    );
    if (hasId) {
      updatePerson(person);
    } else {
      addPerson(person);
      notifyListeners();
    }
  }

  void addPerson(Person person) {
    final future = http.post(
      Uri.parse('$_baseUrl/person.json'),
      body: jsonEncode(person.toJson()),
    );
    future.then((response) {
      //print(response.body); usei para obter o name (id) do realtime
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
    });

  }

  void updatePerson(Person person) {
    int index = _personList.indexWhere((element) => element.id == person.id);
    if (index >= 0) {
      _personList[index] = person;
      notifyListeners();
    }
  }

  void deletePerson(Person person) {
    _personList.remove(person);
    notifyListeners();
  }
}
