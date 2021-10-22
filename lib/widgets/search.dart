import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recente_dio/dio/repository/repository_implementation.dart';
import 'package:recente_dio/widgets/card_tile.dart';

class SearchUser extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final repository = RepositoryImplementation(Dio());

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder<List>(
        future: repository.getAllUsers(query: query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return UserCardTile(
                  name: user.name,
                  photoUrl: user.photoUrl,
                  age: user.age,
                  company: user.company,
                  address: user.address.street,
                  city: user.address.city,
                  email: user.email,
                  updateTodos: () {},
                  user: user,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Users'),
    );
  }
}
