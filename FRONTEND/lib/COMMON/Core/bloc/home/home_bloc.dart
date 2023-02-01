import 'package:bloc/bloc.dart';
///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final ResponseTopHeadlinesNewsModel data;

  DataSuccess(this.data);
}

class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class HomeBloc extends Bloc<DataEvent, DataState> {
  HomeBloc(super.initialState);

  DataState get initialState => DataInitial();

  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase) {
      case 'all':
        final data = await apiRepository.fetchTopHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'business':
        final data = await apiRepository.fetchTopBusinessHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      case 'entertainment':
        final data = await apiRepository.fetchTopEntertainmentHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      case 'health':
        final data = await apiRepository.fetchTopHealthHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      case 'science':
        final data = await apiRepository.fetchTopScienceHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      case 'sport':
        final data = await apiRepository.fetchTopSportHeadlinesNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      case 'technology':
        final data = await apiRepository.fetchTopTechnologyHeadlinesNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error!);
        }
        break;
      default:
        yield DataFailed('Unknown category');
    }
  }
}
