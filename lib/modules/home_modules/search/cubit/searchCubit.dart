import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/home_modules/search/cubit/searchState.dart';

import '../../../../models/shopHomemodels/search_Model.dart';
import '../../../../shared/network/remote/endPoint.dart';
import '../../../../shared/network/remote/Dio_Helper.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(InitState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchResult;
  void getSearch(String searchKey)async{
    emit(SearchLoadingState());
    await DioHelper.postData(
        url: SEARCH,
        data: {
          'text':searchKey
        }).then((value) {
      searchResult=SearchModel.fromJson(value.data);
      print("llllllllllllllllllllllllllllllllllllllllllllllll");
      print(searchResult);
      print(value.data);
      emit(SearchSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(SearchErrorState(error));
    });
  }
}