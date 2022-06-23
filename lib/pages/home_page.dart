import 'package:cidade_segura/components/person_list_view_buider.dart';
import 'package:cidade_segura/models/list_person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refresPersonList(BuildContext context) {
    return Provider.of<PersonListProvider>(context, listen: false).loadPerson();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: ()=>_refresPersonList(context),
    child: PersonListViewBuider());
  }
}
