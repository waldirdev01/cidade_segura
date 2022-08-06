import 'package:cidade_segura/components/custom_page.dart';
import 'package:cidade_segura/components/person_card.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/list_person.dart';

class PersonListViewBuider extends StatefulWidget {
  PersonListViewBuider({Key? key, this.showAssassinOnly}) : super(key: key);
  bool? showAssassinOnly;

  @override
  State<PersonListViewBuider> createState() => _PersonListViewBuiderState();
}

class _PersonListViewBuiderState extends State<PersonListViewBuider> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<PersonListProvider>(context, listen: false)
        .loadPerson()
        .then((value) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonListProvider>(context);
    final loadedPerson = widget.showAssassinOnly == true
        ? provider.assassins
        : provider.personList;
    return CustomPage(
      body: provider.personList.isEmpty
          ? SingleChildScrollView(
        child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const Text('Não há cadastros ainda.', style: TextStyle(fontSize: 24),),
                  ],
                ),
              ),
          )
          : Column(
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
          Navigator.of(context).pushNamed(kGETIMAGE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
