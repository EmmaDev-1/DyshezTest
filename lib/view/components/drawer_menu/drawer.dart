import 'package:flutter/material.dart';
import 'package:dyshez/Utils/dialogs/sign_out_dialog.dart';
import 'package:dyshez/view/components/drawer_menu/drawer_tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          DrawerHeader(
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 60,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          DrawerTile(
            title: "Menú",
            leading: Icon(
              Icons.restaurant_menu_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "Sección habilitada próximamente",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0,
              );
            },
          ),
          DrawerTile(
            title: "Ordenes",
            leading: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerTile(
            title: "Perfil",
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "Sección habilitada próximamente",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0,
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 1,
            color: Color.fromARGB(190, 255, 255, 255),
          ),
          DrawerTile(
            title: "Salir",
            leading: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
            onTap: () {
              SignOutUser(context);
            },
          ),
        ],
      ),
    );
  }
}
