import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neuss_utils/utils/helpers.dart';

Future<void> registerUser({
  required String username,
  required String email,
  required String password,
}) async {
  final url = Uri.parse(
    'http://10.0.2.2:5000/api/users/register',
  ); // 🔁 غيّر الرابط حسب API بتاعك

  final body = jsonEncode({
    "username": username,
    "email": email,
    "password": password,
    "group": "customer", // ثابت حسب المطلوب منك
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      mPrint('✅ Registration successful: $data');
    } else {
      mPrint('❌ Registration failed: ${response.statusCode}');
      mPrint('Response: ${response.body}');
    }
  } catch (e) {
    mPrint('⚠️ Error occurred: $e');
  }
}
