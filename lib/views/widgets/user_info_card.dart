import 'package:flutter/material.dart';
import 'package:riverpod_assign/extensions/size_extension.dart';
import 'package:riverpod_assign/models/user.dart';
import 'package:riverpod_assign/utils/utils.dart';

class UserInfoCard extends StatelessWidget {
  final User user;
  final bool sortByName;
  const UserInfoCard({
    Key? key,
    required this.user,
    required this.sortByName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          userViewRouteTransition(user: user),
        );
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontWeight: sortByName ? FontWeight.w500 : FontWeight.w300,
              ),
            ),
            Text(
              user.phone,
              style: TextStyle(
                fontWeight: sortByName ? FontWeight.w300 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
