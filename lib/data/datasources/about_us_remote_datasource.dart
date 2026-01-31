import 'package:dio/dio.dart';
import '../models/about_response_model.dart';

class AboutRemoteDatasource {
  final Dio dio;

  AboutRemoteDatasource(this.dio);

  Future<AboutResponseModel> getAbout() async {
    final response = await dio.get('/about-us');
    return AboutResponseModel.fromMap(response.data['data']);
  }
}
