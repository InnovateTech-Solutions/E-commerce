import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestCheck extends StatefulWidget {
  @override
  _TestCheckState createState() => _TestCheckState();
}

class _TestCheckState extends State<TestCheck> {
  final TextEditingController _emailController = TextEditingController();
  bool emailExists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String enteredEmail = _emailController.text.trim();
                emailExists = await checkEmailExists(enteredEmail);

                if (emailExists) {
                  print('$enteredEmail exists in the collection.');
                } else {
                  print('$enteredEmail does not exist. Creating an account.');
                  // Add your account creation logic here
                }
              },
              child: Text('Check Email'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkEmailExists(String email) async {
    bool exists = false;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User') // Replace with your actual collection name
          .where('Email', isEqualTo: email)
          .get();

      exists = querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle any errors that might occur.
      print('Error checking email existence: $e');
    }

    return exists;
  }
}

class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Content View'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'This is the Content View',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
