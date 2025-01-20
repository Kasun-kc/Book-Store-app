import 'package:get/get.dart';
import '../book_widget.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find();
  final RxList<Book> favoriteBooks = <Book>[].obs;

  void toggleFavorite(Book book) {
    if (favoriteBooks.contains(book)) {
      favoriteBooks.remove(book);
    } else {
      favoriteBooks.add(book);
    }
  }

  bool isFavorite(Book book) {
    return favoriteBooks.contains(book);
  }
}
