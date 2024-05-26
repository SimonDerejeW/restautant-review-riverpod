import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  late String image;
  final String name;
  final String date;

  UserTile({required this.name, required this.date, required this.image}) {
    if (this.image == '') {
      this.image = 'assets/images/default_profile.jpg';
    }
  }

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
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          'Review Date · $date',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit),
            SizedBox(width: 12),
            Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
