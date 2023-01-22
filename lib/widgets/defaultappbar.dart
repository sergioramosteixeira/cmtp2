import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String logo;
  final Color backgroundColor = const Color.fromARGB(255, 12, 0, 62);

  DefaultAppBar({required this.logo});


  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    Color bckgnd;
    switch (widget.logo) {
      case "bwin_h":
        bckgnd = Colors.black;
        break;
      case "sabseg_h":
        bckgnd = Colors.blue;
        break;
      case "allianz_h":
        bckgnd = Colors.deepPurple;
        break;
      default:
        bckgnd = widget.backgroundColor;
    }
    return AppBar(
      backgroundColor: bckgnd,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(MainMenu.routeName, (Route<dynamic> route) => false);
        },
      ),
      // other properties
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../img/${widget.logo}.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}