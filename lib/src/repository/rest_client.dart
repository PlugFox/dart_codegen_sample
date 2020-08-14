import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser({@required @Path('id') int id});
}