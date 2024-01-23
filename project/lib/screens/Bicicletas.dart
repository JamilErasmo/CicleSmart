import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:project/screens/reserva1_screen.dart';
import 'package:project/screens/reserva2_screen.dart';
import 'package:project/screens/reserva3_screen.dart';
import '../../providers/provider_Bicicletas.dart';

class BicicletaScreen extends StatefulWidget {
  final String? estacionJson;
  const BicicletaScreen({Key? key, this.estacionJson}) : super(key: key);

  @override
  _BicicletaScreenState createState() => _BicicletaScreenState();
}

class _BicicletaScreenState extends State<BicicletaScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bicicletas disponibles'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
      ),
      body: FutureBuilder(
        future: readJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<BicicletasDataModel>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _navigateToProductDetails(context, items[index]);
                  },
                  child: Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 50,
                            child: Image(
                              image: NetworkImage(
                                  items[index].imageURL.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 8),
                                    child: Text(
                                      items[index].name.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 8),
                                    child: Text(items[index].price.toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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

  void _navigateToProductDetails(
      BuildContext context, BicicletasDataModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  Future<List<BicicletasDataModel>> readJsonData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('data/${widget.estacionJson ?? 'bicicletas'}.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => BicicletasDataModel.fromJson(e)).toList();
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final BicicletasDataModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name.toString()),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product.imageURL.toString(),
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'Categoria: ${product.category.toString()}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Precio: ${product.price.toString()}',
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.battery_full, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Batería: ${product.battery.toString()}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Seleccione el tipo de recorrido: ',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 140, 0),
              ),
              onPressed: () {
                _navigateToReservaScreen3(context, product);
              },
              child:
                  const Text('Reservar', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 140, 0),
              ),
              onPressed: () {
                _navigateToReservaScreen(context, product);
              },
              child: const Text('Recorrido libre',
                  style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 140, 0),
              ),
              onPressed: () {
                _navigateToReservaScreen2(context, product);
              },
              child: const Text('Recorrido planificado',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToReservaScreen(
      BuildContext context, BicicletasDataModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaScreen(bicicleta: product),
      ),
    );
  }

  void _navigateToReservaScreen2(
      BuildContext context, BicicletasDataModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaScreen2(bicicleta: product),
      ),
    );
  }

  void _navigateToReservaScreen3(
      BuildContext context, BicicletasDataModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaScreen3(bicicleta: product),
      ),
    );
  }
}
