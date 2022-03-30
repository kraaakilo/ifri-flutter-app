import 'package:flutter/material.dart';
import 'package:ifri_management/logic/CreateUser.dart';

class UserElement extends StatelessWidget {
  final User user;
  const UserElement({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              const SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.png"),
                  backgroundColor: Colors.grey,
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(left: 15),
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.firstname + " " + user.lastname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Text(user.citation.toString())
                    ],
                  ),
                ),
              )
            ]),
          ),
          Container(
            child: Container(
              color: Colors.grey,
              height: 1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ],
      ),
    );
  }
}
