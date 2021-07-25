import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sentryhooks/src/tool/tool.dart';
import 'package:shelf/shelf.dart' as shelf;

Future<shelf.Response> telegram(shelf.Request webHookData) async {
  final json = await webHookData.readAsString();
  final data = jsonDecode(json);

  // event.metadata.value
  final String? message = data['data']?['event']?['title']?.replaceAll('_Exception: Exception: ', 'Exception: ');
  final String? project = data['data']?['triggered_rule'];
  final String? culprit = data['data']?['event']?['culprit'];
  final String? url = data['data']?['event']?['web_url'];

  if (message == null || message.isEmpty) {
    // Sentry WebHook had not been found
    return HttpResponse.notFound;
  }

  final htmlEscape = HtmlEscape();
  final telegramUrl = 'https://api.telegram.org/bot${Platform.environment['TELEGRAM_TOKEN']}/sendMessage';
  final telegramMessage = {
    'chat_id': Platform.environment['TELEGRAM_CHAT'],
    'parse_mode': 'html', // <i></i><code></code>
    'text': '<b>$project</b>\n<a href="$url">${htmlEscape.convert(culprit ?? 'info')}</a>\n${htmlEscape.convert(message)}'
  };

  final response = await http
      .post(
        Uri.parse(telegramUrl),
        body: telegramMessage,
        encoding: utf8,
      )
      .timeout(const Duration(seconds: 7));

  if (response.statusCode != 200) throw UnsupportedError('Exception on telegram sendMessage, Status code from ${response.statusCode}');

  return HttpResponse.ok;
}
