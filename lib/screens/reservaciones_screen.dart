import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class ReservacionesScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _personasController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  void _addReservacion(BuildContext context) {
    if (_nombreController.text.isNotEmpty &&
        _personasController.text.isNotEmpty &&
        _fechaController.text.isNotEmpty) {
      _firebaseService.addReservacion({
        'nombre': _nombreController.text,
        'personas': int.parse(_personasController.text),
        'fecha': _fechaController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservaciones')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('reservaciones')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      child: ListTile(
                        title: Text('Cliente: ${doc['nombre']}'),
                        subtitle: Text(
                            'Personas: ${doc['personas']} - Fecha: ${doc['fecha']}'),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nombreController,
                  label: 'Nombre del Cliente',
                ),
                CustomTextField(
                  controller: _personasController,
                  label: 'Número de Personas',
                ),
                CustomTextField(
                  controller: _fechaController,
                  label: 'Fecha de Reservación (DD/MM/YYYY)',
                ),
                CustomButton(
                  text: 'Agregar Reservación',
                  onPressed: () => _addReservacion(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
