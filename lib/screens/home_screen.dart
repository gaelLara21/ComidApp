import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'reservaciones_screen.dart';
import 'pedidos_screen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: 'Menú',
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MenuScreen()));
                }),
            CustomButton(
                text: 'Reservaciones',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ReservacionesScreen()));
                }),
            CustomButton(
                text: 'Pedidos',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PedidosScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
