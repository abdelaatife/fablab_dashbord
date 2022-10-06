import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fabdashboard/views/screens/newPost/newpost.dart';
import 'package:fabdashboard/views/widgets/posts/header_post.dart';
import 'package:fabdashboard/views/widgets/posts/imageviewer.dart';
import 'package:fabdashboard/views/widgets/posts/textviewer.dart';
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
                    duration: const Duration(
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: postsController
                      .collectionStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot>
                          snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Something went wrong'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                          child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: const [
                          Icon(
                            Icons
                                .cloud_off_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'There is no post found you can create a new one',
                            style: TextStyle(
                                fontFamily:
                                    AppText.light,
                                fontSize: 16,
                                color:
                                    Colors.black),
                          ),
                        ],
                      ));
                    }

                    if (snapshot
                            .connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.zero,
                      children: snapshot
                          .data!.docs
                          .map((DocumentSnapshot
                              document) {
                        Map<String, dynamic>
                            data = document.data()
                                as Map<String,
                                    dynamic>;
                        return Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors
                                        .grey
                                        .withOpacity(
                                            .5),
                                    spreadRadius:
                                        1,
                                    blurRadius: 1,
                                    offset:
                                        const Offset(
                                            0, 1),
                                  ),
                                ],
                                color: Colors
                                    .white,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            10),
                                border: Border.all(
                                    color: Colors
                                        .grey,
                                    width: .5)),
                            height: Get.height *
                                .2,
                            margin:
                                EdgeInsets.all(Get
                                        .width *
                                    .01),
                            padding:
                                const EdgeInsets
                                    .all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height:
                                      Get.height,
                                  width:
                                      Get.width *
                                          .15,
                                  child: AppPostImageViewer(
                                      imageUrls: data[
                                          'imageUrls']),
                                ),
                                SizedBox(
                                  width:
                                      Get.width *
                                          .02,
                                ),
                                SizedBox(
                                  width:
                                      Get.width *
                                          .06,
                                  child:
                                      AppHeaderPost(
                                    name: data[
                                            "personName"] ??
                                        '',
                                    title: data[
                                            'title'] ??
                                        '',
                                    time: data[
                                            'date'] ??
                                        '',
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      Get.width *
                                          .02,
                                ),
                                AppPostText(
                                    text: data[
                                        'description']),

                                //delete button with confirmation dialog

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .end,
                                    children: [
                                      Center(
                                        child:
                                            IconButton(
                                          onPressed:
                                              () {
                                            // ask for confirmation
                                            // then delete
                                            showDialog<
                                                String>(
                                              context:
                                                  context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text('AlertDialog Title'),
                                                content: const Text('AlertDialog description'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                      context,
                                                    ),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      postsController.deletePost(document.id);
                                                    },
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon:
                                              const Icon(
                                            Icons
                                                .delete,
                                            color:
                                                Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }).toList(),
                    );
                  }),
            ),
          ],
        ));
  }
} /* */
