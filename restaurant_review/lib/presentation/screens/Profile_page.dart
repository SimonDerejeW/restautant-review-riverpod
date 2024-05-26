import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/presentation/screens/modal_form.dart';
import '../widgets/text_fields.dart';
import '../widgets/logout.dart';
import '../widgets/Expansion_bar.dart';
import '../widgets/user_info.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 2,
       child: Scaffold(
        appBar: AppBar(
          title: Text("Edit and View Profile", style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black),),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            tabs: [
              Tab(icon: Icon(Icons.person_outlined), ),
              Tab(icon: Icon(Icons.mode_edit_outline_outlined),)
            ]),
        ),

        body: TabBarView(children: [
          Profile(),
          Modal()
        ]),
       )),
    );
        
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: const ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage('assets/images/default_profile.jpg'),
                  ),
                  title: Text(
                    'Darrow Lykos',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    '  Joined Nov 2023',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Verified Info',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            UserInfo(
              name: 'Dlyoofs',
              email: 'darrow1@gmail.com',
              phoneNumber: '+251951479135',
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Account Settings',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            ExpansionBar(
              title: 'Change Password',
              children: Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textfields(
                        subtitles: 'Enter Old Password',
                      ),
                      Textfields(
                        subtitles: 'Enter New Password',
                      )
                    ]),
              ),
              childOfButton1: 'Save Changes',
              childOfButton2: 'Cancel',
              buttonBackgroundColor: Color.fromARGB(255, 255, 115, 0),
            ),
            Container(
              child: ExpansionBar(
                title: 'Delete Account',
                titleColor: Colors.red,
                children: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                            'Are you sure you wannt to delete your account?')),
                  ],
                ),
                childOfButton1: 'Confirm',
                childOfButton2: 'Cancel',
                buttonBackgroundColor: Colors.red,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [LogOut()]))
          ],
        )));
  }
}
