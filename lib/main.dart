import 'package:cidade_segura/components/get_image.dart';
import 'package:cidade_segura/models/auth.dart';
import 'package:cidade_segura/pages/auth_or_home_page.dart';
import 'package:cidade_segura/pages/person_cadastro_form_page.dart';
import 'package:cidade_segura/pages/person_perfil_page.dart';
import 'package:cidade_segura/models/list_person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, PersonListProvider>(
            create: (context) => PersonListProvider('', []),
            update: (context, auth, previous) {
              return PersonListProvider(
                  auth.token ?? '', previous?.personList ?? []);
            }),
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
          kAUTH_OR_HOME: (context) => const AuthOrHomePage(),
          kPERSONPERFILPAGE: (context) => const PersonPerfilPage(),
          kPERSONCADFORM: (context) => const PersonCadastroFormPage(),
          kGETIMAGE: (context) => const GetImage(),
        },
      ),
    );
  }
}
