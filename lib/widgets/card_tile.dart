import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recente_dio/model/user_model.dart';
import 'package:recente_dio/screens/add_contact_screen.dart';

class UserCardTile extends StatelessWidget {
  final String name;
  final String photoUrl;
  final int age;
  final String company;
  final String? city;
  final String? address;
  final String email;
  final VoidCallback updateTodos;
  final UserModel user;

  const UserCardTile({
    Key? key,
    required this.name,
    required this.photoUrl,
    required this.age,
    required this.company,
    this.city,
    this.address,
    required this.email,
    required this.updateTodos,
    required this.user,

    // required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          //clipBehavior: ,
          children: [
            Container(
              height: 250,
              width: double.infinity,
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
            Positioned(
              top: 60,
              left: 20,
              child: circleAvatarImage(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150, top: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Age $age',
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      //color: Colors.black45,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '💼  $company ',
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '🏠  $address',
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '📍  $city',
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            Positioned(
              top: 210,
              left: 20,
              child: Text(
                '📧  $email',
                style: const TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: InkResponse(
                radius: 50,
                child: SizedBox(
                  height: 47,
                  width: 30,
                  child: Image.asset(
                    'assets/pin-art.png',
                    fit: BoxFit.fill,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => AddContactScreen(
            updateTodos: updateTodos,
            user: user,
          ),
        ),
      ),
    );
  }

  Widget circleAvatarImage() {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
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
      child: CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
      ),
    );
  }
}
