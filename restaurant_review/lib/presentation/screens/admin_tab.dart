import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/data/users_data.dart';
import 'package:restaurant_review/models/users_model.dart';
import 'package:restaurant_review/presentation/widgets/users_view_for_admin.dart';

class AdminTab extends StatefulWidget {
  const AdminTab({super.key});

  @override
  State<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  List<CustomerModel> customers = customerData;
  List<OwnerModel> owners = ownerData;

  void toggleBanCustomers(int index, bool value) {
    setState(() {
      customers[index].isBanned = value;
    });
  }

  void toggleBanOwners(int index, bool value) {
    setState(() {
      owners[index].isBanned = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Control Panel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppPallete.blackColor,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.person_outlined),
              text: "Owners",
            ),
            Tab(
              icon: Icon(Icons.person_outlined),
              text: "Customers",
            )
          ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
            itemCount: owners.length,
            itemBuilder: (context, index) => UsersView(
              name: owners[index].name,
              isBanned: owners[index].isBanned,
              onChanged: (value) => toggleBanOwners(index, value),
            ),
          ),
          ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) => UsersView(
              name: customers[index].name,
              isBanned: customers[index].isBanned,
              onChanged: (value) => toggleBanCustomers(index, value),
            ),
          )
        ]),
      ),
    );
  }
}
