import 'dart:convert';

import 'package:dart_codegen_sample/model.dart';

const String source = '''
[
  {
      "active": true,
      "id": "1",
      "message": "One",
      "photoRequired": true
  },
  {
      "active": false,
      "id": "2",
      "message": "Two"
  }
]
''';

void main() =>
  print(
    (jsonDecode(source) as List)
    .cast<Map<String, dynamic>>()
    .map<RefuseEntity>((map) => RefuseEntity.fromJson(map))
    .toList()
  );
