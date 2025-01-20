import 'package:get/get.dart';
import '../book_widget.dart';

class CartController extends GetxController {
  final RxList<Book> cartItems = <Book>[].obs;
  final RxDouble total = 0.0.obs;

  void addToCart(Book book) {
    cartItems.add(book);
    calculateTotal();
    Get.snackbar(
      'Success',
      '${book.title} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeFromCart(Book book) {
    cartItems.remove(book);
    calculateTotal();
  }

  void calculateTotal() {
    total.value = cartItems.fold(0, (sum, book) => sum + book.price);
  }
}
