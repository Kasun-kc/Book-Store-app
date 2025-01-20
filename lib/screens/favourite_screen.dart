import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/cart_controller.dart';

class FavouriteScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final CartController cartController = Get.find<CartController>();

  FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          Obx(() => Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    '${favoriteController.favoriteBooks.length} items',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
        ],
      ),
      body: Obx(
        () => favoriteController.favoriteBooks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 80, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'No favourites yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add items to your favourites',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  // Add hint message for swipe functionality
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.grey[50],
                    child: Row(
                      children: [
                        Icon(
                          Icons.swipe_left_alt,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Swipe left to remove from favorites',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: favoriteController.favoriteBooks.length,
                      itemBuilder: (context, index) {
                        final book = favoriteController.favoriteBooks[index];
                        return Dismissible(
                          key: Key(book.title),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            favoriteController.toggleFavorite(book);
                            Get.snackbar(
                              'Removed from Favourites',
                              '${book.title} has been removed',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                            );
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 2),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: Hero(
                                tag: 'book-${book.title}-fav',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    book.imageUrl,
                                    width: 60,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                book.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'by ${book.author}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'LKR ${book.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.shopping_cart_outlined),
                                onPressed: () {
                                  cartController.addToCart(book);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
