import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recente_dio/dio/repository/repository_implementation.dart';
import 'package:recente_dio/model/user_model.dart';
import 'package:recente_dio/widgets/palette.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key, required this.updateTodos, this.user})
      : super(key: key);

  final VoidCallback updateTodos;
  final UserModel? user;

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final repository = RepositoryImplementation(Dio());

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _photoUrlController;
  late TextEditingController _companyController;
  late TextEditingController _ageController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  UserModel? _user;
  Address? address;
  Geo? geo;

  bool get _isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _user = widget.user;
    } else {
      _user = UserModel(
        name: '',
        email: '',
        photoUrl: '',
        age: 0,
        company: '',
        address: Address(
          street: '',
          city: '',
        ),
        geo: Geo(
          lat: '',
          lng: '',
        ),
      );
    }
    _nameController = TextEditingController(text: _user!.name);
    _emailController = TextEditingController(text: _user!.email);
    _photoUrlController = TextEditingController(text: _user!.photoUrl);
    _companyController = TextEditingController(text: _user!.company);
    _ageController = TextEditingController(text: _user!.age.toString());
    _streetController = TextEditingController(text: _user!.address.street);
    _cityController = TextEditingController(text: _user!.address.city);
    _latitudeController = TextEditingController(text: _user!.geo.lat);
    _longitudeController = TextEditingController(text: _user!.geo.lng);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _photoUrlController.dispose();
    _companyController.dispose();
    _ageController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF5F5F5),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    !_isEditing ? 'Add Contact' : 'Update Contact',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: const Color(0xffb734eb),
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Color(0xff9633ff),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xffb734eb),
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (name) =>
                          name!.trim().isEmpty ? 'Enter a name' : null,
                      onSaved: (name) => _user = _user!.copyWith(name: name),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) =>
                        email!.trim().isEmpty ? 'Enter a email' : null,
                    onSaved: (email) => _user = _user!.copyWith(email: email),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _photoUrlController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Photo URL',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (photo) =>
                        photo!.trim().isEmpty ? 'Enter a photo URL' : null,
                    onSaved: (photo) =>
                        _user = _user!.copyWith(photoUrl: photo),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _companyController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (company) =>
                        company!.trim().isEmpty ? 'Enter a company name' : null,
                    onSaved: (company) =>
                        _user = _user!.copyWith(company: company),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _ageController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (age) =>
                        age!.trim().isEmpty ? 'Enter your age' : null,
                    onSaved: (age) => _user = _user!.copyWith(
                      age: int.parse(age!),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _streetController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Address | Street',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (street) =>
                        street!.trim().isEmpty ? 'Enter a street name ' : null,
                    onSaved: (street) => _user = _user!.copyWith(
                      address: Address(
                        street: street,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _cityController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (city) =>
                        city!.trim().isEmpty ? 'Enter a city name' : null,
                    onSaved: (city) => _user = _user!.copyWith(
                      address: Address(
                        city: city,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _latitudeController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (latitude) =>
                        latitude!.trim().isEmpty ? 'Enter a latitude' : null,
                    onSaved: (latitude) => _user = _user!.copyWith(
                      geo: Geo(
                        lat: latitude,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: _longitudeController,
                    cursorColor: const Color(0xffb734eb),
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      labelStyle: TextStyle(
                        color: Color(0xff9633ff),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xffb734eb),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (longitude) =>
                        longitude!.trim().isEmpty ? 'Enter a longitude' : null,
                    onSaved: (longitude) => _user = _user!.copyWith(
                      geo: Geo(
                        lng: longitude,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              primary: !_isEditing
                                  ? Palette.purpleRain
                                  : const Color(0xff9633ff),
                            ),
                            child: Text(
                              !_isEditing ? 'Add' : 'Save',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFDAD4D4),
                                offset: Offset(5, 5),
                                blurRadius: 5,
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF),
                                offset: Offset(-5, -5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (!_isEditing) {
        repository.postUser(
          _nameController.text,
          _emailController.text,
          _photoUrlController.text,
          _companyController.text,
          int.parse(_ageController.text),
          _streetController.text,
          _cityController.text,
          _latitudeController.text,
          _longitudeController.text,
        );
      } else {
        repository.putUser(
          _user!.id!,
          _nameController.text,
          _emailController.text,
          _photoUrlController.text,
          _companyController.text,
          int.parse(_ageController.text),
          _streetController.text,
          _cityController.text,
          _latitudeController.text,
          _longitudeController.text,
        );
      }
      widget.updateTodos();
      Navigator.of(context).pop();
    }
  }
}
