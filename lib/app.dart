import 'dart:async';

import 'package:dio/dio.dart';
import 'src/repository/rest_client.dart';

Future<void> run() =>
    runZoned(() async {
      final client = RestClient(Dio());
      final users = await client.getUsers();
      final user = await client.getUser(id: users.last.id);
      print(user.toJson()); // ignore: avoid_print
    },
      // ignore: avoid_types_on_closure_parameters, avoid_print
      onError: (Object error, StackTrace stackTrace) =>
          print('Top level exception: $error')
    );