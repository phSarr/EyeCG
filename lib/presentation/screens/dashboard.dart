// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/screens/file_picker.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:open_settings/open_settings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';


class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

final controller = ScrollController();

class _dashboardState extends State<dashboard> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
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
            SizedBox(width: 50),
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

        ],
      ),
    ),
  );
}
