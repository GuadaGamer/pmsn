// ignore: file_names
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController dateCtl = TextEditingController();
  DateTime? _selectedDate;
  File? image;

  final txtMail = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.mail),
        labelText: 'correo@example.com',
        helperText: 'Escribe tu correo',
        border: OutlineInputBorder(),
        isDense: false,
        contentPadding: EdgeInsets.all(10)),
    validator: (value) => EmailValidator.validate(value!)
        ? null
        : "Por favor ingresa un correo valido",
  );

  final txtUser = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.account_box),
        labelText: 'Nombre de usuario',
        helperText: 'Escribe tu nombre de usuario',
        border: OutlineInputBorder(),
        isDense: false,
        contentPadding: EdgeInsets.all(10)),
    validator: (value) {
      if (value!.isEmpty || value.length <= 5) {
        return 'Proporciona un nombre valido mayor a 5';
      }
      return null;
    },
  );

  final password = TextFormField(
    decoration: const InputDecoration(
        icon: Icon(Icons.password),
        labelText: 'Password',
        helperText: 'Examp3le#1',
        border: OutlineInputBorder(),
        isDense: false,
        contentPadding: EdgeInsets.all(10)),
    obscureText: true,
    validator: (value) {
      RegExp regex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~?]).{8,}$');
      if (value!.isEmpty) {
        return "Por favor completa este campo";
      } else {
        if (!regex.hasMatch(value)) {
          return "Tu contraseña no es segura";
        } else {
          return null;
        }
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final fecha = TextFormField(
      controller: dateCtl,
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        icon: Icon(Icons.date_range),
        labelText: 'Fecha de nacimiento',
        helperText: 'Selecciona tu fecha de nacimiento',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(10),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Por favor completa este campo";
        }
        return null;
      },
    );

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Card(
                elevation: 16.0,
                shadowColor: Colors.deepPurple,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(
                        Icons.fact_check,
                        color: Color.fromARGB(255, 49, 109, 51),
                        size: 150,
                      ),
                      const Center(
                        child: Text(
                          'SingUp Registro',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 49, 109, 51),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey,
                        child: image != null
                            ? Image.network(image!.path, fit: BoxFit.cover)
                            : const Text('Por favor selecciona una imagen'),
                      ),
                      ElevatedButton(
                          onPressed: () => pickImage(ImageSource.gallery),
                          child: const Icon(Icons.image)),
                      ElevatedButton(
                          onPressed: () => pickImage(ImageSource.camera),
                          child: const Icon(Icons.camera)),
                      const SizedBox(
                        height: 15,
                      ),
                      txtUser,
                      const SizedBox(
                        height: 15,
                      ),
                      fecha,
                      const SizedBox(
                        height: 15,
                      ),
                      txtMail,
                      const SizedBox(
                        height: 15,
                      ),
                      password,
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/dash');
                            }
                          },
                          child: const Text('SignUp')),
                    ],
                  ),
                ))));
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color.fromARGB(255, 255, 255, 102),
                onPrimary: Color.fromARGB(255, 153, 51, 255),
                surface: Color.fromARGB(255, 97, 139, 96),
                onSurface: Color.fromARGB(255, 255, 102, 0),
              ),
              dialogBackgroundColor: const Color.fromARGB(255, 49, 109, 51),
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateCtl
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateCtl.text.length, affinity: TextAffinity.upstream));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    XFile? xFileImage = await _imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        image = File(xFileImage.path);
      });
    }
  }
}
