import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/user/user_event.dart';
import 'package:restaurant_review/application/user/user_provider.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/screens/modal_form.dart';
import '../widgets/text_fields.dart';
import '../widgets/logout.dart';
import '../widgets/Expansion_bar.dart';
import '../widgets/user_info.dart';
import 'package:restaurant_review/domain/user/profile_user.dart';
import 'package:restaurant_review/application/user/user_state.dart';

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for error states to show a SnackBar with the error message
    ref.listen<UserState>(userNotifierProvider, (previous, next) {
      if (next is UserError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final userState = ref.watch(userNotifierProvider);
    // print(userState);

    // Trigger user fetch after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState is UserInitial) {
        ref
            .read(userNotifierProvider.notifier)
            .mapEventToState(FetchUserRequested());
      }
    });

    Widget body;
    if (userState is UserInitial || userState is UserLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (userState is UserLoaded) {
      body = DefaultTabController(
        length: userState.user.isOwner == 'owner' ? 2 : 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit and View Profile",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              tabs: [
                Tab(icon: Icon(Icons.person_outlined)),
                if (userState.user.isOwner == 'owner')
                  Tab(icon: Icon(Icons.mode_edit_outline_outlined)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Profile(user: userState.user),
              if (userState.user.isOwner == 'owner') Modal(),
            ],
          ),
        ),
      );
    } else if (userState is UserError) {
      body = Center(child: Text('Error: ${userState.message}'));
    } else {
      body = const Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: body,
    );
  }
}

class Profile extends ConsumerStatefulWidget {
  final Profile_User user;

  Profile({required this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newUsernameController = TextEditingController();

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
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/default_profile.jpg'),
                ),
                title: Text(
                  widget.user.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  'Joined Nov 2023',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
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
              name: widget.user.username,
              email: widget.user.email,
              phoneNumber: '+251951479135', // Add phone number if available
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
                    TextField(
                      controller: _oldPasswordController,
                      decoration:
                          InputDecoration(labelText: "Enter Old Password"),
                      obscureText: true,
                    ),
                    TextField(
                      controller: _newPasswordController,
                      decoration:
                          InputDecoration(labelText: "Enter New Password"),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              childOfButton1: 'Save Changes',
              childOfButton2: 'Cancel',
              buttonBackgroundColor: Color.fromARGB(255, 255, 115, 0),
              onButton1Pressed: () {
                ref.read(userNotifierProvider.notifier).mapEventToState(
                      ChangePasswordRequested(_oldPasswordController.text,
                          _newPasswordController.text),
                    );
              },
            ),
            ExpansionBar(
              title: 'Change Username',
              children: Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _newUsernameController,
                      decoration:
                          InputDecoration(labelText: "Enter New Username"),
                    ),
                  ],
                ),
              ),
              childOfButton1: 'Save Changes',
              childOfButton2: 'Cancel',
              buttonBackgroundColor: Color.fromARGB(255, 255, 115, 0),
              onButton1Pressed: () {
                ref.read(userNotifierProvider.notifier).mapEventToState(
                      ChangeUsernameRequested(_newUsernameController.text),
                    );
              },
            ),
            Container(
              child: ExpansionBar(
                title: 'Delete Account',
                titleColor: Colors.red,
                children: Row(
                  children: [
                    SizedBox(width: 15),
                    Expanded(
                        child: Text(
                            'Are you sure you want to delete your account?')),
                  ],
                ),
                childOfButton1: 'Confirm',
                childOfButton2: 'Cancel',
                buttonBackgroundColor: Colors.red,
                onButton1Pressed: () {
                  ref.read(userNotifierProvider.notifier).mapEventToState(
                        DeleteAccountRequested(),
                      );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogInPage(),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [GestureDetector(child: LogOut())],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newUsernameController.dispose();
    super.dispose();
  }
}
