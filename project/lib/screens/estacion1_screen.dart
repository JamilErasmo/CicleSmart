import 'package:flutter/material.dart';
import 'package:project/screens/Bicicletas.dart';

class Estacion1 extends StatefulWidget {
  const Estacion1({Key? key}) : super(key: key);

  @override
  _Estacion1State createState() => _Estacion1State();
}

class _Estacion1State extends State<Estacion1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estaciones disponibles'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildCard("Estacion del Leon", 0, ''),
              _buildCard("Estacion Puerta de la Ciudad", 1, 'bicicletas1'),
              _buildCard("Estacion Coliseo Ciudad de Loja", 2, 'bicicletas2'),
              _buildCard("Estacion Mercadillo", 3, ''),
              _buildCard("Estacion Hipervalle", 4, ''),
              _buildCard("Estacion Jose Antonio", 5, ''),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color.fromARGB(255, 255, 140, 0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/map');
                break;
              case 2:
                // No hacer nada ya que ya está en la pantalla actual
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/scooters');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
              // Añadir más casos según sea necesario
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Ubicacion',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.electric_bike),
              label: 'Bicicleta',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.electric_scooter),
              label: 'Scooter',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String estacionName, int cardIndex, String estacionJson) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(25),
      elevation: 10,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _navigateToScreenBasedOnCard(context, cardIndex, estacionJson);
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(estacionName),
              leading: Icon(Icons.map),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreenBasedOnCard(
      BuildContext context, int cardIndex, String estacionJson) {
    switch (cardIndex) {
      case 0:
        _navigateToBicicletaScreen(context);
        break;
      case 1:
        _navigateToBicicletaScreen(context, estacionJson);
        break;
      case 2:
        _navigateToBicicletaScreen(context, estacionJson);
        break;
      // Agregar más casos si tienes más tarjetas
    }
  }

  void _navigateToBicicletaScreen(BuildContext context,
      [String? estacionJson]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BicicletaScreen(estacionJson: estacionJson),
      ),
    );
  }
}
