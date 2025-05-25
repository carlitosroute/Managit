import 'package:flutter/material.dart';
import 'drawer.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Control'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('¡Bienvenido al sistema de gestión de alquileres!'),
      ),
    );
  }
}
