import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class ClienteFormScreen extends StatefulWidget {
  @override
  _ClienteFormScreenState createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _firebaseService.addCliente({
        'nombre': _nombreController.text,
        'telefono': _telefonoController.text,
        'email': _emailController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _nombreController,
                label: 'Nombre',
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              CustomTextField(
                controller: _telefonoController,
                label: 'Teléfono',
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un teléfono' : null,
              ),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un email' : null,
              ),
              SizedBox(height: 20),
              CustomButton(text: 'Guardar Cliente', onPressed: _submitForm),
            ],
          ),
        ),
      ),
    );
  }
}
