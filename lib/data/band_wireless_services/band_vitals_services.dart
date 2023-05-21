/*
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Band_Vitals_Services{
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  Band_Vitals_Services(){
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        r.device.name;
      }
    });
    flutterBlue.stopScan();
  }

}

*/
