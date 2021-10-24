import 'package:bloc_debug/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetail extends StatelessWidget {
  final int? postId;

  const PostDetail({Key? key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<PostBloc>();

    postBloc.add(GetPosts(postId.toString()));

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            return Container();
          } else if (state is PostLoaded) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.posts.first.title),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.posts.first.body),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
