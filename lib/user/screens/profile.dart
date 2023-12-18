import 'package:betterreads/user/widgets/favorite_genre_card.dart';
import 'package:betterreads/user/widgets/top_reviews_card.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:betterreads/user/models/user.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> fetchUser(CookieRequest request) async {
    final response = await request
        .get('https://betterreads-k3-tk.pbp.cs.ui.ac.id/api/user/');
    return User.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchUser(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.favGenres);
                  return Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.sizeOf(context).width / 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius:
                                        MediaQuery.sizeOf(context).width / 8,
                                    backgroundImage: NetworkImage(
                                        snapshot.data.profilePicture),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data.username,
                                            style: TextStyle(
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          if (snapshot.data.isCurator)
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: MediaQuery.sizeOf(context)
                                                      .width /
                                                  14,
                                            ),
                                        ],
                                      ),
                                      Text(
                                        'Joined on ${snapshot.data.joinDate}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width /
                                                24),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text("Total Reviews",
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  20)),
                                  SizedBox(height: 10),
                                  Text(snapshot.data.totalReviews.toString(),
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  12,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Text("Average Rating",
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  20)),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      text: snapshot.data.averageRating
                                          .toString(),
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  12,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: '/5.0',
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .width /
                                                      20,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 35),
                          Text("Top Reviews",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).width / 18)),
                          SizedBox(height: 10),
                          snapshot.data.favGenres!.isEmpty
                              ? Text("No reviews.",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              22))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.topReviews!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: TopReviewsCard(
                                          userReview:
                                              snapshot.data.topReviews[index],
                                          index: index),
                                    );
                                  }),
                          SizedBox(height: 35),
                          Text("Favorite Genre to Review",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).width / 18)),
                          SizedBox(height: 10),
                          snapshot.data.favGenres!.isEmpty
                              ? Text("No reviews.",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              22))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.favGenres!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: FavoriteGenreCard(
                                          genre: snapshot.data.favGenres[index]
                                              ["book__genre"],
                                          count: snapshot.data.favGenres[index]
                                              ["genre_total"],
                                          index: index),
                                    );
                                  })
                        ]),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}
