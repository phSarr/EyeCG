import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/screens/file_picker.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // TODO replace with user user info screen including a logout option and a confirmation popup
            Navigator.of(context).pushNamed(registerScreen, arguments: 'Edit your Info');
            /*BlocProvider<PhoneAuthCubit>(
              create: (context) => phoneAuthCubit,
              child: ElevatedButton(
                onPressed: () async {
                  await phoneAuthCubit.logOut();
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text(
                  'Log out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );*/
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
                    MaterialPageRoute(builder: (context) => FilePickerScreen()),
                  );
                },
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            //TODO turn on/connect to bluetooth device widget
            ElevatedButton(
              onPressed: () => {},
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
