import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.displayName ?? '';
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
      String fileName = 'profile_images/${widget.user.uid}.png';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      await storageReference.putFile(_imageFile!);
      String downloadURL = await storageReference.getDownloadURL();

      // Actualizar la foto de perfil directamente en la instancia de User
      await widget.user.updatePhotoURL(downloadURL);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Foto de perfil actualizada'),
        ),
      );
    } catch (e) {
      print("Error al subir la imagen: $e");
    }
  }

  Future<void> _updateProfile() async {
    try {
      await widget.user.updateDisplayName(_nameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nombre de usuario actualizado'),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print("Error al actualizar el nombre de usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
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
                  : widget.user.photoURL != null
                      ? NetworkImage(widget.user.photoURL!)
                      : AssetImage('assets/user_profile_image.jpg')
                          as ImageProvider<Object>?,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateProfile();
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(child: Text('Guardar Cambios')),
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
