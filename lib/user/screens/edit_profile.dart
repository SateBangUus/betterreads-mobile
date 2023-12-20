import 'dart:convert';

import 'package:betterreads/user/models/user.dart';
import 'package:betterreads/user/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<User> fetchUser(CookieRequest request) async {
    final username = request.getJsonData()['username'];
    final response = await request
        .get('https://betterreads-k3-tk.pbp.cs.ui.ac.id/api/user/$username/');
    return User.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final request = context.read<CookieRequest>();
      await fetchUser(request).then((value) {
        _usernameController.text = value.username;
        _firstNameController.text = value.firstName;
        _lastNameController.text = value.lastName;
        _emailController.text = value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.sizeOf(context).width / 10,
                MediaQuery.sizeOf(context).width / 10,
                MediaQuery.sizeOf(context).width / 10,
                MediaQuery.of(context).viewInsets.bottom +
                    MediaQuery.sizeOf(context).width / 10),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: FutureBuilder<User>(
              future: fetchUser(request),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: MediaQuery.sizeOf(context).width / 8,
                            backgroundImage:
                                NetworkImage(snapshot.data!.profilePicture),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  MediaQuery.sizeOf(context).width / 10)),
                      const SizedBox(height: 20),
                      TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  MediaQuery.sizeOf(context).width / 10)),
                      const SizedBox(height: 20),
                      TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  MediaQuery.sizeOf(context).width / 10)),
                      const SizedBox(height: 20),
                      TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  MediaQuery.sizeOf(context).width / 10)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final response = await request.postJson(
                              'https://betterreads-k3-tk.pbp.cs.ui.ac.id/api/user/${snapshot.data!.username}/',
                              jsonEncode(<String, String>{
                                'username': _usernameController.text,
                                'first_name': _firstNameController.text,
                                'last_name': _lastNameController.text,
                                'email': _emailController.text,
                              }));
                          if (response['status'] == true) {
                            request.jsonData['username'] =
                                _usernameController.text;
                            didChangeDependencies();
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                        username: request
                                            .getJsonData()['username'])));
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Edit profile successful.'),
                                ),
                              );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Edit profile failed.'),
                                ),
                              );
                          }
                        },
                        child: const Text('Update Profile'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
              },
            ),
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Edit Profile')),
    );
  }
}
