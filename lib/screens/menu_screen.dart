import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class MenuScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú')),
      body: StreamBuilder(
        stream: _firebaseService.getMenuItems(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                child: ListTile(
                  leading: Image.network(doc['imagen_url']),
                  title: Text(doc['nombre']),
                  subtitle: Text(doc['descripcion']),
                  trailing: Text('\$${doc['precio']}'),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
