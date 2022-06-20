import 'dart:io';
import 'dart:math';

import 'package:cidade_segura/providers/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

class PersonCadastroFormPage extends StatefulWidget {
  const PersonCadastroFormPage({Key? key}) : super(key: key);

  @override
  State<PersonCadastroFormPage> createState() => _PersonCadastroFormPageState();
}

class _PersonCadastroFormPageState extends State<PersonCadastroFormPage> {
  bool isImage = false;
  bool hasPerson = false;
  late XFile imagePick;
  ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;
      if (argument != null) {
        isImage = true;
        hasPerson = true;
        final person = argument as Person;
        _formData['id'] = person.id;
        _formData['name'] = person.name;
        _formData['apelido'] = person.apelido;
        _formData['motherName'] = person.motherName;
        _formData['address'] = person.address;
        _formData['anotation'] = person.anotation;
        _formData['cellPhone'] = person.cellphone;
        _formData['urlImage'] = person.imageUrl;
      }
    }
  }

  void _submitForm() {
    final _isValid = _formKey.currentState?.validate() ?? false;
    if (!_isValid) {
      return;
    }
    _formKey.currentState?.save();
    Provider.of<PersonListProvider>(context, listen: false)
        .personFromMap(_formData);
    Navigator.of(context).pop();
    update();
  }

  update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Pessoa'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              hasPerson
                  ? Column(
                      children: [
                        SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: InkWell(
                              onTap: () => _exibirDialog(context),
                              child: Image.network(
                                  _formData['urlImage'].toString()),
                            )),
                        Text('Click na imagem se quiser alterar a foto.')
                      ],
                    )
                  : SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: InkWell(
                        onTap: () => _exibirDialog(context),
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.scaleDown,
                        ),
                      )),
              const Divider(),
              isImage
                  ? Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: _formData['name']?.toString(),
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(fontSize: 24),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.red),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Nome',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (_name) {
                              final name = _name ?? '';
                              if (name.trim().isEmpty) {
                                return 'Nome é obrigatório';
                              }
                              if (name.trim().length < 3) {
                                return 'O nome precisa ter no mínimo 3 letras.';
                              }
                              return null;
                            },
                            onSaved: (name) => _formData['name'] = name ?? '',
                          ),
                          const Divider(),
                          TextFormField(
                            initialValue: _formData['apelido']?.toString(),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Apelido',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (apelido) =>
                                _formData['apelido'] = apelido ?? '',
                          ),
                          const Divider(),
                          TextFormField(
                            initialValue: _formData['cellPhone']?.toString(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Telefone',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (cellPhone) =>
                                _formData['cellPhone'] = cellPhone ?? '',
                          ),
                          const Divider(),
                          TextFormField(
                            initialValue: _formData['motherName']?.toString(),
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Nome da mãe',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (motherName) =>
                                _formData['motherName'] = motherName ?? '',
                          ),
                          const Divider(),
                          TextFormField(
                            initialValue: _formData['address']?.toString(),
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Endereço',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (address) =>
                                _formData['address'] = address ?? '',
                          ),
                          const Divider(),
                          TextFormField(
                            initialValue: _formData['anotation']?.toString(),
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: 'Anotações',
                              labelStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            onSaved: (anotation) =>
                                _formData['anotation'] = anotation ?? '',
                            onFieldSubmitted: (_) {
                              final _isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (!_isValid) {
                                return;
                              }
                              _formKey.currentState?.save();

                              provider.personFromMap(_formData);
                              Navigator.of(context).pop();
                            },
                          ),
                          const Divider(),
                          !hasPerson
                              ? ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 55),
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 55),
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Text('Atualizar',
                                      style: TextStyle(fontSize: 24))),
                        ],
                      ),
                    )
                  : const Text('Click na imagem para cadastrar a foto'),
            ],
          ),
        ),
      ),
    );
  }

  Future<XFile?> getImage(String fonteDaImagem) async {
    XFile? file = await picker.pickImage(
        source: fonteDaImagem == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 60);

    imagePick = XFile(file!.path);
    try {
      isImage = true;
      setState(() {});
      return imagePick;
    } catch (e) {}

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
