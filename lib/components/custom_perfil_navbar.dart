import 'package:cidade_segura/models/person.dart';
import 'package:cidade_segura/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomPerfilNavBar extends StatefulWidget {
  final Person? person;

  const CustomPerfilNavBar({
    Key? key,
    this.person,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomPerfilNavBarState createState() => _CustomPerfilNavBarState();
}

class _CustomPerfilNavBarState extends State<CustomPerfilNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.secondary,
      notchMargin: 6,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushReplacementNamed(
                          kPERSONPERFILPAGE,
                          arguments: widget.person);
                    });
                  },
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.person, color: Colors.white),
                      Text(
                        'Perfil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
