import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class PedidosScreen extends StatefulWidget {
  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _platilloController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();

  @override
  void dispose() {
    // Libera los controladores cuando ya no se necesiten
    _nombreController.dispose();
    _platilloController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _addPedido(BuildContext context) {
    if (_nombreController.text.isNotEmpty &&
        _platilloController.text.isNotEmpty &&
        _cantidadController.text.isNotEmpty) {
      _firebaseService.addPedido({
        'cliente': _nombreController.text,
        'platillo': _platilloController.text,
        'cantidad': int.parse(_cantidadController.text),
        'fecha': Timestamp.now(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('pedidos').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      child: ListTile(
                        title: Text('Cliente: ${doc['cliente']}'),
                        subtitle: Text(
                            'Platillo: ${doc['platillo']} - Cantidad: ${doc['cantidad']}'),
                        trailing: Text('Fecha: ${doc['fecha'].toDate()}'),
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
                  controller: _platilloController,
                  label: 'Platillo',
                ),
                CustomTextField(
                  controller: _cantidadController,
                  label: 'Cantidad',
                ),
                CustomButton(
                  text: 'Agregar Pedido',
                  onPressed: () => _addPedido(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
