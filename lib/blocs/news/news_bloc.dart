import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_banner_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_news_response.dart';
import 'package:flutter_kundol/repos/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepo newsRepo;

  NewsBloc(this.newsRepo) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetNews) {
      try {
        final newsResponse = await newsRepo.fetchNews();
        yield NewsLoaded(newsResponse);
      } on Error {
        yield NewsError("Couldn't fetch News. Is the device online?");
      }
    }
  }
}
