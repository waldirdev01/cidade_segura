import 'package:cidade_segura/pages/home_page.dart';
import 'package:cidade_segura/pages/person_cadastro_form_page.dart';
import 'package:cidade_segura/pages/person_perfil_page.dart';
import 'package:cidade_segura/providers/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PersonListProvider()),
       /* ChangeNotifierProvider(
            create: (context) => Person(
                id: 'id',
                name: 'name',
                apelido: 'apelido',
                motherName: 'motherName',
                address: 'address',
                anotation: 'anotation',
                cellphone: 'cellphone',
                imageUrl: 'imageUrl')),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme.copyWith(
          primaryColor: const Color(0x00ff0000),
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.white38,
            secondary: const Color(0XFE1b1b2b),
          ),
        ),
        routes: {
          kHOME: (context) => const HomePage(),
          kPERSONPERFILPAGE: (context) => const PersonPerfilPage(),
          kPERSONCADFORM: (context) => const PersonCadastroFormPage(),
        },
      ),
    );
  }
}
