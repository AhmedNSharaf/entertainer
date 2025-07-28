import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neuss_utils/utils/helpers.dart';

Future<bool> verifyOtp({
  required String email,
  required String otp,
}) async {
  final url = Uri.parse('http://10.0.2.2:5000/api/users/auth/verify-otp'); // 🔁 عدل الرابط

  final body = jsonEncode({
    'email': email,
    'otp': otp,
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      mPrint('✅ OTP Verified: ${data['message']}');
      return true;
    } else {
      mPrint('❌ OTP Verification failed: ${response.body}');
      return false;
    }
  } catch (e) {
    mPrint('⚠️ Error during OTP verification: $e');
    return false;
  }
}
