import 'package:easydwa/items/Alcohol.dart';
import 'package:easydwa/items/Bakery.dart';
import 'package:easydwa/items/Beverages.dart';
import 'package:easydwa/items/Cannnedfood.dart';
import 'package:easydwa/items/Cereals.dart';
import 'package:easydwa/items/Dairy&Eggs.dart';
import 'package:easydwa/items/Desserts.dart';
import 'package:easydwa/items/Fish.dart';
import 'package:easydwa/items/FrozenFood.dart';
import 'package:easydwa/items/Jam.dart';
import 'package:easydwa/items/Oil&spices.dart';
import 'package:easydwa/items/Snacks.dart';
import 'package:easydwa/items/fruit.dart';
import 'package:easydwa/items/meat.dart';
import 'package:easydwa/items/vegetables.dart';
import 'package:easydwa/pages/Location.dart';
import 'package:easydwa/pages/Cartpage.dart';
import 'package:easydwa/pages/Settings.dart';
import 'package:easydwa/pages/item_search.dart';
import 'package:easydwa/screens/Menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;
  bool isFiltered = false;

  ThemeData get themeData => _isDarkMode
      ? ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green[800], // dark green theme
        )
      : ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
        );

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
        menu: Menu(
          isDarkMode: _isDarkMode,
        ),
        screenSelectedBuilder: (position, controller) {
          return Theme(
            data: themeData,
            child: Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    color: _isDarkMode
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Colors.white,
                    onPressed: () => controller.toggle(),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: _isDarkMode
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      ); // Implement navigation to cart
                    },
                  ),
                ],
                backgroundColor: _isDarkMode
                    ? Color.fromARGB(255, 62, 61, 61)
                    : Colors.green,
              ),
              body: Column(
                children: [
                  if (isFiltered)
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.color,
                      ),
                      child: buildImageContainer(),
                    )
                  else
                    buildImageContainer(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: _isDarkMode ? Color.fromARGB(255, 50, 54, 50) : Colors.white,
                          hintText: 'Search...',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                        onTap: () async {
                          final List<String> allItems = [
                                      'Fruits',
                                      'Vegetables',
                                      'Meat',
                                      'Dairy & Eggs',
                                      'Bakery',
                                      'Canned Foods',
                                      'Beverages',
                                      'Snacks',
                                      'Frozen foods',
                                      'Desserts',
                                      'Oil & Spices',
                                      'Fish',
                                      'Alcohol',
                                      'Jam',
                                      'Cereals',
                                    ];  // Use your list of all items.
                           await showSearch(
                                  context: context,
                                  delegate: ItemSearch(allItems),
                                );
                        },
                      ),
                    ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryCard(index: index);
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: _isDarkMode
                    ? Color.fromARGB(255, 59, 57, 57)
                    : const Color.fromARGB(255, 255, 255, 255),
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home,
                            color: _isDarkMode
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.green),
                        onPressed: () {
                          Get.to(LocationPage(),
                              transition: Transition.circularReveal);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.settings,
                            color: _isDarkMode
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.green),
                        onPressed: () {
                          Get.to(SettingsPage(),
                              transition: Transition.rightToLeftWithFade);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          _isDarkMode ? Icons.brightness_7 : Icons.brightness_6,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _isDarkMode = !_isDarkMode;
                            isFiltered = !isFiltered;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Container buildImageContainer() {
    return Container(
      height: 250,
      width: double.infinity,
      child: Image.asset(
        'assets/dwapage.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int index;
  final List<String> categories = [
    'Fruits',
    'Vegetables',
    'Meat',
    'Dairy & Eggs',
    'Bakery',
    'Canned Foods',
    'Beverages',
    'Snacks',
    'Frozen foods',
    'Desserts',
    'Oil & Spices',
    'Fish',
    'Alcohol',
    'Jam',
    'Cereals',
  ];

  final List<Widget Function(BuildContext)> categoryPages = [
    (context) => FruitsPage()
  ];

  static final List<String> imagePaths = [
    'assets/fruits.jpg',
    'assets/vegetables.jpg',
    'assets/Meat.jpg',
    'assets/dairy & eggs.jpg',
    'assets/bakery.jpg',
    'assets/canned foods.jpg',
    'assets/beverages.jpg',
    'assets/snacks.jpg',
    'assets/Frozen foods.jpg',
    'assets/Desserts.jpg',
    'assets/oil & spices.jpg',
    'assets/Fish.jpg',
    'assets/alcohol.jpg',
    'assets/jams.jpg',
    'assets/cereals.jpg',

    //... (continue with all paths for your images)
  ];

  CategoryCard({required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        if (categories[index] == 'Fruits') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FruitsPage()),
          );
        } else if (categories[index] == 'Vegetables') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VegetablesPage()),
          );
        } else if (categories[index] == 'Meat') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeatsPage()),
          );
        } else if (categories[index] == 'Dairy & Eggs') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DairysPage()),
          );
        } else if (categories[index] == 'Bakery') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BakerysPage()),
          );
        } else if (categories[index] == 'Canned Foods') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CannedPage()),
          );
        } else if (categories[index] == 'Beverages') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BeveragesPage()),
          );
        } else if (categories[index] == 'Snacks') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SnacksPage()),
          );
        } else if (categories[index] == 'Frozen foods') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FrozenPage()),
          );
        } else if (categories[index] == 'Desserts') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DessertsPage()),
          );
        } else if (categories[index] == 'Oil & Spices') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OilPage()),
          );
        } else if (categories[index] == 'Fish') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FishPage()),
          );
        } else if (categories[index] == 'Alcohol') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlcoholPage()),
          );
        } else if (categories[index] == 'Jam') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JamPage()),
          );
        } else if (categories[index] == 'Cereals') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CerealsPage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(category: categories[index])),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePaths[index]),
            fit: BoxFit.contain,
          ),
          boxShadow: [
            // Adding the drop shadow effect
            BoxShadow(
              color: Colors.grey.withOpacity(0.05), // Adjust opacity as needed
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // Changes the position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              color:
                  isDarkMode ? Color.fromARGB(255, 50, 49, 49) : Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final String category;

  ProductPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.green,
      ),
      // ... Further design for Product Page
    );
  }
}
