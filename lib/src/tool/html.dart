import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;

class HttpResponse {
  static shelf.Response get ok {
    return shelf.Response.ok(
      'Ok',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-cache',
      },
    );
  }

  static shelf.Response get notFound {
    final bytes = jsonEncode(<String, Object>{
      'error': 'Not found',
    }).codeUnits;
    return shelf.Response.notFound(
      bytes,
      headers: <String, String>{
        'Content-Length': bytes.length.toString(),
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-cache',
      },
    );
  }

  static shelf.Response internalServerError(Object error) {
    final bytes = jsonEncode(<String, Object>{
      'error': error.toString(),
    }).codeUnits;
    return shelf.Response.internalServerError(
      body: bytes,
      headers: <String, String>{
        'Content-Length': bytes.length.toString(),
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-cache',
      },
    );
  }
}
