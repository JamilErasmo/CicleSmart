import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_map/flutter_map.dart' as prefix;
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../providers/provider_Bicicletas.dart';

// ignore: constant_identifier_names
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;
  LatLng? selectedMarkerPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      //myPosition = LatLng(-3.992214, -79.204623); //posición quemada
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    //initializeAdditionalMarkers();
  }

  Future<List<BicicletasDataModel>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('data/bicicletas.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => BicicletasDataModel.fromJson(e)).toList();
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    List<BicicletasDataModel> items = await readJsonData();
    setState(() {
      _markers.clear();
      for (int i = 0; i < 1; i++) {
        double lat = -3.9925227;
        double lng = -79.204619;
        final marker = Marker(
          markerId: MarkerId(items[i].name ?? ""),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: items[i].name ?? "",
            snippet: items[i].price ?? "",
          ),
        );
        _markers[items[i].name ?? ""] = marker;
      }
    });
  }

  /*
  void initializeAdditionalMarkers() async {
    List<BicicletasDataModel> items = await readJsonData();
    for (int i = 0; i < items.length; i++) {
      //double lat = items[i].latitude ?? 0.0;
      //double lng = items[i].longitude ?? 0.0;

      // DATOS QUEMADOS
      double lat = -3.9925227;
      double lng = -79.204619;
      additionalMarkers.add(LatLng(lat, lng));
    }
  */

  List<LatLng> additionalMarkers = [];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Cerrando Sesión");
                Navigator.pushReplacementNamed(context, '/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Sesión Cerrada"),
                    duration: Duration(seconds: 4),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-3.992214, -79.204623),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
              myLocationEnabled: true,
              polylines: selectedMarkerPosition != null
                  ? {
                      Polyline(
                        polylineId: PolylineId('polyline'),
                        color: Colors.blue,
                        points: [myPosition!, selectedMarkerPosition!],
                        width: 5,
                      ),
                    }
                  : Set<Polyline>(),
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
                Navigator.pushReplacementNamed(context, '/scooters');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/user');
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
}
