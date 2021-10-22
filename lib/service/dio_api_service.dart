import 'package:dio/dio.dart';
import 'package:recente_dio/model/user_model.dart';

class DioApiService {
  String url = 'http://10.0.2.2:3000/users';
  Dio? _dio;

  DioApiService() {
    _dio = Dio();
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _dio!.get<List>(url);
      return response.data!.map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
