import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/search_controller.dart';

class ServiceSearchScreen extends StatefulWidget {
  ServiceSearchScreen({Key? key}) : super(key: key);

  @override
  State<ServiceSearchScreen> createState() => _ServiceSearchScreenState();
}

class _ServiceSearchScreenState extends State<ServiceSearchScreen> {
  final searchController = Get.put(SearchControllerr());

  @override
  void initState() {
    super.initState();
    searchController.fetchServicesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                print("view list:");
                print(searchController.searchServices(query));
                searchController.searchServices(query);
              },
              decoration: InputDecoration(
                labelText: 'Search Services',
                hintText: 'Enter a keyword...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: searchController.fetchServicesFromFirestore(), // Use your future here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: searchController.services.length,
                    itemBuilder: (context, index) {
                      final service = searchController.services[index];
                      return ListTile(
                        title: Text(service['Name']),
                        subtitle: Text(service['Description']),
                        // Add more UI elements to display service details as needed.
                      );
                    },
                  ); 
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
