import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';

class UserBottomSheetUtils {
  static final List<Map<String, String>> _users = [
    {"avatar": "https://i.pravatar.cc/50?img=1", "username": "Simone Zanetti"},
    {"avatar": "https://i.pravatar.cc/50?img=2", "username": "Samuel Maggio"},
  ];

  static Future<String?> showUserBottomSheet(BuildContext context) async {
    TextEditingController searchController = TextEditingController();
    List<Map<String, String>> filteredUsers = _users;

    void filterUsers(String query) {
      query = query.toLowerCase();
      filteredUsers = _users
          .where((user) => user["username"]!.toLowerCase().contains(query))
          .toList();
    }

    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.9,
            builder: (_, controller) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Cerca timers",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterUsers(value);
                      });
                    },
                  ),
                  const Gap(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user["avatar"]!),
                          ),
                          title: Text(user["username"]!),
                          onTap: () {
                            Navigator.pop(context, user["username"]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
