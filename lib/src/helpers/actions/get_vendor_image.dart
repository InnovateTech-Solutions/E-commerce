import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorImage extends StatelessWidget {
  const VendorImage({required this.image, super.key});
  final String image;
  Future<String> getImageUrl(String name) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Vendors')
          .where('Name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var imageUrl = querySnapshot.docs.first.get('Image');

        if (imageUrl is String) {
          return imageUrl;
        } else {
          print('Error: "imgUrl" field is not a String.');
          return 'null';
        }
      } else {
        return 'null';
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return "null";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image URL Example'),
      ),
      body: FutureBuilder<String>(
        future: getImageUrl(image),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return Text('No image URL found');
          } else {
            // Use the retrieved image URL as needed
            return Image.network(snapshot.data!);
          }
        },
      ),
    );
  }
}
