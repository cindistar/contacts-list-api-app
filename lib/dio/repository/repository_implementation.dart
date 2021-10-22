
import 'package:dio/dio.dart';
import 'package:recente_dio/model/user_model.dart';
import 'package:recente_dio/repository/i_user_repository.dart';

class RepositoryImplementation implements IUserRepository {
  String baseUrl = 'http://10.0.2.2:3000/users';
  final Dio _dio;

  RepositoryImplementation(this._dio);

  @override
  Future<List<UserModel>> getAllUsers({String? query}) async {
    List<UserModel> results = [];
    var response = await _dio.get<List>(baseUrl);
    try {
      if (response.statusCode == 200) {
        results = response.data!.map((e) => UserModel.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
    return results;
  }

  @override
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
  ) async {
    const apiUrl = 'http://10.0.2.2:3000/users';
    final response = await _dio.post(
      apiUrl,
      data: {
        //"id": 12,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "company": company,
        "age": age,
        "address": {"street": street, "city": city},
        "geo": {
          "lat": lat,
          "lng": lng,
        }
      },
      options: Options(
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ),
    );
    // ignore: avoid_print
    print(response.data);
    return response.data;
  }

  @override
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
  ) async {
    final response = await _dio.put(
      'http://10.0.2.2:3000/users/$id',
      data: {
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "company": company,
        "age": age,
        "address": {"street": street, "city": city},
        "geo": {
          "lat": lat,
          "lng": lng,
        }
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update album');
    }
  }

  @override
  Future<void> deletedUser(int id) async {
    await _dio.delete('http://10.0.2.2:3000/users/$id');
  }

// class DioApiService {
//   String url = 'http://10.0.2.2:3000/users';
//   Dio? _dio;

//   DioApiService() {
//     _dio = Dio();
//   }
}
