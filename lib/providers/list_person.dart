import 'dart:math';

import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonListProvider with ChangeNotifier {
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
          'http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png',
    );
    if (hasId) {
      updatePerson(person);
    } else {
      _personList.add(person);
      notifyListeners();
    }
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
