import 'dart:async';
import 'dart:io';

import 'package:sentryhooks/src/converter/telegram.dart';
import 'package:sentryhooks/src/tool/tool.dart';
import 'package:shelf/shelf.dart' as shelf;

Future<shelf.Response> router(shelf.Request request) {
  if (request.method != 'POST') return Future.value(HttpResponse.notFound);
  // todo move 'code' check to the middleware
  final urlCode = request.url.queryParameters['code'] ?? '';
  if (urlCode.isNotEmpty && urlCode != Platform.environment['CODE']) return Future.value(HttpResponse.notFound);

  try {
    final path = request.url.path.trim().toLowerCase();
    switch (path) {
      case 'telegram':
        return telegram(request);
      case '':
      case '/':
      default:
        return Future.value(HttpResponse.notFound);
    }
  } on Object catch (error) {
    return Future.value(HttpResponse.internalServerError(error));
  }
}
