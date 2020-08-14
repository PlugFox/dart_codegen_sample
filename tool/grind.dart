import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

import 'package:grinder/grinder.dart';

void main(List<String> args) => grind(args);

String get pub => io.Platform.isWindows
    ? 'pub.bat'
    : 'pub';

@DefaultTask('Gen')
Future<void> gen() =>
    _run('$pub run build_runner build --delete-conflicting-outputs');

@Task('Get')
@Depends(upgrade)
Future<void> get() =>
    _run('$pub get');

@Task('Upgrade')
Future<void> upgrade() =>
    _run('$pub upgrade');

@Task('Outdated')
@Depends(get)
Future<void> outdated() =>
    _run('$pub outdated');

@Task('Performs the static analysis of source code')
@Depends(gen)
Future<void> lint() =>
    _run('$pub analyze --no-pub --congratulate --current-package --preamble');

@Task('Performs the static analysis of source code')
@Depends(gen)
Future<void> test() {
  //existingSourceDirs;
  if (!io.Directory('test').existsSync()) return Future<void>.value(null);
  final files = io.Directory('test')
      .listSync(recursive: false)
      .whereType<io.File>()
      .where((file) => path.extension(file.path)
      .toLowerCase().endsWith('.dart'));
  if (files.isEmpty) {
    return Future<void>.value(null);
  } else if (files.length == 1) {
    return _run('$pub run test --no-pub --coverage --concurrency=6 ${path.normalize('test/${path.basename(files.first.path)}')}');
  } else {
    return _run('$pub run test --no-pub --coverage --concurrency=6 ${path.normalize('test/')}');
  }
}

Future<void> _run(String executable) async {
  final commands = executable.split(' ').where((element) => element.isNotEmpty).toList(growable: true);
  return io.Process.start(
    commands.first,
    commands.sublist(1),
  ).then((process) =>
      Future.wait<void>([
        process.stdout.forEach((message) {
          log(utf8.decode(message));
        }),
        process.stderr.forEach((message) {
          log('\x1B[31m${utf8.decode(message)}\x1B[0m');
        }),
      ]));
}
