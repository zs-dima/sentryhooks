import 'dart:async';

import 'package:functions_framework/functions_framework.dart';
import 'package:sentryhooks/src/tool/tool.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'src/router/router.dart';

@CloudFunction(target: 'function')
Future<shelf.Response> sentryHooks(shelf.Request request) => router(request).timeout(
      const Duration(seconds: 7),
      onTimeout: () => HttpResponse.internalServerError('TimeoutException: The operation has timed out in 7 sec.'),
    );
