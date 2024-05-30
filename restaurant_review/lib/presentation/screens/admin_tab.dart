// admin_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/admin/admin_event.dart';
import 'package:restaurant_review/application/admin/admin_providers.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/widgets/users_view_for_admin.dart';


class AdminTab extends ConsumerStatefulWidget {
  const AdminTab({super.key});

  @override
  ConsumerState<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends ConsumerState<AdminTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(adminNotifierProvider.notifier)
        .handleEvent(AdminEvent.fetchUsers));
  }

  void toggleBanCustomer(int index, bool value) {
    final customer = ref.read(adminNotifierProvider).customers[index];
    ref.read(adminNotifierProvider.notifier).handleEvent(
        AdminEvent.toggleBanCustomer,
        username: customer.name,
        isBanned: value);
  }

  void toggleBanOwner(int index, bool value) {
    final owner = ref.read(adminNotifierProvider).owners[index];
    ref.read(adminNotifierProvider.notifier).handleEvent(
        AdminEvent.toggleBanOwner,
        username: owner.name,
        isBanned: value);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);

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
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.errorMessage != null
                ? Center(child: Text(state.errorMessage!))
                : TabBarView(children: [
                    ListView.builder(
                      itemCount: state.owners.length,
                      itemBuilder: (context, index) => UsersView(
                        
                        key: ValueKey(state.owners[index].name),
                        name: state.owners[index].name,
                        isBanned: state.owners[index].isBanned,
                        onChanged: (value) => toggleBanOwner(index, value),
                      ),
                    ),
                    ListView.builder(
                      itemCount: state.customers.length,
                      itemBuilder: (context, index) => UsersView(
                        key: ValueKey(state.customers[index].name),
                        name: state.customers[index].name,
                        isBanned: state.customers[index].isBanned,
                        onChanged: (value) => toggleBanCustomer(index, value),
                      ),
                    ),
                  ]),
      ),
    );
  }
}
