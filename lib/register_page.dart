import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores para los campos de texto
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  // Almacena el tipo de usuario seleccionado (0, 1 o 2)
  int? selectedUserType;

  // Estado para mostrar el indicador de carga
  bool isLoading = false;

  // Lista de tipos de usuario disponibles
  final List<Map<String, dynamic>> userTypes = [
    {'value': 0, 'label': 'Administrador'},
    {'value': 1, 'label': 'Propietario'},
    {'value': 2, 'label': 'Inquilino'},
  ];

  /// Función para registrar un nuevo usuario en Back4App
  void doUserRegistration() async {
    setState(() => isLoading = true);

    // Recuperar datos del formulario
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();
    final email = controllerEmail.text.trim();

    // Validar que todos los campos estén completos
    if (selectedUserType == null || username.isEmpty || password.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      setState(() => isLoading = false);
      return;
    }

    // Crear un nuevo usuario con los datos ingresados
    final user = ParseUser(username, password, email);

    // Asignar el campo personalizado "type_User"
    user.set<int>('type_User', selectedUserType!);

    // Intentar registrar el usuario en el servidor
    final response = await user.signUp();

    setState(() => isLoading = false);

    // Mostrar mensaje según el resultado
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado con éxito')),
      );
      Navigator.pop(context); // Volver a la pantalla anterior
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ancho máximo del formulario: 50% de la pantalla o mínimo 400 px
    final width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Usuario',style: TextStyle(color:Colors.white),),
        backgroundColor: Color(0xFF000099),// Azul corporativo
         iconTheme: IconThemeData(color: Colors.white) 
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width < 400 ? 400 : width,
            child: Column(
              children: [
                // Campo: Nombre de usuario
                TextField(
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icon(Icons.person, color: Color(0xFF000099)),
                    labelStyle: TextStyle(color: Color(0xFF000099)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo: Correo electrónico
                TextField(
                  controller: controllerEmail,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email, color: Color(0xFF000099)),
                    labelStyle: TextStyle(color: Color(0xFF000099)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo: Contraseña
                TextField(
                  controller: controllerPassword,
                  obscureText: true, // Oculta el texto para mayor seguridad
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF000099)),
                    labelStyle: TextStyle(color: Color(0xFF000099)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Dropdown: Tipo de Usuario
                DropdownButtonFormField<int>(
                  value: selectedUserType,
                  items: userTypes.map((type) {
                    return DropdownMenuItem<int>(
                      value: type['value'],
                      child: Text(type['label']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Tipo de Usuario',
                    labelStyle: TextStyle(color: Color(0xFF000099)),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedUserType = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Botón: Registrar Usuario
                isLoading
                    ? CircularProgressIndicator() // Indicador mientras se espera
                    : ElevatedButton(
                        onPressed: doUserRegistration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000099),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          'Registrar Usuario',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
