import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FormsProvider(),
          ),
        ],
        child: const Purchased(),
      ),
    );
  }
}

class Purchased extends StatefulWidget {
  const Purchased({Key? key}) : super(key: key);

  @override
  State<Purchased> createState() => _PurchasedState();
}

class _PurchasedState extends State<Purchased> {
  final List<String> category = [
    'Manager',
    'Reception',
    'Sales',
    'Service',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FormsProvider>(
      builder: (context, formsProvider, child) {
        List<Form> formsList = formsProvider.listOfForms;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              formsProvider
                  .addFormToList(DateTime.now().millisecondsSinceEpoch);
            },
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: formsList.length,
                    itemBuilder: ((context, index) {
                      UserInfo formItemInfo = formsList[index].userInfo;
                      return Column(
                        children: [
                          const Text('phone'),
                          Text(formItemInfo.phone),
                          const Text('email'),
                          Text(formItemInfo.email),
                          const Text('category'),
                          Text(formItemInfo.category)
                        ],
                      );
                    })),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: formsList.length,
                    itemBuilder: ((context, index) {
                      Form form = formsList[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                formsProvider.removeFormFromList(form);
                              },
                              icon: const Icon(
                                Icons.remove,
                              ),
                            ),
                            TextFormField(
                              onChanged: (phoneVal) {
                                formsProvider.setPhone(form.id, phoneVal);
                              },
                            ),
                            TextFormField(
                              onChanged: (emailVal) {
                                formsProvider.setEmail(form.id, emailVal);
                              },
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: const Text(
                                'Select Category',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              items: category
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              onChanged: (categoryVal) {
                                if (categoryVal != null) {
                                  formsProvider.setCategory(
                                      form.id, categoryVal);
                                }
                              },
                            )
                          ],
                        ),
                      );
                    })),
              )
            ],
          ),
        );
      },
    );
  }
}

class FormsProvider extends ChangeNotifier {
  List<Form> _listOfForms = [];
  List<Form> get listOfForms => _listOfForms;

  void addFormToList(int id) {
    _listOfForms.add(
        Form(id: id, userInfo: UserInfo(category: '', email: '', phone: '')));
    notifyListeners();
  }

  void removeFormFromList(Form form) {
    _listOfForms.remove(form);
    notifyListeners();
  }

  void setEmail(int idForm, String newEmail) {
    _listOfForms.firstWhere((element) => element.id == idForm).userInfo.email =
        newEmail;
    notifyListeners();
  }

  void setPhone(int idForm, String newPhone) {
    _listOfForms.firstWhere((element) => element.id == idForm).userInfo.phone =
        newPhone;
    notifyListeners();
  }

  void setCategory(int idForm, String newCategory) {
    _listOfForms
        .firstWhere((element) => element.id == idForm)
        .userInfo
        .category = newCategory;

    notifyListeners();
  }
}

class Form {
  int id;
  UserInfo userInfo;

  Form({
    required this.id,
    required this.userInfo,
  });
}

class UserInfo {
  String phone;
  String email;
  String category;

  UserInfo({
    this.email = '',
    this.phone = '',
    this.category = '',
  });
}
