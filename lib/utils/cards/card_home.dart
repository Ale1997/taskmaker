import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const CardHome(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: ListTile(
                onTap: onTap,
                leading: const CircleAvatar(
                  child: Icon(Icons.task_alt_outlined),
                ),
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
