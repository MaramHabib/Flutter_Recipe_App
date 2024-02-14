import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/register_page.dart';
import '../provider/app_auth.provider.dart';
import '../utils/images.dart';
import '../utils/colors.dart';
import '../widgets/scrollable.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is Login Page Modified with Auth Provider

class LoginPageMod extends StatefulWidget {
  const LoginPageMod({super.key});

  @override
  State<LoginPageMod> createState() => _LoginPageModState();
}

class _LoginPageModState extends State<LoginPageMod> {

  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImagesPath.background),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
          ),
          Consumer<AppAuthProvider>(
              builder: (context, authProvider, _) =>Form(
              key: authProvider.formKey,
              child: WidgetScrollable(
                isColumn: true,
                columnMainAxisAlignment: MainAxisAlignment.center,
                widgets: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 25),
                    child: Image.asset(ImagesPath.baseHeader),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: authProvider.emailController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'email',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || (value?.isEmpty ?? false)) {
                        return 'Email Is Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: authProvider.passwordController,
                    obscureText: authProvider.obsecureText,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || (value?.isEmpty ?? false)) {
                        return 'Password Is Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(400, 50),
                          backgroundColor: Color(ColorsConst.mainColor)),
                      onPressed: () => authProvider.logIn(context),
                      child:
                      Text('Login', style: TextStyle(color: Colors.white))),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        },
                        child:Text(
                          'Not Have Account , Register Now ?',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}