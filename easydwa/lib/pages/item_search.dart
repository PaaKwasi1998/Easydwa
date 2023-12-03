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
import 'package:flutter/material.dart';


class Item {
  final String name;
  final String category;
  final String imagePath;

  Item(this.name, this.category, this.imagePath);
}

class Category {
  final String name;
  final List<Item> items;

  Category(this.name, this.items);
}

class DataModel {
  final List<Category> categories;

  DataModel(this.categories);

  List<Item> search(String query) {
    List<Item> results = [];
    for (var category in categories) {
      results.addAll(category.items.where((item) => item.name.toLowerCase().contains(query.toLowerCase())));
    }
    return results;
  }
}
Widget _getPageForCategory(String category) {
  switch (category) {
    case 'Fruits':
      return FruitsPage();
    case 'Vegetables':
      return VegetablesPage();
    case 'Meat':
      return MeatsPage();
    case 'Dairy & Eggs':
      return DairysPage();
    case 'Bakery':
      return BakerysPage();
    case 'Canned Foods':
      return CannedPage();
    case 'Beverages':
      return BeveragesPage();
    case 'Snacks':
      return SnacksPage();
    case 'Frozen foods':
      return FrozenPage();
    case 'Desserts':
      return DessertsPage();
    case 'Oil & Spices':
      return OilPage();
    case 'Fish':
      return FishPage();
    case 'Alcohol':
      return AlcoholPage();
    case 'Jam':
      return JamPage();
    case 'Cereals':
      return CerealsPage();
    // ... Add other cases for other categories
    default:
      throw Exception('Unknown category: $category');
  }
}


class ItemSearch extends SearchDelegate<String> {
  final List<String> items;

  ItemSearch(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? items
        : items.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            close(context, '');  // Close the search delegate
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _getPageForCategory(suggestions[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Handle search results if necessary
    return Container();
  }
}

class ItemPage extends StatelessWidget {
  final Item item;

  ItemPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(
        child: Text('Item: ${item.name}'),
      ),
    );
  }
}
