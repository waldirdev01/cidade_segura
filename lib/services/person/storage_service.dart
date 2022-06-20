import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService with ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> refs = [];
  List<String> arquivos = [];


  deleteImage(String imageURL) async {
    await storage.refFromURL(imageURL).delete();
    arquivos.remove(imageURL);
    //refs.remove(imageURL);
    notifyListeners();
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String fotoEnviada = 'images/${DateTime.now().toString()}.jpg';
      return storage.ref(fotoEnviada).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }
}