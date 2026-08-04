import 'package:flutter/material.dart';
import '../models/user_store.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _itemController = TextEditingController();

  void _addItem() {
    if (_itemController.text.trim().isEmpty) return;
    setState(() {
      UserStore.instance.items.add(_itemController.text.trim());
      _itemController.clear();
    });
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false, // clears the navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = UserStore.instance.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Semantics(
            identifier: 'logout_button',
            label: 'logout_button',
            button: true,
            child: IconButton(
              key: const Key('logoutButton'),
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    identifier: 'new_item_field',
                    label: 'new_item_field',
                    textField: true,
                    child: TextField(
                      key: const Key('newItemField'),
                      controller: _itemController,
                      decoration: const InputDecoration(
                        labelText: 'Add an item',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Semantics(
                  identifier: 'add_item_button',
                  label: 'add_item_button',
                  button: true,
                  child: ElevatedButton(
                    key: const Key('addItemButton'),
                    onPressed: _addItem,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Semantics(
                identifier: 'items_list',
                label: 'items_list',
                child: ListView.builder(
                  key: const Key('itemsList'),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Semantics(
                      identifier: 'item_$index',
                      label: 'item_$index',
                      child: ListTile(
                        key: Key('item_$index'),
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(items[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}