import 'package:cidade_segura/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import 'auth_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              return auth.isAuth ? const HomePage() : AuthPage();
          }
          return const Center(
            child: Text('Erro inesperado'),
          );
        });
  }
}
