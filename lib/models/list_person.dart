import 'dart:convert';
import 'package:cidade_segura/exceptions/http_exception.dart';
import 'dart:math';
import 'package:cidade_segura/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';

import 'person.dart';

class PersonListProvider with ChangeNotifier {
  final String _token;
  StorageService service = StorageService();
  final _baseUrl =

      'https://cidade-segura-4453d-default-rtdb.firebaseio.com/person';
  List<Person> _personList = [];

  List<Person> get personList => [..._personList];

  List<Person> get assassins =>
      _personList.where((person) => person.isAssassin).toList();

  PersonListProvider(this._token, this._personList);

  Future<void> personFromMap(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final person = Person(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data[kName] as String,
      apelido: data[kApelido] as String,
      motherName: data[kMotherName] as String,
      address: data[kAddress] as String,
      anotation: data[kAnotation] as String,
      cellphone: data[kCellphone] as String,
      imageUrl: data[kImageUrl] as String,
    );
    if (hasId) {
      return updatePerson(person);
    } else {
      return addPerson(person);
    }
  }

  Future<void> loadPerson() async {
    _personList.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json?auth=$_token'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((personId, personData) {
      _personList.add(
        Person(
            id: personId,
            name: personData[kName],
            apelido: personData[kApelido],
            imageUrl: personData[kImageUrl],
            motherName: personData[kMotherName],
            isAssassin: personData[kIsAssassin],
            anotation: personData[kAnotation],
            address: personData[kAddress],
            cellphone: personData[kCellphone]),
      );
      _personList.sort(
          (person1, person2) => person1.name.compareTo(person2.name));
    });
    notifyListeners();
  }

  Future<void> addPerson(Person person) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json?auth=$_token'),
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
          await http.patch(Uri.parse('$_baseUrl/${person.id}.json?auth=$_token'),
              body: jsonEncode({
                kName: person.name,
                kApelido: person.apelido,
                kMotherName: person.motherName,
                kAddress: person.address,
                kAnotation: person.anotation,
                kCellphone: person.cellphone
              }));
      _personList[index] = person;
      notifyListeners();
    }
  }

  Future<void> deletePerson(Person person, String imageURL) async {
    //exclui o cadastro no aparelho, tenta excluir no firebase e se der erro inclui o cadastro de volta na lista local
    int index = _personList.indexWhere((element) => element.id == person.id);
    if (index >= 0) {
      final person = _personList[index];
      _personList.remove(person);
      service.deleteImage(imageURL);
      notifyListeners();
      final response =
          await http.delete(Uri.parse('$_baseUrl/${person.id}.json?auth=$_token'));
      if (response.statusCode >= 400) {
        _personList.insert(index, person);
        notifyListeners();
        throw HttpException(
            msg: 'Não foi possível excluir o cadastro. Tente mais tarde',
            statusCode: response.statusCode);
      }
      _personList.removeWhere((element) => element.id == person.id);
      notifyListeners();
    }
  }
}
