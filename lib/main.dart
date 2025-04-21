// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Favoriler -Erciyes University Mobile Development Vize Ödevi 1030510302 ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Örnek veri listesi
  final List<Item> _items = [
    Item(id: 1, name: 'Flutter', description: 'Google\'ın mobil uygulama geliştirme çerçevesi'),
    Item(id: 2, name: 'Dart', description: 'Flutter uygulamaları geliştirmek için kullanılan programlama dili'),
    Item(id: 3, name: 'VS Code', description: 'Microsoft tarafından geliştirilen kod editörü'),
    Item(id: 4, name: 'Android Studio', description: 'Android uygulama geliştirme ortamı'),
    Item(id: 5, name: 'Firebase', description: 'Google\'ın mobil uygulama geliştirme platformu'),
    Item(id: 6, name: 'GitHub', description: 'Kod barındırma ve sürüm kontrol sistemi'),
  ];

  // Favorileri tutacak liste
  final List<Item> _favorites = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Favoriler -Erciyes University Mobile Development Vize Ödevi 1030510302'),
          bottom: const TabBar( 
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Tüm Öğeler'),
              Tab(icon: Icon(Icons.favorite), text: 'Favoriler'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tüm öğeler sekmesi
            _buildItemsList(_items, true),
            // Favoriler sekmesi
            _favorites.isEmpty
                ? const Center(child: Text('Henüz favori eklenmedi!'))
                : _buildItemsList(_favorites, false),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList(List<Item> items, bool showAddButton) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            trailing: showAddButton
                ? IconButton(
                    icon: Icon(
                      _favorites.contains(item) ? Icons.favorite : Icons.favorite_border,
                      color: _favorites.contains(item) ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_favorites.contains(item)) {
                          _favorites.remove(item);
                        } else {
                          _favorites.add(item);
                        }
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _favorites.remove(item);
                      });
                    },
                  ),
          ),
        );
      },
    );
  }
}

// Veri modeli
class Item {
  final int id;
  final String name;
  final String description;

  Item({required this.id, required this.name, required this.description});
}