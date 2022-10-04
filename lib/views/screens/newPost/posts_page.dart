import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/views/screens/newPost/newpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/posts_controller.dart';
import '../../../core/constant/style.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostsControllerImpl postsController =
        Get.put(PostsControllerImpl());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Posts',
            style: TextStyle(
                fontFamily: AppText.light,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.to(() => const NewPostPage(),
                    duration: Duration(
                        milliseconds: 500),
                    transition:
                        Transition.rightToLeft,
                    curve: Curves.easeOut);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColor.secondry,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Create Post',
                        style: TextStyle(
                            fontFamily:
                                AppText.light,
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * .05,
            ),
            const CircleAvatar(
              backgroundColor: AppColor.secondry,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          elevation: .5,
          backgroundColor: AppColor.background,
        ),

        // body: ListView.builder(

        body: Column(
          children: [
            // header of home page
            const Padding(
              padding: EdgeInsets.only(left: 15),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: postsController
                      .collectionStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot>
                          snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          'Something went wrong');
                    }

                    if (snapshot
                            .connectionState ==
                        ConnectionState.waiting) {
                      return const Text(
                          "Loading");
                    }

                    return ListView(
                      padding: EdgeInsets.zero,
                      children: snapshot
                          .data!.docs
                          .map((DocumentSnapshot
                              document) {
                        Map<String, dynamic>
                            data =
                            document.data()!
                                as Map<String,
                                    dynamic>;
                        return Container(
                          width: Get.width,
                          color: Colors.white,
                          margin: const EdgeInsets
                              .only(bottom: 10),
                          padding:
                              const EdgeInsets
                                  .all(10),
                          child: Column(
                            children: [
                              Text(data['title']),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ));
  }
}
