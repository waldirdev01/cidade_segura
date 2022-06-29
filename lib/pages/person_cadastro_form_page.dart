import 'package:cidade_segura/models/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class PersonCadastroFormPage extends StatefulWidget {
  const PersonCadastroFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonCadastroFormPage> createState() => _PersonCadastroFormPageState();
}

class _PersonCadastroFormPageState extends State<PersonCadastroFormPage> {
  bool isImage = false;
  bool hasPerson = false;
  late XFile imagePick;
  ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

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
    final imagemBaixada = ModalRoute.of(context)?.settings.arguments as String;

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
              Column(
                children: [
                  SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.network(imagemBaixada)),
                ],
              ),
              const Divider(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Nome',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
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
                      onSaved: (name) {
                        _formData[kName] = name ?? '';
                        _formData['imageUrl'] = imagemBaixada;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Apelido',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (apelido) =>
                          _formData[kApelido] = apelido ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Telefone',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (cellPhone) =>
                          _formData[kCellphone] = cellPhone ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Nome da mãe',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (motherName) =>
                          _formData[kMotherName] = motherName ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Endereço',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (address) =>
                          _formData[kAddress] = address ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Anotações',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      onSaved: (anotation) =>
                          _formData[kAnotation] = anotation ?? '',
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
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 55),
                        primary: Theme.of(context).colorScheme.secondary,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
