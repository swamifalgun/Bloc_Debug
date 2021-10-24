part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {
  const GetPosts(this.postId);

  final String postId;

  @override
  List<Object> get props => [postId];
}
