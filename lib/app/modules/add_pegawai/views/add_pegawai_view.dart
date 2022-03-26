import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADD PEGAWAI'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.nipController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NIP',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => controller.addPegawai(),
              child: Text('Add Pegawai'),
            ),
          ],
        ));
  }
}
