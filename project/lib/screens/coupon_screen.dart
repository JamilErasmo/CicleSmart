import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupones'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCouponCard(
              'Descuento en Alquiler de Bicicletas',
              '¡Obtén un 20% de descuento en tu próximo alquiler de bicicleta!',
              'assets/bicicleta.jpg',
              'Válido hasta: 31/12/2024',
            ),
            _buildCouponCard(
              'Promoción de Scooters Eléctricos',
              'Compra un pase de 5 viajes en scooter y obtén 2 viajes gratis.',
              'assets/scooter.jpeg',
              'Válido hasta: 30/11/2024',
            ),
            // Puedes agregar más cupones según sea necesario
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(
    String title,
    String description,
    String imagePath,
    String expirationDate,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              height: 100, // Ajusta la altura según sea necesario
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              expirationDate,
              style: TextStyle(
                fontSize: 14,
                color:
                    Colors.red, // Puedes ajustar el color según sea necesario
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Acciones cuando se presiona el botón de canjear
                // Puedes implementar la lógica de canje aquí
              },
              child: Text('Canjear'),
            ),
          ],
        ),
      ),
    );
  }
}
