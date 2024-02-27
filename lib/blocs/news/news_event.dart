
part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNews extends NewsEvent {

  const GetNews();

  @override
  List<Object> get props => [];
}