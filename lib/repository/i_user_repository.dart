import 'package:recente_dio/model/user_model.dart';

abstract class IUserRepository {
  // get
  Future<List<UserModel>> getAllUsers();

  // post
  Future postUser(
    String name,
    String email,
    String photoUrl,
    String company,
    int age,
    String street,
    String city,
    String lat,
    String lng,
  );

  // put
  Future putUser(
    int id,
    String name,
    String email,
    String photoUrl,
    String company,
    int age,
    String street,
    String city,
    String lat,
    String lng,
  );

  // delete
  Future<void> deletedUser(int id);
}
