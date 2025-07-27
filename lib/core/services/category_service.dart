import 'dart:convert';
import 'package:enter_tainer/app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:neuss_utils/utils/utils.dart';

class CategoryService {
static const String baseUrl = 'http://10.0.2.2:5000/api/categories';

  static Future<List<CategoryModel>> fetchCategories() async {
  final response = await http.get(Uri.parse(baseUrl));

  mPrint('Status Code: ${response.statusCode}');
  mPrint('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    try {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      mPrint('JSON Error: $e');
      throw Exception('Invalid JSON format: ${response.body}');
    }
  } else {
    throw Exception('Failed with status code: ${response.statusCode}');
  }
}

}
