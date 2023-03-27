// ignore: file_names
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:psmnn/firebase/firebase_emailauth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController emailUser = TextEditingController();
  TextEditingController passwordUser = TextEditingController();
  EmailAuth? emailAuth;
  DateTime? _selectedDate;
  File? pickedImage;

  bool circular = false;

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

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      controller: emailUser,
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
      controller: passwordUser,
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
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&/¿*~?_-]).{8,}$');
        if (value!.isEmpty) {
          return "Por favor completa este campo";
        } else {
          if (!regex.hasMatch(value)) {
            return "Tu contraseña debe contener por lo menos: \n8 digitos\n1 Mayuscula\n1 minuscula\n1 numero\n1 caracter especial";
          } else {
            return null;
          }
        }
      },
    );

    void imagePickerOption() {
      Get.bottomSheet(
        SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Pic Image From",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("CAMERA"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text("CANCEL"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: .4,
                fit: BoxFit.fill,
                image: AssetImage('assets/fondo.webp'))),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SafeArea(child: Container()),
            Form(
                key: _formKey,
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
                          /*Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey,
                                child: image != null
                                    ? Image.asset(image!.path, fit: BoxFit.cover)
                                    : const Text('Por favor selecciona una imagen'),
                              ),
                              ElevatedButton(
                                  onPressed: () => pickImage(ImageSource.gallery),
                                  child: const Icon(Icons.image)),
                              ElevatedButton(
                                  onPressed: () => pickImage(ImageSource.camera),
                                  child: const Icon(Icons.camera)),*/
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 49, 109, 51),
                                        width: 5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: pickedImage != null
                                        ? Image.file(
                                            pickedImage!,
                                            width: 170,
                                            height: 170,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/profile.png',
                                            width: 170,
                                            height: 170,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: imagePickerOption,
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Color.fromARGB(255, 49, 109, 51),
                                        size: 30,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                                onPressed: imagePickerOption,
                                icon: const Icon(Icons.add_a_photo_sharp),
                                label: const Text('Añadir imagen')),
                          ),
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
                                //puede que haga falta inicializar
                                if (_formKey.currentState!.validate()) {
                                  emailAuth!.createUserWithEmailAndPassword(
                                      email: emailUser.text,
                                      password: passwordUser.text);
                                  Navigator.pushNamed(context, '/dash');
                                }
                              },
                              child: const Text('SignUp')),
                        ],
                      ),
                    ))),
          ],
        )),
      ),
    );
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

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
