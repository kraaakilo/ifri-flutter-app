import 'package:flutter/material.dart';
import 'package:ifri_management/logic/CreateUser.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstname + " " + user.lastname),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/avatar.png"),
                  radius: 70,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              user.firstname + " " + user.lastname,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Citation Préférée",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.citation,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Adresse e-mail",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Numéro de Téléphone",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.phone,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Adresse",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.address,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Date de Naissance",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.birthday,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Genre",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user.gender,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
