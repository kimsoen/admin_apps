import 'dart:core';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'class/clsHousingDetails.dart';
import 'services/srvs_HousingDetails.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _accessController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _mapUrlController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _photosController = TextEditingController();

  Srvshousingdetails srvshousingdetails = Srvshousingdetails();

  List<File> _images = []; // Untuk menyimpan gambar yang dipilih
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  //Fungsi untuk mengupload gambar ke Firebase Storage
  Future<void> _uploadImages() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada gambar untuk diupload')),
      );
      return;
    }

    for (var image in _images) {
      try {
        String fileName = '${DateTime.now()}.png';
        Reference storageReference = _storage.ref().child('uploads/$fileName');
        UploadTask uploadTask = storageReference.putFile(image);

        // Monitor upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          double progress = snapshot.bytesTransferred.toDouble() /
              snapshot.totalBytes.toDouble();
          print('Upload progress: ${progress * 100}%');
        });

        await uploadTask.whenComplete(() async {
          String downloadURL = await storageReference.getDownloadURL();
          print('File uploaded at: $downloadURL');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File berhasil diupload: $downloadURL')),
          );
        });
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Admin - Input Data Perumahan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Perumahan',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _accessController,
              decoration: const InputDecoration(
                labelText: 'akses',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _distanceController,
              decoration: const InputDecoration(
                labelText: 'Distance',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _mapUrlController,
              decoration: const InputDecoration(
                labelText: 'MapUrl',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'image',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            TextField(
              controller: _photosController,
              decoration: const InputDecoration(
                labelText: 'Photos',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _pickImages, // Memanggil fungsi tanpa tanda kurung
              child: Container(
                height: 160,
                color: Colors.grey[200],
                child: _images.isNotEmpty
                    ? Image.file(
                        _images[0], // Mengambil gambar pertama dari daftar
                        fit: BoxFit.cover,
                      )
                    : const Center(child: Text('Pilih poto')),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Save logic here
                    Clshousingdetails clHousing = Clshousingdetails(
                      name: _nameController.text,
                      address: _addressController.text,
                      description: _descriptionController.text,
                      distance: _distanceController.text,
                      latitude: int.parse(_latitudeController.text),
                      longitude: int.parse(_longitudeController.text),
                      mapUrl: _mapUrlController.text,
                      access: List.empty(),
                      image: _imageController.text,
                      photos: List.empty(),
                    );

                    srvshousingdetails.addData(clHousing);
                    _uploadImages;
                  },
                  child: const Text('Simpan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Cancel logic here
                  },
                  child: const Text('Batal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
