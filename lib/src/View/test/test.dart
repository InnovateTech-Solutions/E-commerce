import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:profile_part/src/View/test/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Filter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => controller.filterPlayer(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.foundPlayers.value.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      controller.foundPlayers.value[index]['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text(controller.foundPlayers.value[index]['country']),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
