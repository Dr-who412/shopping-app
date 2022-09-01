import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/cubit.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/modules/login/register.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopping/shared/componant/constance.dart';
import 'package:shopping/shared/shared_preference/cachHelper.dart';
import '../../layout/home_layout/home.dart';
import '../../shared/componant/componant.dart';
class login extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKay = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {
        if (state is LoginsuccessState) {
          if (state.loginmodel.status) {
            print(state.loginmodel.message);
            token=state.loginmodel.data.token;
            showtoast(text: '${state.loginmodel.message}',state: toastStates.SUCESS);
           CacheHelper.saveData(key:"token", value: state.loginmodel.data.token).then((value) {
            navigatandFinish(context, home());
           });
          } else {
            print("error");
            print(state.loginmodel.message);
            showtoast(text:'${state.loginmodel.message}',state: toastStates.ERROR);
          }
        }
      },
      builder: (BuildContext context, LoginStates) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKay,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 24,)),
                        Text("  Login now to get our offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey,)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DefoultformFild(
                          controller: emailcontroller,
                          label: "Email",
                          isPassword: false,
                          type: TextInputType.text,
                          prefix: Icons.person,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "email can't be empty";
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
                              if (formKay.currentState!.validate()) {
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
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: LoginStates is! LoginLoadingState,
                          builder: (BuildContext context) {
                            return defultButton(
                              context: context,
                              onpressed: () {
                                if (formKay.currentState!.validate()) {
                                  LoginCubit.get(context). userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                              text: "LOGIN",
                            );
                          },
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Don't have an account ?"),
                            defultTextButton(
                                onpressed: () {
                                  navigatTo(context, Register());
                                },
                                text: "SIGN UP"),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
