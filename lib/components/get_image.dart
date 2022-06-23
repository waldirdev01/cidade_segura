import 'dart:io';

import 'package:cidade_segura/models/person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/storage_service.dart';

class GetImage extends StatefulWidget {
  const GetImage({Key? key}) : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  StorageService storageService = StorageService();
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;
  Person? person;
  late UploadTask task;
  late XFile? imagePick;
  late String imagemBaixada;

  //PessoaService pessoaService = PessoaService();
  ImagePicker picker = ImagePicker();
  bool temImagem = false;
  final nomeKey = GlobalKey<FormFieldState>();
  final apelidoKey = GlobalKey<FormFieldState>();
  bool uploading = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Foto'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              InkWell(
                onTap: () => _exibirDialog(context),
                child: uploading
                    ? SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator(),
                            ),
                            const Divider(),
                            Text(
                              '${total.round()}% enviado',
                              style: const TextStyle(fontSize: 24),
                            )
                          ],
                        ))
                    : SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: temImagem
                            ? Image.file(File(imagePick!.path))
                            : Image.asset(
                                'assets/images/avatar.png',
                                fit: BoxFit.cover,
                              ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  ElevatedButton(
                    onPressed: uploading ? null : () {
                      pickAndUploadImage();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 55),
                      primary: Theme.of(context).colorScheme.secondary,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      temImagem ? 'Subir imagem' : 'Click na imagem acima',
                      style: const TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickAndUploadImage() async {
    XFile? file = imagePick;
    if (file != null) {
      UploadTask task = await storageService.upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          arquivos.add(await snapshot.ref.getDownloadURL());
          imagemBaixada = arquivos.last;

          refs.add(snapshot.ref);
          setState(() => uploading = false);
          Navigator.of(context)
              .pushReplacementNamed(kPERSONCADFORM, arguments: imagemBaixada);
          /*Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => FormCadastroPessoaPage(urlImage: imagemBaixada)));*/
        }
      });
    }
  }

  Future<XFile?> getImage(String fonteDaImagem) async {
    XFile? file = await picker.pickImage(
        source: fonteDaImagem == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 60);

    imagePick = XFile(file!.path);
    try {
      temImagem = true;
      setState(() {});
      return imagePick;
    } catch (e) {
      showDialog(context: context, builder: (context) => Text(e.toString()));
    }
    return imagePick;
  }

  _exibirDialog(
    BuildContext context,
  ) {
    AlertDialog alertDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'Escolha a fonte da imagem',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              getImage('camera');
              Navigator.pop(context);
            },
            child: Column(
              children: const [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                Text(
                  'câmera',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            )),
        const SizedBox(
          width: 100,
        ),
        TextButton(
            onPressed: () {
              getImage('gallery');
              Navigator.pop(context);
            },
            child: Column(
              children: const [
                Icon(
                  Icons.photo_album,
                  color: Colors.white,
                ),
                Text('galeria',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            )),
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
