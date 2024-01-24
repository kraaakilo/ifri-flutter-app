import 'package:flutter/material.dart';
import 'package:ifri_management/database/UserDB.dart';
import 'package:intl/intl.dart';
import 'package:ifri_management/logic/CreateUser.dart';

void main() => runApp(const CreateUserPage());

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un utilisateur : Nouveau"),
      ),
      body: const FormWidget(),
    );
  }
}

// Create a Form widget.
class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  FormWidgetState createState() {
    return FormWidgetState();
  }
}

class FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _lastnameController;
  late TextEditingController _firstnameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _pictureController;
  late TextEditingController _citationController;
  late String _gender;
  late String _birthday;

  DateTime selectedDate = DateTime(2010);
  final TextEditingController _date = TextEditingController();
  bool success = false;

  @override
  void initState() {
    super.initState();
    _lastnameController = TextEditingController();
    _firstnameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _pictureController = TextEditingController();
    _citationController = TextEditingController();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateFormat formattedDate = DateFormat('dd/MM/yyyy');
    final DateTime? picked = await showDatePicker(
        // locale: const Locale("fr", "CH"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2010));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _birthday = formattedDate.format(picked);
        _date.value = TextEditingValue(
          text: DateFormat('EEEE dd MMMM yyyy').format(picked),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: success
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Réussi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[500],
                          ),
                        ),
                      )
                    : const Text(""),
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(hintText: "Nom"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez le nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(hintText: "Prénom"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez le prénom';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _date,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez la date de naissance';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: 'Date de naissance',
                    ),
                    onSaved: (value) => _birthday = value!,
                  ),
                ),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(hintText: "Adresse"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saisissez l\'adresse';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Numéro de Téléphone"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez le numéro de téléphone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Adresse email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez une adresse e-mail';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(hintText: "Sexe"),
                icon: const Icon(Icons.move_down_outlined),
                validator: (value) {
                  if (value == null) {
                    return "Veuillez choisir une option";
                  }
                  return null;
                },
                items: ["Féminin", "Masculin"]
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              TextFormField(
                controller: _pictureController,
                decoration: const InputDecoration(hintText: "Profil"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Complétez ce champ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _citationController,
                decoration: const InputDecoration(hintText: "Citation"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez une citation';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User user = User(
                        firstname: _firstnameController.text,
                        lastname: _lastnameController.text,
                        birthday: _birthday,
                        address: _addressController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        gender: _gender,
                        picture: _pictureController.text,
                        citation: _citationController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Utilisateur enregistré')),
                      );

                      await UserDatabase.instance.create(user);
                      //Close keyboard
                      FocusManager.instance.primaryFocus?.unfocus();
                      _formKey.currentState?.reset();

                      setState(() {
                        success = true;
                      });
                    }
                  },
                  child: const Text('Créer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
