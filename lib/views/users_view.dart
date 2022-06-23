import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_assign/extensions/size_extension.dart';
import 'package:riverpod_assign/notifiers/user_notifier.dart';
import 'package:riverpod_assign/utils/utils.dart';
import 'package:riverpod_assign/views/widgets/user_info_card.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  bool sortByName = true;
  bool sortAscending = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ref.read(userNotifer).initializeUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    final users = ref.watch(userNotifer).users;
    return Scaffold(
      body: SafeArea(
        child: users.isEmpty
            ? const CircularProgressIndicator()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.yellow[100],
                    expandedHeight: 250.h,
                    pinned: true,
                    actions: [
                      IconButton(
                        onPressed: popupMenu,
                        icon: const Icon(Icons.sort),
                      ),
                      sizedBoxWithWidth(32),
                    ],
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      expandedTitleScale: 1.2,
                      titlePadding:
                          EdgeInsetsDirectional.only(start: 32.w, bottom: 16.h),
                      title: const Text(
                        'A L L   U S E R S',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      background: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 28.h),
                        child: Image.asset(
                          'assets/images/users_in_park.png',
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: sizedBoxWithHeight(32),
                  ),
                  SliverToBoxAdapter(
                    child: Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: users.length,
                          separatorBuilder: (_, __) => sizedBoxWithHeight(16),
                          itemBuilder: (_, index) {
                            return UserInfoCard(
                              user: users[index],
                              sortByName: sortByName,
                            );
                          }),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: sizedBoxWithHeight(32),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow[100],
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: 50.h,
        ),
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(userViewRouteTransition());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        elevation: 0.0,
        backgroundColor: Colors.yellow[100],
      ),
    );
  }

  void popupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(255, 16.h, 32.w, 255),
      items: [
        PopupMenuItem<String>(
          child: const Text('Sort By Name'),
          onTap: () {
            sortByName = true;
            ref
                .read(userNotifer)
                .sortUsers(sortByName: sortByName, sortAcending: sortAscending);
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Sort By Phone'),
          onTap: () {
            sortByName = false;
            ref
                .read(userNotifer)
                .sortUsers(sortByName: sortByName, sortAcending: sortAscending);
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Ascending Order'),
          onTap: () {
            sortAscending = true;
            ref
                .read(userNotifer)
                .sortUsers(sortByName: sortByName, sortAcending: sortAscending);
          },
        ),
        PopupMenuItem<String>(
          child: const Text('Descending Order'),
          onTap: () {
            sortAscending = false;
            ref
                .read(userNotifer)
                .sortUsers(sortByName: sortByName, sortAcending: sortAscending);
          },
        ),
      ],
      elevation: 8.0,
    );
  }
}
