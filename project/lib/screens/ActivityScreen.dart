import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildActivityCard(
              'Bicicleta',
              'Recorrido: Punto A - Punto B',
              'Costo: \$5.00',
              'Fecha: 01/01/2023',
              'assets/bicicleta.jpg',
            ),
            SizedBox(height: 16),
            _buildActivityCard(
              'Scooter',
              'Recorrido: Punto C - Punto D',
              'Costo: \$8.00',
              'Fecha: 02/01/2023',
              'assets/scooter.jpeg',
            ),
            // Agrega más tarjetas según sea necesario
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    String deviceType,
    String routeDescription,
    String cost,
    String date,
    String imagePath,
  ) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dispositivo: $deviceType',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  routeDescription,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  cost,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
