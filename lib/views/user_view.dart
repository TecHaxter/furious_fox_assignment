import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_assign/extensions/size_extension.dart';
import 'package:riverpod_assign/models/user.dart';
import 'package:riverpod_assign/notifiers/user_notifier.dart';
import 'package:riverpod_assign/utils/sized_box.dart';

class UserView extends ConsumerWidget {
  final User? user;
  UserView({Key? key, this.user}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _nameController.text = user?.name ?? '';
    _mobileController.text = user?.phone ?? '';

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxWithHeight(28),
              Container(
                height: 200.h,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user_in_park.png'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              sizedBoxWithHeight(16),
              Text(
                "${user == null ? 'A D D' : 'U P D A T E'}   U S E R",
                style: TextStyle(
                  fontSize: 26.sp,
                ),
              ),
              sizedBoxWithHeight(80),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: "Khushal Rao",
                      ),
                    ),
                    sizedBoxWithHeight(16),
                    TextFormField(
                      controller: _mobileController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Please enter 10 digit mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: "9602151363",
                      ),
                    ),
                    sizedBoxWithHeight(16),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final usersLength =
                              ref.read(userNotifer).users.length;
                          if (user != null) {
                            ref.read(userNotifer).updateUser(
                                  user: User(
                                    id: user!.id,
                                    name: _nameController.text,
                                    phone: _mobileController.text,
                                  ),
                                );
                          } else {
                            ref.read(userNotifer).addUser(
                                  user: User(
                                    id: usersLength + 1,
                                    name: _nameController.text,
                                    phone: _mobileController.text,
                                  ),
                                );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'U S E R   ${user == null ? 'A D D E D' : 'U P D A T E D'}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        user == null ? 'A D D' : 'U P D A T E',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
