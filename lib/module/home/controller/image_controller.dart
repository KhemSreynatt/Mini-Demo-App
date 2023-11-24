import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../model/image_model.dart';

class ImageController extends GetxController {
  var isloading = false.obs;
  var isConnected = false.obs;
  var galleries = [].obs;
  var listImage = <ImageModel>[].obs;
  var modelImage = ImageModel().obs;
  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }

  Future<void> getDataImage() async {
    isloading(true);
    try {
      var url = 'https://picsum.photos/v2/list';
      var respones = await http.get(Uri.parse(url));
      if (respones.statusCode == 200) {
        var reJson = json.decode(respones.body);
        reJson.map((e) {
          modelImage.value = ImageModel.fromJson(e);
          listImage.add(modelImage.value);
        }).toList();
        Future.delayed(const Duration(seconds: 2)).then((e) {
          isloading(false);
        });
      } else {
        await loadCachedData();
      }
    } catch (e) {
      isloading(true);
    }
  }

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      await loadCachedData();
    } else {
      isConnected.value = true;
    }
  }

  Future<void> loadCachedData() async {
    try {
      String cacheData = await readCacheData();
      if (cacheData.isNotEmpty) {
        var decodedData = json.decode(cacheData);
        galleries(decodedData);
      }
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/gallery_cache.json');
  }

  Future<File> writeCacheData(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

  Future<String> readCacheData() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}
