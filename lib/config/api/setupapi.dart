import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
/// Initializes the API configuration by loading the
/// environment variables from a `.env` file that matches the
/// current flavor.
///
/// The file name is determined by concatenating `.env.` with the value
/// of the `FLAVOR` environment variable, or `staging` if
/// it is not set.
///
/// For example, if the `FLAVOR` environment variable is set to
/// `production`, the file name would be `.env.production`.
///
/// The contents of the file are used to override the default values
/// of the environment variables.
  static Future<void> init() async {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'staging');
    await dotenv.load(fileName: '.env.$flavor');
  }


  static String get baseUrl => dotenv.env['API_URL'] ?? '';

/// Returns a fully qualified URL given an endpoint.
///
/// The endpoint should not include a leading slash. If the
/// [baseUrl] does not end with a slash, one will be added.
///
/// For example, if [baseUrl] is "https://example.com" and
/// [endpoint] is "users", the returned URL will be
/// "https://example.com/users".
  static String url(String endpoint) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return '$base$path';
  }
}
