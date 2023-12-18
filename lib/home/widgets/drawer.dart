import 'package:flutter/material.dart';
import 'package:betterreads/home/screens/homepage.dart';
import 'package:betterreads/auth/screens/login.dart';
import 'package:betterreads/home/widgets/outlined_text.dart';
import 'package:betterreads/user/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 80, 80, 80),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: const TextSpan(
                        text: "Better",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                                offset: Offset(8, 8),
                                blurRadius: 10,
                                color: Color.fromARGB(85, 0, 0, 0))
                          ],
                        ),
                        children: [
                          TextSpan(
                              text: "Reads",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30))
                        ]),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: OutlinedText(
                        'One of the key benefits of BetterReads is its integrated book review feature, allowing users to discover and contribute insightful reviews, making it easier for readers to find their next captivating read and fostering a vibrant community of literary enthusiasts.',
                        Colors.black,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.white)))
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () => navigateToPage(context, const HomePage()),
          ),
          ListTile(
            title: const Text('Search Books'),
            leading: const Icon(Icons.search),
            onTap: () => navigateToPage(context, const Placeholder()),
          ),
          ListTile(
              title: const Text('Cart'),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                if (!request.loggedIn) {
                  navigateToPage(context, const LoginPage());
                } else {
                  navigateToPage(context, const Placeholder());
                }
              }),
          ListTile(
              title: const Text('Profile'),
              leading: const Icon(Icons.person),
              onTap: () {
                if (!request.loggedIn) {
                  navigateToPage(context, const LoginPage());
                } else {
                  navigateToPage(context, const ProfilePage());
                }
              }),
          request.loggedIn
              ? ListTile(
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    request.logout(
                        'https://betterreads-k3-tk.pbp.cs.ui.ac.id/api/logout/');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                )
              : ListTile(
                  title: const Text('Login'),
                  leading: const Icon(Icons.login),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage())),
                ),
        ],
      ),
    );
  }
}
