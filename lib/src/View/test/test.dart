import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServerController extends GetxController {
  RxList<Server> servers = <Server>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the list of servers here
    servers.addAll([
      Server("Server 1", false.obs),
      Server("Server 2", false.obs),
      Server("Server 3", false.obs),

      // Add more servers as needed
    ]);
  }

  void toggleServerSelection(int index) {
    servers[index].isSelected.value = !servers[index].isSelected.value;
  }
}

class Server {
  String name;
  RxBool isSelected = false.obs;

  Server(this.name, this.isSelected);
}

class MyApp extends GetView<ServerController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServerController());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Server Selection"),
        ),
        body: Container(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: controller.servers.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => controller.servers[index].isSelected.value
                      ? ListTile(
                          title: Text(controller.servers[index].name),
                          onTap: () {
                            // Toggle the server selection
                            controller.toggleServerSelection(index);
                          },
                          tileColor: Colors.grey)
                      : ListTile(
                          title: Text(controller.servers[index].name),
                          onTap: () {
                            // Toggle the server selection
                            controller.toggleServerSelection(index);
                          },
                          tileColor: Colors.red),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
