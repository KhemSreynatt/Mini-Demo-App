import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/image_model.dart';

class ImageController extends GetxController {
  var isloading = false.obs;
  var isConnected = false.obs;
  var galleries = [].obs;
  var listImage = <ImageModel>[].obs;
  var modelImage = ImageModel().obs;

  Future<void> getDataImage() async {
    isloading(true);

    try {
      var url = 'https://picsum.photos/v2/list';
      var respones = await http.get(Uri.parse(url));
      if (respones.statusCode == 200) {
        debugPrint('statusCode: ${respones.statusCode}');
        var reJson = json.decode(respones.body);
        reJson.map((e) {
          modelImage.value = ImageModel.fromJson(e);
          listImage.add(modelImage.value);
        }).toList();
        Future.delayed(const Duration(seconds: 3)).then((e) {
          isloading(false);
        });
      }
      isConnected(false);
      isloading(false);
    } catch (e) {
      isloading(false);
    }
  }
}
