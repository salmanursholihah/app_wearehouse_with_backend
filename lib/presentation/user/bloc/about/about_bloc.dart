import 'package:app_wearehouse_with_backend/data/datasources/about_us_remote_datasource.dart';
import 'package:app_wearehouse_with_backend/data/models/about_response_model.dart' show AboutResponseModel;
import 'package:app_wearehouse_with_backend/presentation/user/bloc/about/about_event.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final AboutRemoteDatasource datasource;

  AboutBloc(this.datasource) : super(AboutInitial()) {
    on<LoadAbout>((event, emit) async {
      emit(AboutLoading());
      try {
        final data = await datasource.getAbout();
        emit(AboutLoaded(data));
      } catch (e) {
        emit(AboutError(e.toString()));
      }
    });
  }
}
