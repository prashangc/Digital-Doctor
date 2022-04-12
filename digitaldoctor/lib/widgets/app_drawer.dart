import '../BottomNavigations/Favourites.dart';
import '../screens/HomeScreen.dart';
import '../screens/LoginAndSignUp_screen.dart';
import '../BottomNavigations/Profile.dart';
import '../BottomNavigations/AllAppointments.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AppDrawer extends StatefulWidget {
  // _logoutnow() {
  //   storage.clear();
  // }

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.red,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 48.0),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Favourites',
              icon: Icons.favorite_border,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Appointments',
              icon: Icons.local_hospital,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'People',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 5),
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text,
          style: const TextStyle(
            color: color,
          )),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Profile()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Favourite()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AllAppointments()));
        break;
      case 4:
        _logoutnow();
        Navigator.of(context)
            .pushReplacementNamed(LoginAndSignUpScreen.routeName);
        break;
      case 5:
        _logoutnow();
        Navigator.of(context)
            .pushReplacementNamed(LoginAndSignUpScreen.routeName);
        break;
    }
  }

  void _logoutnow() {
    LocalStorage storage = LocalStorage("usertoken");
    storage.clear();
  }
}
