import 'package:flutter/material.dart';
import 'package:project/providers/provider_Bicicletas.dart';

class ReservaScreen3 extends StatefulWidget {
  final BicicletasDataModel bicicleta;

  const ReservaScreen3({Key? key, required this.bicicleta}) : super(key: key);

  @override
  _ReservaScreenState createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen3> {
  DateTime fechaReserva = DateTime.now();
  TimeOfDay horaReserva = TimeOfDay.now();
  String destino = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaReserva,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != fechaReserva) {
      setState(() {
        fechaReserva = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: horaReserva,
    );

    if (picked != null && picked != horaReserva) {
      setState(() {
        horaReserva = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva tu Bicicleta'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bicicleta: ${widget.bicicleta.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Fecha de reserva:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Seleccionar Fecha'),
                ),
                const SizedBox(width: 8),
                Text(
                  '${fechaReserva.day}/${fechaReserva.month}/${fechaReserva.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Hora de reserva:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text('Seleccionar Hora'),
                ),
                const SizedBox(width: 8),
                Text(
                  '${horaReserva.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                destino = value;
              },
              decoration: const InputDecoration(
                labelText: 'Destino',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
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
              child: const Text('Guardar Reserva',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
