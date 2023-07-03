// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/screens/file_picker.dart';
import 'package:eyecg/presentation/widgets/bar_graph.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:open_settings/open_settings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:eyecg/presentation/widgets/bp_bar_chart.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

final controller = ScrollController();
List<double> averageBPM = [69.0,77.3,82.4,89.0,78.0,76.0,81.3];
List<double> averageBPhigh = [127.0,120.3,115.4,118.0,122.0,116.0,117.3];
List<double> averageBPlow = [81.0,78.3,77.4,82.0,78.0,76.0,81.3];
List<double> averageSPO2 = [96.0,94.3,98.4,97.0,99.0,98.0,97.3];



class _dashboardState extends State<dashboard> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

 _loadModel(){

  FirebaseModelDownloader firebaseModelDownloader = FirebaseModelDownloader.instance;
  firebaseModelDownloader.getModel("eyecg_demographs",
      FirebaseModelDownloadType.localModelUpdateInBackground,
      FirebaseModelDownloadConditions(
        iosAllowsCellularAccess: true,
        iosAllowsBackgroundDownloading: true,
        androidChargingRequired: false,
        androidWifiRequired: true,
        androidDeviceIdleRequired: false,
      )).then((customModel) async {
    final localModelPath = customModel.file;
    print(localModelPath);
    Interpreter interpreter = Interpreter.fromFile(localModelPath);
    interpreter.allocateTensors();
    //interpreter.run(input, out);
    //print('The output from the model is: $out');
  });
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _bluetoothIsOn(),
        initialData: _not_Connected(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: ScrollAppBar(
                  controller: controller,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(registerScreen,
                          arguments: 'Edit your Info');
                    },
                    child: const Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilePickerScreen()),
                            );
                          },
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 26.0,
                          ),
                        )),
                  ],
                ),
                body: _visuals(context));
          } else if (snapshot.hasError) {
            return Scaffold(
                appBar: ScrollAppBar(
                  controller: controller,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(registerScreen,
                          arguments: 'Edit your Info');
                    },
                    child: const Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilePickerScreen()),
                            );
                          },
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 26.0,
                          ),
                        )),
                  ],
                ),
                body: _not_Connected(context)); //Icon(Icons.error_outline);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Future<bool?> _bluetoothIsOn() async {
  //TODO Modify to receive data as well
  // Initialize the plugin
  //await FlutterBluetoothSerial.instance.init;
  // Check if Bluetooth is enabled
  bool? isBluetoothEnabled = await FlutterBluetoothSerial.instance.isEnabled;
  //if (!isBluetoothEnabled!) { // Prompt the user to enable Bluetooth}

  return isBluetoothEnabled; //return data from band
}

Widget _not_Connected(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 160),
        Image.asset('assets/images/bluetooth.png', scale: 4),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            "Oops looks like you're not connected to our Band, please turn on Bluetooth to connect.",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => {
            FlutterBluetoothSerial.instance.requestEnable(),
            OpenSettings.openBluetoothSetting()
          },
          child: const Text('Connect'),
        ),
      ],
    ),
  );
}

Widget _visuals(BuildContext context) {

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.cyan,
                width: 2,
              ),
            ),
            width: 320,
            height: 150,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Average Blood Pressure", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.asset(
                      'assets/icons/blood-pressure.png',
                      scale: 15,
                    ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("110/68", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 25),),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("mmHg"),
                      ],
                    )
                  ],
                )
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              reverse: true,
              animation: true,
              radius: 70.0,
              lineWidth: 15.0,
              percent: 0.7, //TODO edit to actual live reading
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('80', style: TextStyle(fontSize: 50),), //TODO edit to actual live reading
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text('BPM'),
                    ],
                  ),
                ],
              ),
              //backgroundColor: Colors.grey,
              progressColor: Colors.green,
            ),
            SizedBox(width: 30),
            CircularPercentIndicator(
              reverse: true,
              animation: true,
              radius: 70.0,
              lineWidth: 15.0,
              percent: 0.9, //TODO edit to actual live reading
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('97', style: TextStyle(fontSize: 50),), //TODO edit to actual live reading
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/oxygen.png', scale: 25,),
                      SizedBox(height: 5,),
                      Text('SPO2'),
                    ],
                  ),
                ],
              ),
              //backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ],
        ),
          SizedBox(height: 30),
          Text("Heart BPM over the week", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: BarGraph(weeklySummary: averageBPM),
          ),
          SizedBox(height: 30),
          Text("Blood pressure over the week", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          SizedBox(height: 10),
          SizedBox(
              height: 300,
              child: BarChartBp(weeklySummaryH: averageBPhigh, weeklySummaryL: averageBPlow)
          ),
          SizedBox(height: 30),
          Text("Blood Oxygen Saturation over the week", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: BarGraph(weeklySummary: averageSPO2),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: ()async{
                var out = List.filled(1*1, 0.0).reshape([1,1]);
                var input = [[0.0,48.0,0.0,72.0,1.0,1.0,1.0,97.5,77.0,157.0]];
                FirebaseModelDownloader firebaseModelDownloader = FirebaseModelDownloader.instance;
                 firebaseModelDownloader.getModel("eyecg_demographs",
                    FirebaseModelDownloadType.localModelUpdateInBackground,
                    FirebaseModelDownloadConditions(
                      iosAllowsCellularAccess: true,
                      iosAllowsBackgroundDownloading: true,
                      androidChargingRequired: false,
                      androidWifiRequired: true,
                      androidDeviceIdleRequired: false,
                    )).then((customModel) async {
                   final localModelPath = customModel.file;
                   Interpreter interpreter = Interpreter.fromFile(localModelPath);
                   interpreter.allocateTensors();
                   interpreter.run(input, out);
                   print('The output from the model is: ${out[0][0]/7.55}');
                   //File(localModelPath.path).delete();
                   interpreter.close();
                 });
              }, // sex age diabetes hr heart prob glucose smoke o2 bpl bph
              child: Text('Share Medical Data')),
          SizedBox(height: 30),
        ],
      ),
    ),
  );
}

