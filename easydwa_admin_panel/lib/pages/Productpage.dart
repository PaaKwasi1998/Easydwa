import 'dart:io';

import 'package:easydwa_admin_panel/Items/Alcohol.dart';
import 'package:easydwa_admin_panel/Items/Bakery.dart';
import 'package:easydwa_admin_panel/Items/Beverages.dart';
import 'package:easydwa_admin_panel/Items/Canned%20Foods.dart';
import 'package:easydwa_admin_panel/Items/Cereals.dart';
import 'package:easydwa_admin_panel/Items/Dairy%20&%20Eggs.dart';
import 'package:easydwa_admin_panel/Items/Desserts.dart';
import 'package:easydwa_admin_panel/Items/Fish.dart';
import 'package:easydwa_admin_panel/Items/Frozen%20foods.dart';
import 'package:easydwa_admin_panel/Items/Fruits.dart';
import 'package:easydwa_admin_panel/Items/Jam.dart';
import 'package:easydwa_admin_panel/Items/Meat.dart';
import 'package:easydwa_admin_panel/Items/Oil%20&%20Spices.dart';
import 'package:easydwa_admin_panel/Items/Snacks.dart';
import 'package:easydwa_admin_panel/Items/Vegetable.dart';
import 'package:easydwa_admin_panel/pages/Inbox.dart';
import 'package:easydwa_admin_panel/pages/LoginPage.dart';
import 'package:easydwa_admin_panel/pages/Sidebar.dart';
import 'package:easydwa_admin_panel/pages/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminProductPage extends StatefulWidget {
  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  List<_ProductCategory> _productCategories = CategoryProvider().categories;
  late CategoryProvider categoryProvider;

  final TextEditingController _productNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _categoryImageFile;

  void _pickCategoryImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (selected != null) {
        _categoryImageFile = File(selected.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    _productCategories = categoryProvider.categories;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Product Page'),
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton<String>(
            child: CircleAvatar(
              radius: 22.0,
              backgroundImage: selectedImagePath != null
                  ? FileImage(File(selectedImagePath!))
                  : AssetImage('assets/profile.jpg') as ImageProvider<Object>,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'Profile':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  break;
                case 'Inbox':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InboxPage()));
                  break;
                case 'Logout':
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Inbox',
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('Inbox'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: SideBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildProductGrid(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCategory,
        child: Icon(Icons.add),
        tooltip: 'Add New Category',
      ),
    );
  }

  void _addNewCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Category Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(hintText: 'Product Name'),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: _categoryImageFile != null
                  ? FileImage(_categoryImageFile!)
                  : AssetImage('path_to_default_image.png') as ImageProvider,
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _pickCategoryImage,
              ),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Price'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Details'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_productNameController.text.isNotEmpty &&
                    _categoryImageFile != null) {
                  categoryProvider.addCategory(_ProductCategory(
                    title: _productNameController.text,
                    imagePath: _categoryImageFile!.path,
                    page: Placeholder(),
                  ));
                  _productNameController.clear();
                  _categoryImageFile = null;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill everything')),
                  );
                }
              },
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8),
      childAspectRatio: 3 / 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: _productCategories
          .map((category) => _buildCategoryItem(context, category))
          .toList(),
    );
  }

  Widget _buildCategoryItem(BuildContext context, _ProductCategory category) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => category.page);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  category.imagePath,
                  fit: BoxFit.contain,
                  width: 360,
                  height: 360,
                ),
                Center(
                  child: Text(category.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Color.fromARGB(115, 255, 255, 255),
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _handleDeleteCategory(category);
            },
          ),
        ),
      ],
    );
  }

  void _handleDeleteCategory(_ProductCategory category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete ${category.title}?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              categoryProvider.deleteCategory(category);
              setState(() {
                _productCategories.remove(category);
              });
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class CategoryProvider with ChangeNotifier {
  List<_ProductCategory> _categories = [
    _ProductCategory(
        title: 'Fruits', imagePath: 'assets/fruits.jpg', page: FruitPage()),
    _ProductCategory(
        title: 'Vegetables',
        imagePath: 'assets/vegetables.jpg',
        page: VegetablePage()),
    _ProductCategory(
        title: 'Meat', imagePath: 'assets/Meat.jpg', page: MeatPage()),
    _ProductCategory(
        title: 'Dairy & Eggs',
        imagePath: 'assets/dairy & eggs.jpg',
        page: DairyPage()),
    _ProductCategory(
        title: 'Bakery', imagePath: 'assets/bakery.jpg', page: BakerysPage()),
    _ProductCategory(
        title: 'Canned Foods',
        imagePath: 'assets/canned foods.jpg',
        page: CannedPage()),
    _ProductCategory(
        title: 'Beverages',
        imagePath: 'assets/beverages.jpg',
        page: BeveragePage()),
    _ProductCategory(
        title: 'Snacks', imagePath: 'assets/snacks.jpg', page: SnacksPage()),
    _ProductCategory(
        title: 'Frozen foods',
        imagePath: 'assets/Frozen foods.jpg',
        page: FrozenPage()),
    _ProductCategory(
        title: 'Desserts',
        imagePath: 'assets/Desserts.jpg',
        page: DessertsPage()),
    _ProductCategory(
        title: 'Oil & Spices',
        imagePath: 'assets/oil & spices.jpg',
        page: OilPage()),
    _ProductCategory(
        title: 'Fish', imagePath: 'assets/Fish.jpg', page: FishPage()),
    _ProductCategory(
        title: 'Alcohol', imagePath: 'assets/alcohol.jpg', page: AlcoholPage()),
    _ProductCategory(
        title: 'Jam', imagePath: 'assets/jams.jpg', page: JamPage()),
    _ProductCategory(
        title: 'Cereals', imagePath: 'assets/cereals.jpg', page: CerealPage()),
  ];

  List<_ProductCategory> get categories => _categories;

  void addCategory(_ProductCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  void deleteCategory(_ProductCategory category) {
    _categories.remove(category);
    notifyListeners();
  }
}

class _ProductCategory {
  final String title;
  final String imagePath;
  final Widget page;

  _ProductCategory(
      {required this.title, required this.imagePath, required this.page});

  void delete() {
    // Handle deletion here
    // For instance, you could be sending an HTTP request to a backend
  }
}
