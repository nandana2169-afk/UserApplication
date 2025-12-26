import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_application/model/model.dart';
import 'package:user_application/provider/provider.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    context.read<UserController>().fetchUsers();
  }

  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Add A New User", style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {}, 
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.add_a_photo, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone Number"), keyboardType: TextInputType.phone),
              TextField(controller: ageController, decoration: const InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final newUser = User(
                  name: nameController.text,
                  phone: phoneController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  image: 'assets/userone.png', 
                );
                context.read<UserController>().addUser(newUser);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 4),
            Text('Nilambur', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => controller.searchUser(val),
                    decoration: InputDecoration(
                      hintText: "Search by name or phone",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showSortingDialog(controller),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 35, backgroundImage: AssetImage(user.image)),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text("Age: ${user.age}", style: const TextStyle(color: Colors.grey)),
                                    Text("Mob: ${user.phone}", style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          width: 70, height: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            onPressed: () => _showAddUserDialog(context),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

 void _showSortingDialog(UserController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16), 
            child: Text(
              "Sort by Age Category", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            )
          ),
          RadioListTile(
            title: const Text("All"), 
            value: "All", 
            groupValue: selectedFilter, 
            activeColor: Colors.blue, 
            onChanged: (v) => _updateFilter(v!, controller)
          ),
          // --- UPDATED LABELS FOR INSTRUCTOR REQUIREMENTS ---
          RadioListTile(
            title: const Text("Older (Above 60)"), 
            value: "Older", 
            groupValue: selectedFilter, 
            activeColor: Colors.blue, 
            onChanged: (v) => _updateFilter(v!, controller)
          ),
          RadioListTile(
            title: const Text("Younger (Below 60)"), 
            value: "Younger", 
            groupValue: selectedFilter, 
            activeColor: Colors.blue, 
            onChanged: (v) => _updateFilter(v!, controller)
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  void _updateFilter(String val, UserController controller) {
    setState(() => selectedFilter = val);
    controller.filterByAge(val);
    Navigator.pop(context);
  }
}