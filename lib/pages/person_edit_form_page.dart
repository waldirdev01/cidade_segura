import 'package:cidade_segura/models/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/list_person.dart';
import 'home_page.dart';

class PersonEditFormPage extends StatefulWidget {
  late String id;

  PersonEditFormPage({Key? key, required this.person}) : super(key: key) {
    id = person.id;
  }

  Person person;

  @override
  _PersonEditFormPageState createState() => _PersonEditFormPageState();
}

class _PersonEditFormPageState extends State<PersonEditFormPage> {
  final _nameController = TextEditingController();
  final _apelidoController = TextEditingController();
  final _maeController = TextEditingController();
  final _endercoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _anotacoesController = TextEditingController();
  bool temImagem = false;
  final nomeKey = GlobalKey<FormFieldState>();
  final apelidoKey = GlobalKey<FormFieldState>();
  final telefoneKey = GlobalKey<FormFieldState>();
  final maeKey = GlobalKey<FormFieldState>();
  final anotacoesKey = GlobalKey<FormFieldState>();
  final enderecoKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            'Editar ${widget.person.name}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          trailing: Image.network(widget.person.imageUrl),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.person.imageUrl,
                          fit: BoxFit.cover,
                        )),
                    const Divider(),
                    TextFormField(
                        showCursor: true,
                        cursorColor: Colors.black,
                        textCapitalization: TextCapitalization.words,
                        key: nomeKey,
                        style: const TextStyle(fontSize: 24),
                        initialValue: widget.person.name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Nome do Indivíduo',
                            labelStyle: const TextStyle(fontSize: 24)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o nome';
                          }
                          _nameController.text = value.toString();
                          return null;
                        }),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      key: apelidoKey,
                      initialValue: widget.person.apelido,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: 'Apelido',
                          labelStyle: const TextStyle(fontSize: 24)),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o apelido';
                        }
                        _apelidoController.text = value.toString();
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      key: telefoneKey,
                      initialValue: widget.person.cellphone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: 'Telefone',
                          labelStyle: const TextStyle(fontSize: 24)),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o telefone';
                        }
                        _telefoneController.text = value.toString();
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                        showCursor: true,
                        cursorColor: Colors.black,
                        textCapitalization: TextCapitalization.words,
                        key: maeKey,
                        style: const TextStyle(fontSize: 24),
                        initialValue: widget.person.motherName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Nome da mãe',
                            labelStyle: const TextStyle(fontSize: 24)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o nome da mãe';
                          }
                          _maeController.text = value.toString();
                          return null;
                        }),
                    const Divider(),
                    TextFormField(
                        showCursor: true,
                        cursorColor: Colors.black,
                        textCapitalization: TextCapitalization.words,
                        key: enderecoKey,
                        style: const TextStyle(fontSize: 24),
                        initialValue: widget.person.address,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Endereço',
                            labelStyle: const TextStyle(fontSize: 24)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o endereço';
                          }
                          _endercoController.text = value.toString();
                          return null;
                        }),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      key: anotacoesKey,
                      initialValue: widget.person.anotation,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: 'Anotações',
                          labelStyle: const TextStyle(fontSize: 24)),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira a anotação';
                        }
                        _anotacoesController.text = value.toString();
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nomeKey.currentState?.validate() == true &&
                            apelidoKey.currentState?.validate() == true &&
                            telefoneKey.currentState?.validate() == true &&
                            maeKey.currentState?.validate() == true &&
                            enderecoKey.currentState?.validate() == true &&
                            anotacoesKey.currentState?.validate() == true) {
                          Person newPerson = Person(
                              id: widget.person.id,
                              name: _nameController.text,
                              apelido: _apelidoController.text,
                              motherName: _maeController.text,
                              address: _endercoController.text,
                              anotation: _anotacoesController.text,
                              cellphone: _telefoneController.text,
                              imageUrl: widget.person.imageUrl);
                          provider.updatePerson(newPerson);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        }
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 55),
                        primary: Theme.of(context).colorScheme.secondary,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
