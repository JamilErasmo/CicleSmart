import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/screens/activityScreen.dart';
import 'package:project/screens/editProfileScreen.dart';
import 'package:project/screens/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error al seleccionar la imagen: $e");
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      return;
    }

    try {
      String fileName = 'profile_images/${_user!.uid}.png';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      await storageReference.putFile(_imageFile!);
      String downloadURL = await storageReference.getDownloadURL();

      // Actualizar la foto de perfil directamente en la instancia de User
      await _user!.updatePhotoURL(downloadURL);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Foto de perfil actualizada'),
        ),
      );
    } catch (e) {
      print("Error al subir la imagen: $e");
    }
  }

  // Método para navegar al HomeScreen
  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : _user?.photoURL != null
                      ? NetworkImage(_user!.photoURL!)
                      : AssetImage('assets/user_profile_image.jpg')
                          as ImageProvider<Object>?,
            ),
            SizedBox(height: 16),
            Text(
              'Usuario: ${_user?.displayName ?? "N/A"}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Correo electrónico: ${_user?.email ?? "N/A"}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(user: _user!),
                    ),
                  );

                  if (result == true) {
                    setState(() {
                      _user = _auth.currentUser!;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 140, 0),
                ),
                child: Text('Editar Perfil'),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _pickImage(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 140, 0),
                ),
                child: Text('Seleccionar Foto'),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _uploadImage();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 140, 0),
                ),
                child: Text('Subir Foto'),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 140, 0),
                ),
                child: Text('Actividad'),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 140, 0),
                ),
                child: Text('Cerrar Sesión'),
              ),
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
}
