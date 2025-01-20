import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_widget.dart';
import 'screens/category_screen.dart';
import 'screens/favourite_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/cart_screen.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/cart_controller.dart';

void main() {
  Get.put(FavoriteController());
  Get.put(CartController());
  runApp(BookStoreApp());
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const HomeScreenContent(),
    CartScreen(), // Make sure CartScreen is properly imported
    Container(), // Placeholder for SettingsScreen
    Container(), // Placeholder for another screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
            color: Colors.white,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by book name or author',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 35, color: Colors.lightBlue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Book Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Get.to(() => CategoryScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
              onTap: () {
                Get.to(() => FavouriteScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Get.to(() => ProfileScreen());
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? HomeScreenContent(searchQuery: searchQuery)
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final String searchQuery;

  const HomeScreenContent({super.key, this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    var filteredBooks = [
      Book(
        title: 'Cozy Friends',
        author: 'Coco Wyo',
        price: 1000.00,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71HEaIuLeUL._AC_UL254_SR254,254_.jpg',
      ),
      Book(
        title: 'James: A Novel',
        author: 'Percival Everett',
        price: 3000.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/715XMbm+NSL._SL1500_.jpg',
      ),
      Book(
        title: 'Elon Musk',
        author: 'Walter Isaacson ',
        price: 2200.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/81Kaj5++6pL._SL1500_.jpg',
      ),
      Book(
        title: 'If Then: How the Simulmatics Corporation Invented the Future',
        author: 'Jill Lepore',
        price: 2800.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/816oPwbcdyL._SL1500_.jpg',
      ),
      Book(
        title: 'The Shadow of the Gods',
        author: 'John Gwynne ',
        price: 3000.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/91jg9ol18KS._AC_UY218_.jpg',
      ),
      Book(
        title: 'Quicksilver: The Fae & Alchemy Series, Book 1',
        author: 'Callie Hart',
        price: 3500.00,
        imageUrl:
            'https://m.media-amazon.com/images/I/91twAM86egL._SL1500_.jpg',
      ),
      Book(
        title: 'Deep Learning with Python',
        author: 'Francois Chollet',
        price: 3200.00,
        imageUrl: 'https://covers.openlibrary.org/b/id/12428638-L.jpg',
      ),
      Book(
        title: 'Eloquent JavaScript: A Modern Introduction to Programming',
        author: 'Marijn Haverbeke',
        price: 1500.00,
        imageUrl: 'https://covers.openlibrary.org/b/id/10427691-L.jpg',
      ),
      Book(
        title: 'Introduction to Algorithms',
        author:
            'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein',
        price: 4500.00,
        imageUrl: 'https://covers.openlibrary.org/b/id/12524620-L.jpg',
      ),
      Book(
        title: 'The Mythical Man-Month: Essays on Software Engineering',
        author: 'Frederick P. Brooks Jr.',
        price: 1800.00,
        imageUrl: 'https://covers.openlibrary.org/b/id/10531987-L.jpg',
      ),
    ].where((book) {
      return book.title.toLowerCase().contains(searchQuery) ||
          book.author.toLowerCase().contains(searchQuery);
    }).toList();

    return Container(
      color: Colors.grey[50], // Add subtle background color
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) => filteredBooks[index],
      ),
    );
  }
}
