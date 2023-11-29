import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectionController extends GetxController {
  var connectionStatus = Rx<ConnectivityResult?>(null);
  late StreamSubscription<ConnectivityResult> subscription;

  final internetStatusStream = StreamController<ConnectivityResult>.broadcast();

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
    subscription = Connectivity().onConnectivityChanged.listen((result) async {
      connectionStatus.value = result;
      internetStatusStream.add(result);
      showInternetStatusSnackbar(result);
    });
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    connectionStatus.value = connectivityResult;
    internetStatusStream.add(connectivityResult);
  }

  void showInternetStatusSnackbar(ConnectivityResult result) {
    String message = _getMessageFromConnectivityResult(result);
    Get.snackbar(
      'Internet Status',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: _getColorFromConnectivityResult(result),
      duration: const Duration(seconds: 3),
    );
  }

  String _getMessageFromConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'Connected to WiFi';
      case ConnectivityResult.mobile:
        return 'Connected to mobile network';
      case ConnectivityResult.none:
        return 'No internet connection';
      default:
        return 'Connection status unknown';
    }
  }

  Color _getColorFromConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return Colors.green;
      case ConnectivityResult.mobile:
        return Colors.blue;
      case ConnectivityResult.none:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void onClose() {
    subscription.cancel();
    internetStatusStream.close();
    super.onClose();
  }
}
