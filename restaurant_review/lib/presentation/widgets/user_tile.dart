

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserTile({
    super.key,
    required this.name,
    required this.date,
    required this.image,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 20,
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          'Review Date · $date',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
