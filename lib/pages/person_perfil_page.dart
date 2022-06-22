import 'package:cidade_segura/components/custom_page.dart';
import 'package:cidade_segura/components/person_info_card_detail.dart';
import 'package:cidade_segura/models/person.dart';
import 'package:cidade_segura/pages/person_edit_form_page.dart';
import 'package:flutter/material.dart';

class PersonPerfilPage extends StatefulWidget {
  const PersonPerfilPage({Key? key}) : super(key: key);

  @override
  State<PersonPerfilPage> createState() => _PersonPerfilPageState();
}

class _PersonPerfilPageState extends State<PersonPerfilPage> {
  @override
  Widget build(BuildContext context) {
    final Person person = ModalRoute.of(context)!.settings.arguments as Person;
    return CustomPage(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          person.imageUrl,
                          fit: BoxFit.contain,
                        )),
                    const Divider(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: PersonInfoCardDetail(
                        person: person,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Anotações : ${person.anotation}',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PersonEditFormPage(person: person)));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
