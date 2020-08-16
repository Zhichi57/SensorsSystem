import 'package:flutter/material.dart';
import 'ChartScreen.dart';
import 'MapScreen.dart';
import 'StatisticScreen.dart';
import 'informationScreen.dart';

class CustomDrawer extends Drawer {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            new DrawerHeader(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text('Система сбора данных'), accountEmail: null,
              ),
            ),
            new ListTile(
              title: Text("Информация"),
              leading: Icon(Icons.info),
              onTap: () {
                  Navigator.of(context).push(_customRoute(InformationScreen()));
              },
            ),
            new ListTile(
              title: Text("График"),
              leading: Icon(Icons.grain),
              onTap: () {
                Navigator.of(context).push(_customRoute(ChartScreen()));
              },
            ),
            new ListTile(
              title: Text("Статистика"),
              leading: Icon(Icons.book),
              onTap: () {
                Navigator.of(context).push(_customRoute(StatisticScreen()));
              },
            ),
            new ListTile(
              title: Text("Карта"),
              leading: Icon(Icons.map),
              onTap: () {
                Navigator.of(context).push(_customRoute(MapScreen()));
              },
            )
          ],
        )
    );
  }

  Route _customRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(100.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}