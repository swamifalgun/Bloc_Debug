import 'package:bloc_debug/bloc/post_bloc.dart';
import 'package:bloc_debug/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<PostBloc>(
      create: (context) => PostBloc(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostPage> createState() => _PostState();
}

class _PostState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<PostBloc>();

    postBloc.add(const GetPosts(''));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.redAccent,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Posts',
                  style: TextStyle(fontSize: 32.0),
                )),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: index.isEven
                              ? Colors.amberAccent
                              : Colors.greenAccent,

                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetail(postId: state.posts[index].id),
                              ),
                            );
                          },
                          // leading: Text(state.posts[index].title),
                          title: Text(state.posts[index].title),
                        );
                      },
                    );
                  } else {
                    return Container(
                      color: Colors.redAccent,
                      height: 20.0,
                      width: MediaQuery.of(context).size.width,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
