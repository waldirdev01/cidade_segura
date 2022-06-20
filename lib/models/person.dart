import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  String id, name, apelido, motherName, address, anotation, cellphone, imageUrl;
  bool isAssassin;

  Person({
    required this.id,
    required this.name,
    required this.apelido,
    required this.motherName,
    required this.address,
    required this.anotation,
    required this.cellphone,
    required this.imageUrl,
    this.isAssassin = false,
  });

  void assasin() {
    isAssassin = true;
    notifyListeners();
  }

  void isNotassasin() {
    isAssassin = false;
    notifyListeners();
  }
}
