import 'package:flutter/material.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  //Widget da barra superior (AppBar)
  
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
    //Escolha da cor da barra conforme a competição
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
      //Botão de Retroceder
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          //Quando chegar à Home Page, não retrocede mais
          (ModalRoute.of(context)!.settings.name != "/") ? Navigator.of(context).pop() : null;
        },
      ),
      //Texto se for Jogador ou Clube
      title: Text((widget.texto != null) ? widget.texto! : '',),
      //Imagem se for competição ou menus
      flexibleSpace: (widget.texto == null) ? Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./img/${widget.logo}.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ) : null,
    );
  }
}