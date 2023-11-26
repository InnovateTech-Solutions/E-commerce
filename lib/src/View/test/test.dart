import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                determinePosition().then((result) {
                  setState(() {
                    location = result;
                  });
                }).catchError((error) {
                  setState(() {
                    location = 'Error: $error';
                  });
                });
              },
              child: Text('Get Location'),
            ),
            SizedBox(height: 20),
            Text(
              'Location: ${location ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();

    // Convert the position to a string
    String locationString =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';

    // Return the location string
    return locationString;
  }
}
