import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Register a new user
  Future<bool> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/register');

    final body = jsonEncode({
      "username": username,
      "email": email,
      "password": password,
      "group": {"name": "customer"},
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  /// Verify OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    final url = Uri.parse('$baseUrl/users/auth/verify-otp');

    final body = jsonEncode({'email': email, 'otp': otp});

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response.statusCode == 200;
    } catch (e) {
      print('OTP verify error: $e');
      return false;
    }
  }

  /// إعادة إرسال OTP
  Future<bool> resendOtp({required String email}) async {
    final url = Uri.parse('$baseUrl/users/auth/resend-otp');

    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      
      if (response.statusCode == 200) {
        print('OTP resent successfully');
        return true;
      } else {
        print('Resend OTP failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Resend OTP error: $e');
      return false;
    }
  }

  /// Login with email & password
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/auth/login');

    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  /// ✅ Logout user - تحديث للتعامل مع رد السيرفر الصحيح
  Future<Map<String, dynamic>?> logoutUser(String email) async {
    final url = Uri.parse('$baseUrl/users/auth/logout');

    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      
      print('Logout response status: ${response.statusCode}');
      print('Logout response body: ${response.body}');

      if (response.statusCode == 200) {
        // ✅ إرجاع البيانات المستلمة من السيرفر
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print('Logout failed with status: ${response.statusCode}');
        print('Logout error response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Logout error: $e');
      return null;
    }
  }
}