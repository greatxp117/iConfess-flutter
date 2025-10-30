import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// OpenAI client configuration and helpers.
///
/// IMPORTANT:
/// - API key and endpoint are provided via environment at runtime.
/// - Do not use the legacy chat/completions path; use the Responses API.
class OpenAIClient {
  static const String _apiKey = String.fromEnvironment('OPENAI_PROXY_API_KEY');
  static const String _endpoint = String.fromEnvironment('OPENAI_PROXY_ENDPOINT');

  /// Generates a reverent Catholic prayer for the given topic.
  /// Uses gpt-4o-mini via the Responses API.
  static Future<String> generatePrayer({required String topic}) async {
    if (_apiKey.isEmpty || _endpoint.isEmpty) {
      throw Exception('OpenAI is not configured. Missing endpoint or API key.');
    }

    final uri = Uri.parse(_normalizeEndpoint(_endpoint));

    final prompt = _buildPrayerPrompt(topic);
    final body = <String, dynamic>{
      'model': 'gpt-4o-mini',
      'input': prompt,
    };

    final res = await http
        .post(
          uri,
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: utf8.encode(jsonEncode(body)),
        )
        .timeout(const Duration(seconds: 25));

    if (res.statusCode != 200) {
      String details = res.body;
      try {
        final err = jsonDecode(utf8.decode(res.bodyBytes));
        details = err.toString();
      } catch (_) {}
      throw Exception('OpenAI request failed (${res.statusCode}): $details');
    }

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    final text = _extractText(data);
    if (text == null || text.trim().isEmpty) {
      throw Exception('OpenAI returned an empty response');
    }
    return text.trim();
  }

  static String _normalizeEndpoint(String endpoint) {
    // Ensure we are calling the Responses API. Endpoint can be provided as base
    // or full path. We'll append /v1/responses if not already present.
    final e = endpoint.trim();
    if (e.endsWith('/v1/responses') || e.endsWith('/v1/responses/')) return e;
    final base = e.endsWith('/') ? e.substring(0, e.length - 1) : e;
    return '$base/v1/responses';
  }

  static String _buildPrayerPrompt(String topic) {
    return '''You are a Catholic spiritual assistant. Compose a short, reverent prayer addressed to God for the intention: "$topic".

Constraints:
- Tone: faithful, pastoral, and hopeful; avoid therapeutic jargon.
- Optional: include a brief Scripture resonance if natural (no verse citations required).
- Length: about 120–200 words.
- Structure: brief invocation, specific petition, trustful surrender, closing through Christ and a clear "Amen".
- Do not add prefatory remarks or meta text. Output only the prayer text.''';
  }

  /// Attempts to extract plain text from various OpenAI response shapes.
  static String? _extractText(dynamic data) {
    try {
      // Responses API canonical: output[0].content[0].text
      final output = data['output'];
      if (output is List && output.isNotEmpty) {
        final content = output.first['content'];
        if (content is List && content.isNotEmpty) {
          // Find first item with text
          for (final c in content) {
            if (c is Map && c['text'] is String) return c['text'] as String;
            if (c is Map && c['type'] == 'output_text' && c['text'] is String) {
              return c['text'] as String;
            }
          }
        }
      }
      // Some proxies: response.content[0].text
      final response = data['response'];
      if (response is Map) {
        final content = response['content'];
        if (content is List && content.isNotEmpty) {
          final first = content.first;
          if (first is Map && first['text'] is String) return first['text'] as String;
        }
      }
      // Fallback to choices[].message.content (legacy shape)
      final choices = data['choices'];
      if (choices is List && choices.isNotEmpty) {
        final msg = choices.first['message'];
        if (msg is Map && msg['content'] is String) return msg['content'] as String;
      }
    } catch (_) {}
    return null;
  }
}
