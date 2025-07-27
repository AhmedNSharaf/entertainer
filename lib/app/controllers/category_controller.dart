import 'package:enter_tainer/core/services/category_service.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/utils/utils.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    mPrint('onInit called');
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      error.value = '';
      categories.value = await CategoryService.fetchCategories();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
