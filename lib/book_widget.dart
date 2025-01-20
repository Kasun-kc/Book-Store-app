import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_details_page.dart';
import 'controllers/cart_controller.dart';
import 'controllers/favorite_controller.dart';

class Book extends StatelessWidget {
  final String title;
  final String author;
  final double price;
  final String imageUrl;

  const Book({
    super.key,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();
    final cartController = Get.find<CartController>();

    return InkWell(
      onTap: () {
        Get.to(
          () => BookDetailsPage(
            title: title,
            author: author,
            price: price,
            imageUrl: imageUrl,
            description: '''
This comprehensive guide covers everything you need to know about $title. 
Written by $author, this book provides in-depth knowledge and practical examples to help you master the subject.

Key Features:
• Comprehensive coverage of all topics
• Step-by-step practical examples
• Best practices and patterns
• Real-world use cases and solutions
• Expert insights and tips

Perfect for both beginners and experienced developers looking to expand their knowledge.
''',
          ),
          transition: Transition.rightToLeft,
        );
      },
      child: Card(
        elevation: 3, // Slightly increased elevation
        margin: EdgeInsets.symmetric(
            horizontal: 6, vertical: 6), // Increased margin
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Increased border radius
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: 'book-$title',
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[100],
                              child: Icon(Icons.book,
                                  size: 40, color: Colors.grey[400]),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(10, 8, 10, 8), // Adjusted padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 3),
                              Text(
                                'by $author',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  height: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'LKR ${price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 28, // Increased height
                          child: ElevatedButton(
                            onPressed: () {
                              cartController.addToCart(this);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Obx(
                () => CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      favoriteController.isFavorite(this)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteController.isFavorite(this)
                          ? Colors.red
                          : Colors.blueGrey,
                    ),
                    onPressed: () {
                      favoriteController.toggleFavorite(this);
                      Get.snackbar(
                        'Success',
                        favoriteController.isFavorite(this)
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
