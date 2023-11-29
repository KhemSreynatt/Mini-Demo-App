// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app/module/home/controller/image_controller.dart';
import 'package:demo_app/module/home/controller/network_controller.dart';
import 'package:demo_app/module/home/custom/custom_image.dart';
import 'package:demo_app/module/home/screen/detail_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  final internetConnectionController = Get.put(InternetConnectionController());
  final controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Mini Demo App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: internetConnectionController.internetStatusStream.stream,
        initialData: ConnectivityResult.none,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final result = snapshot.data;

            if (result == ConnectivityResult.none) {
              return const Center(
                  child: Text(
                'No internet connection',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ));
            } else {
              return SingleChildScrollView(
                child: Obx(
                  () => controller.isloading.value == true
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: controller.listImage
                              .asMap()
                              .entries
                              .map(
                                (e) => CustomImage(
                                  title: e.value.author,
                                  id: e.value.id,
                                  image: e.value.downloadUrl,
                                  ontap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewContainer(
                                          url: e.value.url,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                ),
              );
            }
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
