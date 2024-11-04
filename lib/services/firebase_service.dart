import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Método para agregar un cliente
  Future<void> addCliente(Map<String, dynamic> clienteData) async {
    await _firestore.collection('clientes').add(clienteData);
  }

  // Método para subir imágenes
  Future<String> uploadImage(String path, String fileName) async {
    Reference ref = _storage.ref().child('menu_images/$fileName');
    await ref.putFile(File(path));
    return await ref.getDownloadURL();
  }

  // Método para obtener los items del menú
  Stream<QuerySnapshot> getMenuItems() {
    return _firestore.collection('menu').snapshots();
  }

  // Método para agregar un pedido
  Future<void> addPedido(Map<String, dynamic> pedidoData) async {
    try {
      await _firestore.collection('pedidos').add(pedidoData);
    } catch (e) {
      print('Error al agregar pedido: $e');
    }
  }

  // Método para agregar una reservación
  Future<void> addReservacion(Map<String, dynamic> reservacionData) async {
    try {
      await _firestore.collection('reservaciones').add(reservacionData);
    } catch (e) {
      print('Error al agregar reservación: $e');
    }
  }
}
