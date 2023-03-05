import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/screens/dashboard.dart';
import 'package:eyecg/presentation/screens/login.dart';
import 'package:eyecg/presentation/screens/otp_screen.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:eyecg/presentation/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRouter {
  PhoneAuthCubit? phoneAuthCubit ;
  AppRouter(){
   phoneAuthCubit = PhoneAuthCubit();
}

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case vitalsScreen:
        return MaterialPageRoute(
          builder: (_)=> BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: dashboard(),
          )
        );

      case registerScreen:
        final title = settings.arguments;
        return MaterialPageRoute(
          builder: (_)=> BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: register(title: '$title',),
          )
        );

      case loginScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider<PhoneAuthCubit>.value(
              value: phoneAuthCubit!,
              child: LoginScreen(),
            )
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider<PhoneAuthCubit>.value(
              value: phoneAuthCubit!,
              child: OTPscreen(phoneNumber: phoneNumber),
            )
        );

    }
  }


}


