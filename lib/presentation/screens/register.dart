import 'package:eyecg/business_logic/phone_auth_cubit.dart';
import 'package:eyecg/presentation/widgets/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class register extends StatefulWidget {
  const register({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<register> createState() => _registerState();
}

final RegExp nameRegExp = RegExp('/\b([A-Z]{1}[a-z]{1,30}[- ]{0,1}|[A-Z]{1}[- \']{1}[A-Z]{0,1}[a-z]{1,30}[- ]{0,1}|[a-z]{1,2}[ -\']{1}[A-Z]{1}[a-z]{1,30}){2,5}/');


PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

//List<TextEditingController> textControllerList = [];
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController otherDiseasesController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController weightController = TextEditingController();
TextEditingController heightController = TextEditingController();


List emergencyNumbers = [];
const List<String> genderOptions = ['Male', 'Female'];

final GlobalKey<FormBuilderState> _regFormKey = GlobalKey();


_loadDefaults() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance() as SharedPreferences;
  String defualt_name = _prefs.getString('name') ?? 'default name' ;
}

_saveData(String name) async{ //TODO implement function
  SharedPreferences _prefs = await SharedPreferences.getInstance() as SharedPreferences;
  _prefs.setString("username", name);

}

class _registerState extends State<register> {


  @override
  void initState() {

  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
          child: FormBuilder(
        key: _regFormKey,
        onChanged: () {
          _regFormKey.currentState!.save();
        },
        autovalidateMode: AutovalidateMode.always,
        initialValue: const { //TODO change to shared prefs values if exists
          'name': '',
          'number' : '',
          'eMail': '',
          'gender': 'Male',
          'diseases': ['None'],
          'Other diseases': '',
          'age': '',
          'weight': '',
          'height': '',
          'smoking': 'Never',
          'diabetes_history': 'No',
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Please make sure health related data is up to date and filled correctly as false data will lead to false health condition assessment', //style: TextStyle(),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                  name: 'name',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Required Field'),
                    FormBuilderValidators.match("^([a-zA-Z]{2,}\\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\\s?([a-zA-Z]{1,})?)",errorText: "Enter your First and Last name")
                  ]),
                  controller: usernameController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    suffixIcon : const Icon(Icons.account_circle_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintText: "Type in your name",
                  )),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'number',
                 controller: phoneNumberController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  suffixIcon : const Icon(Icons.phone),
                ),
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.match("[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$", errorText: 'Enter a Valid Number'),
                  FormBuilderValidators.required(errorText: 'Type in your Number')
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'eMail',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Required Field'),
                  FormBuilderValidators.email(errorText: 'Enter a valid E-Mail')
                ]),
                controller: emailController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  suffixIcon : const Icon(Icons.mail_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintText: "Type in your E-Mail",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderDropdown<String>(
                name: 'gender',
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  hintText: 'Select Gender',
                ),
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                items: genderOptions
                    .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                valueTransformer: (val) => val?.toString(),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderCheckboxGroup<String>(
                initialValue: ['None'],
                valueTransformer: (val) => val?.toString(),
                decoration: const InputDecoration(
                    labelText: 'Please check on diseases you have'),
                name: 'diseases',
                options: const [
                  FormBuilderFieldOption(value: 'High blood pressure'),
                  FormBuilderFieldOption(value: 'High cholesterol'),
                  FormBuilderFieldOption(value: 'Low blood pressure'),
                  FormBuilderFieldOption(value: 'Gestational Diabetes [Female]'),
                  //FormBuilderFieldOption(value: 'None'),
                ],
                separator: const VerticalDivider(
                  width: 10,
                  thickness: 5,
                ),
                validator: (val) => /*val!.isEmpty? 'Required Field':*/
                ((val!.contains('High blood pressure')&&val.contains('Low blood pressure'))
                    ? 'You can\'t have High AND low blood pressure'
                    : null),
                // onChanged: //TODO if possible implement a none/clear option
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                  name: 'Other diseases',
                  //validator:
                  controller: otherDiseasesController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Other diseases',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintText: "Other diseases that weren't mentioned?",
                  )),
              const SizedBox(
                height: 15,
              ),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                  labelText: 'Smoking',
                ),
                initialValue: null,
                name: 'smoking',
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                options: ['Never', 'Current', 'Former']
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                  labelText: 'Diabetes History',
                ),
                initialValue: null,
                name: 'diabetes_history',
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                options: ['Yes', 'No']
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'age',
                controller: ageController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Age',
                  /*suffixIcon: _ageHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),*/
                ),
                onChanged: (val) {
                  setState(() {});
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(2),
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'weight',
                controller: weightController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: "Type in your weight in Kilograms",
                  labelText: 'Weight',
                  suffixIcon: Image.asset(
                    'assets/icons/weight.png',
                    scale: 17,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                  FormBuilderValidators.maxLength(3),
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'height',
                controller: heightController,
                decoration: InputDecoration(
                  hintText: "Type in your height in Centimeters",
                  labelText: 'Height',
                  suffixIcon: Image.asset(
                    'assets/icons/height.png',
                    scale: 17,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                  FormBuilderValidators.maxLength(3),
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 15,
              ),
              //TODO emergency contacts
              const SizedBox(
                height: 15,
              ),
              //TODO form reset, just add initial value field,  Form.onChanged callback will be called. so set it
              //TODO form verification
              //TODO pass phone number to OTP screen
              Row(
                children: <Widget>[
                  Expanded(
                    child: widget.title=='Register'? _resetFormButton(context) : _logOutButton(context)
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                          onPressed: () {
                            showProgressIndicator(context);
                            _register(context);
                          },
                          child: const Text(
                            'Submit',
                            //style: TextStyle(color: Colors.white),
                          ),
                        )
                  ),
                  _buildPhoneNumberSubmittedBloc()
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }

  // IS THIS EVEN NEEDED ?????????
  @override
  void dispose() {
    usernameController.dispose();
     emailController.dispose();
     phoneNumberController.dispose();
     otherDiseasesController.dispose() ;
     ageController.dispose() ;
     weightController.dispose() ;
    heightController.dispose();
    super.dispose();
}
}



Widget _logOutButton(BuildContext context){
  return BlocProvider<PhoneAuthCubit>(
    create: (context) => phoneAuthCubit,
    child: OutlinedButton(
      onPressed: () async {
        await phoneAuthCubit.logOut();
        Navigator.of(context).pushReplacementNamed(loginScreen);
      },
      child: Text(
        'Log out',
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary),
      ),
    ),
  );
}


Widget _resetFormButton(BuildContext context){ //TODO reset functionality not properly working
  return OutlinedButton(
    onPressed: () {
      //maybe context maybe state is null somehow ? .. no idea for now
      final formstate = FormBuilder.of(context);
      formstate!.reset();
      _regFormKey.currentState!.reset();
    },
    // color: Theme.of(context).colorScheme.secondary,
    child: Text(
      'Reset',
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary),
    ),
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

Future<void> _register(BuildContext context) async {
  Navigator.pop(context);
  _regFormKey.currentState?.save();
  BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumberController.text);
}

Widget _buildPhoneNumberSubmittedBloc() {
  return BlocListener<PhoneAuthCubit, PhoneAuthState>(
    listenWhen: (previous, current) {
      return previous != current;
    },
    listener: (context, state) {
      if (state is Loading) {
        showProgressIndicator(context);
      }
      if (state is PhoneNumberSubmitted) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumberController.text);
      }
      if (state is ErrorOccurred) {
        Navigator.pop(context);
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

