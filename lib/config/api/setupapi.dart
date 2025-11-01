import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static Future<void> init() async {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'staging');
    await dotenv.load(fileName: '.env.$flavor');
  }

  /// อ่านค่าจาก dotenv
  static String get baseUrl => dotenv.env['API_URL'] ?? '';

  /// สร้าง URL จาก endpoint
  static String url(String endpoint) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return '$base$path';
  }
}
