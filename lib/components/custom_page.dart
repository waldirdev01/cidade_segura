import 'package:cidade_segura/components/person_list_view_buider.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  }) : super(key: key);
  final Widget? body;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white)),
                  leading: const Text('Home',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PersonListViewBuider(
                              showAssassinOnly: false,
                            )));
                  },
                ),
                const Divider(),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white)),
                  leading: const Text('Homicidas',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PersonListViewBuider(
                              showAssassinOnly: true,
                            )));
                  },
                ),
                const Divider(),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white)),
                  leading: const Text('Chat',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: const Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(kCHATPAGE);
                  },
                ),
                const Divider(),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white)),
                  leading: const Text('Sair',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout();
                    Navigator.of(context).pushReplacementNamed(kAUTH_OR_HOME);
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,

          leadingWidth: 22,
          title: SizedBox(
              height: 60,
              width: 100,
              child: Image.asset('assets/images/logo.png')),
        ),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: bottomNavigationBar);
  }
}
