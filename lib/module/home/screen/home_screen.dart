// ignore_for_file: deprecated_member_use

import 'package:demo_app/module/home/controller/image_controller.dart';
import 'package:demo_app/module/home/custom/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    controller.getDataImage();
    super.initState();
  }

  final controller = Get.put(ImageController());
  Future<void> launchURL() async {
    const url = 'https://flutter.dev/'; // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Demo App'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isloading.value == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: controller.listImage
                      .asMap()
                      .entries
                      .map(
                        (e) => CustomImage(
                          title: e.value.author,
                          id: e.value.id,
                          image: e.value.downloadUrl,
                          ontap: () async {
                            launchURL();
                          },
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
