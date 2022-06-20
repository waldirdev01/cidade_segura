import 'package:cidade_segura/utils/constants.dart';
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

  Map<String, Object> toJson() {
    return {
      kName: name,
      kApelido: apelido,
      kMotherName: motherName,
      kAddress: address,
      kAnotation: anotation,
      kCellphone: cellphone,
      kImageUrl:
          'http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png',
      kIsAssassin: false,
    };
  }

  void assasin() {
    isAssassin = true;
    notifyListeners();
  }

  void isNotassasin() {
    isAssassin = false;
    notifyListeners();
  }
}
