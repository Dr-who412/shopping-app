import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/modules/home_modules/profile/editProfile.dart';
import 'package:shopping/shared/componant/componant.dart';
import '../../../shared/styles/colors.dart';
import '../home_cubit/cubit.dart';
import '../home_cubit/status.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(
      listener: (context, state) {},
      buildWhen: (previse, state) {
        if (state is EditProfileSucces) {
          ShopCubit.get(context).getProfile();
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [

              Image.network(
                '${ShopCubit.get(context).profile?.data?.image}',
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<ShopCubit>().pickImage();
                },
                icon: Icon(Icons.camera_alt_outlined),
                color: Colors.grey,
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(18),
                margin: EdgeInsets.only(top: 310),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${ShopCubit.get(context).profile?.data?.email}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                logout(context);
                              },
                              icon: Icon(Icons.logout_outlined)),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "${ShopCubit.get(context).profile?.data?.phone}",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: defultColor.withOpacity(.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/coin.png'),
                              SizedBox(
                                width: 26,
                              ),
                              Text('You have 30 points ')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Edit profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      InkWell(
                        onTap: () {
                          navigatTo(context, EditProfile());
                        },
                        child: Container(
                          height: 60,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/edit.png'),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Change name or email ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: 70,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(
                            '${ShopCubit.get(context).profile?.data?.image}',
                          ),
                          radius: 85,
                          backgroundColor: Colors.white10,



                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.4),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "${ShopCubit.get(context).profile?.data?.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
