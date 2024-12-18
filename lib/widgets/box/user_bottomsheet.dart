import 'package:flutter/material.dart';

class UserBottomSheet extends StatefulWidget {
  const UserBottomSheet({super.key});

  @override
  State<UserBottomSheet> createState() => UserBottomSheetState();
}

class UserBottomSheetState extends State<UserBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _users = [
    {"avatar": "https://i.pravatar.cc/50?img=1", "username": "user1"},
    {"avatar": "https://i.pravatar.cc/50?img=2", "username": "john_doe"},
    {"avatar": "https://i.pravatar.cc/50?img=3", "username": "alice"},
    {"avatar": "https://i.pravatar.cc/50?img=4", "username": "bob"},
    {"avatar": "https://i.pravatar.cc/50?img=5", "username": "charlie"},
  ];
  List<Map<String, String>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = _users;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users
          .where((user) => user["username"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.9,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Barra di ricerca
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cerca utenti",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Lista filtrata di utenti
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user["avatar"]!),
                      ),
                      title: Text(user["username"]!),
                      onTap: () {
                        // Azione quando si seleziona un utente
                        Navigator.pop(context, user["username"]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ricerca Utenti")),
      body: Center(
        child: ElevatedButton(
          onPressed: openBottomSheet,
          child: const Text("Apri Bottom Sheet"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
