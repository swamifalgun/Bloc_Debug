import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_debug/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPosts>(_getPosts);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _getPosts(PostEvent event, Emitter<PostState> emit) async {
    if (event is GetPosts) {
      final postId = event.postId;

      try {
        final url = 'https://jsonplaceholder.typicode.com/posts/$postId';

        final respose = await http.Client().get(Uri.parse(url));
        if (respose.statusCode != 200) throw Exception();
        final data = json.decode(respose.body);
        if (postId == '') {
          final posts = data.map<Post>((e) => Post.fromJson(e)).toList();
          emit(PostLoaded(posts));
        }

        if (postId != '') {
          final post = Post.fromJson(data);
          final posts = [post];
          emit(PostLoaded(posts));
        }
      } catch (e) {
        print('Error : $e');
      }
    }
  }
}
