import 'package:cidade_segura/models/auth.dart';
import 'package:cidade_segura/models/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context, listen: false);
    final personList = Provider.of<PersonListProvider>(context);
    final auth = Provider.of<Auth>(context, listen: false);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(4, 4, 12, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: GestureDetector(
                          onLongPress: () {
                            showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Theme.of(context).primaryColor,
                                title: const Text('Excluir cadastro?',
                                    style: TextStyle(color: Colors.white)),
                                content: const Text(
                                    'Atenção! Esta ação não poderá ser desfeita'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancelar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18))),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      personList.deletePerson(
                                          person, person.imageUrl);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                        'Cadastro removido',
                                        textAlign: TextAlign.center,
                                      )));
                                    },
                                    child: const Text(
                                      'Excluir',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onTap: () => Navigator.of(context)
                              .pushNamed(kPERSONPERFILPAGE, arguments: person),
                          child: Image.network((person.imageUrl)))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 2),
                        child: Text(
                          person.name,
                          style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
                        child: Text(
                          'apelido: ${person.apelido}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone_android,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              person.cellphone,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          child: Consumer<Person>(
            builder: (context, person, _) => IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: const Text('Homicida',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    content: const Text('Atenção!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            person.toggleAssassin(auth.token ?? '');
                          },
                          child: Text(
                              person.isAssassin
                                  ? 'Excluir dos homicidas.'
                                  : 'Incluir como homicida.',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ],
                  ),
                );
              },
              icon: Icon(
                person.isAssassin
                    ? Icons.account_box
                    : Icons.account_box_outlined,
                color: person.isAssassin ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
