import 'package:get/get.dart';
import 'package:quote_app/models/quotes.dart';
import 'package:quote_app/services/api_calls.dart';

class QuoteController extends GetxController {
  Rx<Quote> quote = Quote(a: '', h: '', q: '').obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  fetchData() async {
    isLoading.value = true;
    await APICalls.fetchQuote();
    isLoading.value = false;
  }
}
