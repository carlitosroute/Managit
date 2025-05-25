import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int? userType;

  @override
  void initState() {
    super.initState();
    loadUserType();
  }

  /// Cargar el tipo de usuario desde Back4App
  Future<void> loadUserType() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      final type = currentUser.get<int>('type_User');
      setState(() {
        userType = type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mientras carga, muestra indicador
    if (userType == null) {
      return Drawer(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // Define las opciones del menú según el tipo de usuario esto es un ajemplo hay que adaptarlo 
    List<Widget> getMenuItems() {
      switch (userType) {
        case 0: // Administrador
          return [
            drawerItem('Dashboard', Icons.dashboard),
drawerItem(
  'Registrar Usuarios',
  Icons.person_add,
  onTap: () {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/register');
  },
),
drawerItem('Registrar Persona', Icons.person_add, onTap: () {
  Navigator.pop(context);
  Navigator.pushNamed(context, '/registerPersona');
}),
            drawerItem('Registrar Empresa', Icons.apartment, onTap: () {
  Navigator.pop(context);
  Navigator.pushNamed(context, '/registerEmpresa');
}),
            drawerItem('Gestionar Contratos', Icons.assignment),
            drawerItem('Registrar Grupo', Icons.add_business_rounded),
            drawerItem('Mis Propiedades', Icons.home),
            drawerItem('Ingresos Mensuales', Icons.attach_money),
            drawerItem('Mis Contratos', Icons.assignment),
            drawerItem('Pagos Pendientes', Icons.payment),
            drawerItem('Salir', Icons.logout, onTap: () => logout(context)),

          ];
        case 1: // Propietario
          return [
            drawerItem('Mis Propiedades', Icons.home),
            drawerItem('Ingresos Mensuales', Icons.attach_money),
            drawerItem('Salir', Icons.logout, onTap: () => logout(context)),
          ];
        case 2: // Inquilino
          return [
            drawerItem('Mis Contratos', Icons.assignment),
            drawerItem('Pagos Pendientes', Icons.payment),
            drawerItem('Salir', Icons.logout, onTap: () => logout(context)),
          ];
        default:
          return [
            drawerItem('Salir', Icons.logout, onTap: () => logout(context)),
          ];
      }
    }

    return Drawer(
      child: Center(
        child: ListView(
          shrinkWrap: true, // <- centra verticalmente
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: getMenuItems(),
        ),
      ),
    );
  }

  // Método para crear cada ítem del drawer
  Widget drawerItem(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF000099)),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF000099), fontWeight: FontWeight.bold),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context); // cierra el drawer
      },
    );
  }

  // Función para cerrar sesión
  void logout(BuildContext context) async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      await user.logout();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
