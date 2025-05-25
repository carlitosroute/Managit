import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'widgets/campo_texto.dart';

class RegisterPersonaPage extends StatefulWidget {
  @override
  _RegisterPersonaPageState createState() => _RegisterPersonaPageState();
}

class _RegisterPersonaPageState extends State<RegisterPersonaPage> {
  // Controladores para los campos
  final controllerNombre = TextEditingController();
  final controllerApellido = TextEditingController();
  final controllerDni = TextEditingController();
  final controllerTipo = TextEditingController();
  final controllerTelefono = TextEditingController();
  final controllerCorreo = TextEditingController();

  bool isLoading = false;

  /// Función para registrar la persona en Back4App
  void registrarPersona() async {
    setState(() => isLoading = true);

    if (controllerNombre.text.isEmpty ||
        controllerApellido.text.isEmpty ||
        controllerDni.text.isEmpty ||
        controllerTipo.text.isEmpty ||
        controllerTelefono.text.isEmpty ||
        controllerCorreo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      setState(() => isLoading = false);
      return;
    }

    final persona = ParseObject('Persona')
      ..set('Nombre', controllerNombre.text.trim())
      ..set('Apellido', controllerApellido.text.trim())
      ..set('Dni', controllerDni.text.trim())
      ..set('Tipo', controllerTipo.text.trim())
      ..set('Telefono', controllerTelefono.text.trim())
      ..set('Correo', controllerCorreo.text.trim());

    final response = await persona.save();

    setState(() => isLoading = false);

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Persona registrada con éxito')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Persona', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF000099),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width < 400 ? 400 : width,
            child: Column(
              children: [
                campoTexto('Nombre', controllerNombre, Icons.person),
                campoTexto('Apellido', controllerApellido, Icons.person_outline),
                campoTexto('DNI', controllerDni, Icons.badge),
                campoTexto('Tipo', controllerTipo, Icons.category),
                campoTexto('Teléfono', controllerTelefono, Icons.phone),
                campoTexto('Correo', controllerCorreo, Icons.email),
                const SizedBox(height: 24),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: registrarPersona,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000099),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: Text('Registrar Persona', style: TextStyle(color: Colors.white)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
