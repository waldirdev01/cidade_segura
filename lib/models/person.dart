import 'dart:convert';

import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Person with ChangeNotifier {
  String id, name, apelido, motherName, address, anotation, cellphone, imageUrl;
  bool isAssassin;
  final _baseUrl =
      'https://cidade-segura-8c427-default-rtdb.firebaseio.com/person';
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

  Map<String, Object> toJson() {
    return {
      kName: name,
      kApelido: apelido,
      kMotherName: motherName,
      kAddress: address,
      kAnotation: anotation,
      kCellphone: cellphone,
      kImageUrl: imageUrl,
      kIsAssassin: false,
    };
  }

  void _toggleIsAssassin() {
    isAssassin = !isAssassin;
    notifyListeners();
  }
  Future<void> toggleAssassin(String token) async {
    try {
      _toggleIsAssassin();
      final response = await http.patch(Uri.parse('$_baseUrl/$id.json?auth=$token'),
          body: jsonEncode({
            kIsAssassin: isAssassin,
          }));
      if (response.statusCode >= 400) {
        _toggleIsAssassin();
      }
    } catch (_) {
     _toggleIsAssassin();
    }
  }
}
