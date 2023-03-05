import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPscreen extends StatelessWidget {
  OTPscreen({Key? key, required this.phoneNumber}) : super(key: key);
  late String otpCode;
  final phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroTexts(),
                    const SizedBox(
                      height: 80,
                    ),
                    _buildPinCodeField(context),
                    const SizedBox(
                      height: 50,
                    ),
                    _buildVerifyButton(context),
                    _buildPhoneVerificationBloc(),
                  ],
                ),
              ),
            )));
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
          _login(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).popAndPushNamed(
              vitalsScreen); //TODO pass arguments if needed ie:(...arguments: phoneNumber)
        }
        if (state is ErrorOccurred) {
          //Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            duration: const Duration(seconds: 3),
          ));
        }
      },
      child: Container(),
    );
  }

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
                text: 'Enter your 6 digit code number sent to ',
                style: const TextStyle(
                    color: Colors.blue, fontSize: 18, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                    text: '$phoneNumber',
                  )
                ]),
          ),
        )
      ],
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget _buildPinCodeField(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        autoFocus: true,
        keyboardType: TextInputType.number,
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          inactiveFillColor: Colors.grey,
          inactiveColor: Colors.lightBlue,
          //activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        //backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          _login(context);
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(110, 50),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        child: const Text(
          'Verify',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
