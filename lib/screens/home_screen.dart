// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recente_dio/dio/repository/repository_implementation.dart';
import 'package:recente_dio/model/user_model.dart';
import 'package:recente_dio/screens/add_contact_screen.dart';
import 'package:recente_dio/widgets/card_tile.dart';
import 'package:recente_dio/widgets/palette.dart';
import 'package:recente_dio/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repository = RepositoryImplementation(Dio());

  List<UserModel> _users = [];

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  Future<void> _getAllUsers() async {
    final users = await repository.getAllUsers();
    if (mounted) {
      setState(() => _users = users);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 360, top: 10, bottom: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
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
              child: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchUser());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black45,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 50),
                    margin: const EdgeInsets.all(20),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      repository.deletedUser(_users[index].id!);
                      _getAllUsers();
                    });
                  },
                  child: UserCardTile(
                    name: user.name,
                    photoUrl: user.photoUrl,
                    age: user.age,
                    company: user.company,
                    address: user.address.street,
                    city: user.address.city,
                    email: user.email,
                    updateTodos: _getAllUsers,
                    user: user,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.1),
                      Theme.of(context).scaffoldBackgroundColor,
                    ]),
              ),
            ),
          ),
          Positioned(
            bottom: 60.0,
            child: InkResponse(
              radius: 200,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Palette.purpleRain,
                  borderRadius: BorderRadius.circular(25),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFDAD4D4),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                    ),
                    const BoxShadow(
                      color: Color(0xFFFFFFFF),
                      offset: Offset(-5, -5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          CupertinoIcons.add,
                          size: 21,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Add contact',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddContactScreen(
                      updateTodos: _getAllUsers,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
