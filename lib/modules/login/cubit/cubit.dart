import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:shopping/shared/network/remote/Dio_Helper.dart';
import '../../../models/shopLoginmodels/shoploginModel.dart';
import '../../../shared/network/remote/endPoint.dart';
class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitState());
  static LoginCubit get(context)=>BlocProvider.of(context);
   late ShopLoginModel loginmodel;
  userLogin({
    required String email,
  required String password,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: LoginUrl, data: {
      'email':email,
      'password':password,
    }).then((value){
      loginmodel =ShopLoginModel.fromJson(value.data);
      emit(LoginsuccessState(loginmodel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }
  userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(SignupLoadingState());
    DioHelper.postData(url: SIGNUP, data: {
      'email':email,
      'password':password,
      'phone':phone,
      'name':name
    }).then((value){
      loginmodel =ShopLoginModel.fromJson(value.data);
      emit(SignupsuccessState(loginmodel));
    }).catchError((error){
      print(error.toString());
      emit(SignupErrorState());
    });
  }

 IconData passIcon=Icons.visibility_outlined;
  bool isVisible=true;

  void visibalPass(){
    isVisible=!isVisible;
    passIcon= isVisible ?Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(visibiltyChange());
  }
 

}