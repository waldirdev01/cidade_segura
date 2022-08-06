import 'package:cidade_segura/models/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonInfoCardDetail extends StatelessWidget {
  const PersonInfoCardDetail({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;

  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider(
        create: (context) => Person(
            id: person.id,
            name: person.name,
            apelido: person.apelido,
            motherName: person.motherName,
            address: person.address,
            anotation: person.anotation,
            cellphone: person.cellphone,
            imageUrl: person.imageUrl));
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 4,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black54, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 2, color: Colors.white))),
                child: Icon(
                  Icons.person_pin_outlined,
                  color: person.isAssassin ? Colors.red : Colors.grey,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'nome: ${person.name}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'apelido: ${person.apelido}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mãe: ${person.motherName}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'telefone: ${person.cellphone}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'endereço: ${person.address}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
