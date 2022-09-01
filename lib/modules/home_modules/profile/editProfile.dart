import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';

import '../../../layout/home_layout/home.dart';
import '../../../shared/componant/componant.dart';
import '../../../shared/shared_preference/cachHelper.dart';
import '../../login/cubit/cubit.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formEdit = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(
      listener: (context, state) {
        if (state is EditProfileSucces) {
          if (state.updatemodel.status) {
            ShopCubit.get(context).getProfile();
            print(state.updatemodel.message);
            showtoast(
                text: '${state.updatemodel.message}',
                state: toastStates.SUCESS);
            navigatandFinish(context, home());
          } else {
            print("error");
            print(state.updatemodel.message);
            showtoast(
                text: '${state.updatemodel.message}', state: toastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: formEdit,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DefoultformFild(
                    controller: namecontroller,
                    label: "name",
                    isPassword: false,
                    type: TextInputType.text,
                    prefix: Icons.person,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "name can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DefoultformFild(
                    controller: emailcontroller,
                    label: "Email",
                    isPassword: false,
                    type: TextInputType.text,
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "email can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DefoultformFild(
                    controller: phonecontroller,
                    label: "phone",
                    isPassword: false,
                    type: TextInputType.phone,
                    prefix: Icons.phone_android,
                    validate: (value) {
                      if (value.isEmpty) {
                        return "phone number can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DefoultformFild(
                      controller: passwordcontroller,
                      type: TextInputType.visiblePassword,
                      isPassword: LoginCubit.get(context).isVisible,
                      prefix: Icons.lock,
                      suffix: LoginCubit.get(context).passIcon,
                      suffixfun: () {
                        LoginCubit.get(context).visibalPass();
                      },
                      onsubmit: (value) {
                        if (formEdit.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              email: emailcontroller.text,
                              password: passwordcontroller.text);
                        }
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Password is short";
                        }
                        return null;
                      },
                      label: "Password"),
                  const SizedBox(height: 20.0),
                  ConditionalBuilder(
                    condition: state is! EditProfileLoading,
                    builder: (BuildContext context) {
                      return defultButton(
                        context: context,
                        onpressed: () {
                          if (formEdit.currentState!.validate()) {
                            ShopCubit.get(context).userUpdate(
                              email: emailcontroller.text,
                              name: namecontroller.text,
                              password: passwordcontroller.text,
                              phone: phonecontroller.text,
                            );
                          }
                        },
                        text: "Update",
                      );
                    },
                    fallback: (BuildContext context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
