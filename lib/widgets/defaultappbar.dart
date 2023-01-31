import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? logo;
  final String? texto;
  final Color backgroundColor = const Color.fromARGB(255, 12, 0, 62);

  DefaultAppBar({this.logo, this.texto});


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
      case "BWIN_h":
        bckgnd = Colors.black;
        break;
      case "Sabseg_h":
        bckgnd = Colors.blue;
        break;
      case "Allianz_h":
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
          (ModalRoute.of(context)!.settings.name != "/") ? Navigator.of(context).pop() : null;
        },
      ),
      title: Text((widget.texto != null) ? widget.texto! : '',),
      // other properties
      flexibleSpace: (widget.texto == null) ? Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../img/${widget.logo}.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ) : null,
    );
  }
}