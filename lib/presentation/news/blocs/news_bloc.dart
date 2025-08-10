import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/core/api/api_client.dart';
import 'package:news_app_bloc/data/models/news_model.dart';
import 'package:news_app_bloc/domain/usecases/fetch_all_news.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      final result = await FetchAllNews().execute();
      if (result.isSuccess) {
        emit(NewsLoaded(result.data ?? []));
      } else {
        emit(NewsError(result.exception?.customMessage ?? "-"));
      }
    });
  }
}

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> data;

  NewsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
