import 'package:flutter/material.dart';
import 'package:project/providers/provider_Bicicletas.dart';

class ReservaScreen extends StatefulWidget {
  final BicicletasDataModel bicicleta;

  const ReservaScreen({Key? key, required this.bicicleta}) : super(key: key);

  @override
  _ReservaScreenState createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  DateTime fechaReserva = DateTime.now();
  TimeOfDay horaReserva = TimeOfDay.now();
  String destino = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserva Libre'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bicicleta: ${widget.bicicleta.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Fecha de reserva:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${fechaReserva.day}/${fechaReserva.month}/${fechaReserva.year}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Hora de reserva:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${horaReserva.format(context)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar la reserva
                // Puedes adaptar según tus necesidades
                // Por ejemplo, imprimir la información en la consola
                print('Reserva guardada:');
                print('Bicicleta: ${widget.bicicleta.name}');
                print('Fecha de reserva: $fechaReserva');
                print('Hora de reserva: ${horaReserva.format(context)}');
                print('Destino: $destino');

                // Puedes navegar de vuelta a la pantalla anterior si es necesario
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 140,
                    0), // Cambia el color del botón según tu preferencia
              ),
              child: Text('Iniciar Recorrido',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
