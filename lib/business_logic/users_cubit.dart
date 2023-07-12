 import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:http/http.dart' as http;
import '../../core/end_points.dart' as end_points;
import '../data/models/users_response.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  static UsersCubit get(context) => BlocProvider.of<UsersCubit>(context);

  UsersResponse usersResponse = UsersResponse();
  Future<void> getUsersUsingHTTP() async {
    emit(UsersLoadingState());

    try {
      final http.Response response = await http.get(Uri.parse(end_points.url),);
      if (kDebugMode) {
        print('http response status code ${response
            .statusCode}, http response body ${response.body}');
      }
      if (response.statusCode == 200) {
        usersResponse = UsersResponse.fromJson(jsonDecode(response.body));
        emit(UsersSuccessState());
      } else {
        emit(UsersErrorState());
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(UsersErrorState());
    }
  }
}