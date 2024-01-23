import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer),
            onPressed: () {
              Navigator.pushNamed(context, '/coupons');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageCarouselFromFirebase([
              'imgLocal1.png',
              'imgLocal2.png',
              'imgLocal3.png',
            ]),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'NOVEDADES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildFrostedCardFromFirebase(
              'image1.png',
              'Conoce más de nuestro proyecto aquí',
            ),
            _buildFrostedCardFromFirebase(
              'image2.png',
              'Entérate de lo importante de hacer deporte',
            ),
            _buildFrostedCardFromFirebase(
              'image3.png',
              'Recorre las rutas más transitadas por los usuarios',
            ),
          ],
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
                // No hacer nada ya que ya está en la pantalla actual
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/map');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/bicicletas');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/scooters');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
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

  Widget _buildImageCarouselFromFirebase(List<String> imageNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'ESTACIONES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageNames.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FutureBuilder(
                    future: FirebaseStorage.instance
                        .ref()
                        .child(imageNames[index])
                        .getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error);
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Text('No se pudo cargar la imagen');
                      } else {
                        return Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFrostedCardFromFirebase(String imageName, String description) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: FirebaseStorage.instance
                  .ref()
                  .child(imageName)
                  .getDownloadURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No se pudo cargar la imagen');
                } else {
                  return Image.network(
                    snapshot.data.toString(),
                    fit: BoxFit.fill,
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
