import 'package:flutter/material.dart';
import 'package:ifri_management/CreateUserPage.dart';
import 'package:ifri_management/UserElement.dart';
import 'package:ifri_management/UserPage.dart';
import 'package:ifri_management/database/UserDB.dart';
import 'package:ifri_management/logic/CreateUser.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
      ),
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<User> users;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshUsers();
  }

  @override
  void dispose() {
    UserDatabase.instance.close();

    super.dispose();
  }

  Future refreshUsers() async {
    setState(() {
      isLoading = true;
    });
    users = await UserDatabase.instance.getUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des utilisateurs"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => refreshUsers(),
              tooltip: "Actualiser",
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? const Center(
                  child: Text("Aucun Utilisateur disponible"),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: AbsorbPointer(
                        child: UserElement(
                          user: users[index],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              user: users[index],
                            ),
                          ),
                        );
                        refreshUsers();
                      },
                    );
                  },
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateUserPage(),
            ),
          );
          refreshUsers();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
