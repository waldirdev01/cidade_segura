import 'package:cidade_segura/components/custom_page.dart';
import 'package:cidade_segura/components/person_card.dart';
import 'package:cidade_segura/providers/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

enum FilterOptions { all, assassin }

class PersonListViewBuider extends StatelessWidget {
  const PersonListViewBuider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonListProvider>(context);
    final List<Person> loadedPerson = provider.personList;
    return CustomPage(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: loadedPerson.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: loadedPerson[index],
                    child: const PersonCard(),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Novo cadastro',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.of(context).pushNamed(kPERSONCADFORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
