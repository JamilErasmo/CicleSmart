import 'package:flutter/material.dart';
import 'package:project/screens/Bicicletas.dart';
import 'package:project/screens/scooters.dart';

class Estacion2 extends StatefulWidget {
  const Estacion2({Key? key}) : super(key: key);

  @override
  _Estacion2State createState() => _Estacion2State();
}

class _Estacion2State extends State<Estacion2> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estaciones disponibles'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _buildCard("Estacion de Puerta de la ciudad", 0),
              _buildCard("Estacion Estadio", 1),
              _buildCard("Estacion Coliseo Ciudad de Loja", 2),
              _buildCard("Estacion Jose Antonio", 3),
              _buildCard("Estacion Mercadillo", 4),
              _buildCard("Estacion Hipervalle", 5),
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
                Navigator.pushReplacementNamed(context, '/bicicletas');
                break;
              case 3:
                // No hacer nada ya que ya está en la pantalla actual
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

  Widget _buildCard(String estacionName, int cardIndex) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(25),
      elevation: 10,
      child: InkWell(
        onTap: () {
          _navigateToScreenBasedOnCard(context, cardIndex);
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

  void _navigateToScreenBasedOnCard(BuildContext context, int cardIndex) {
    switch (cardIndex) {
      case 0:
        _navigateToScooterScreen(context);
        break;
      case 1:
        _navigateToBicicletaScreen(context);
        break;
      case 2:
        // Puedes agregar más casos según sea necesario
        break;
      // Agregar más casos si tienes más tarjetas
    }
  }

  void _navigateToBicicletaScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScooterScreen(),
      ),
    );
  }

  void _navigateToScooterScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BicicletaScreen(),
      ),
    );
  }
}
