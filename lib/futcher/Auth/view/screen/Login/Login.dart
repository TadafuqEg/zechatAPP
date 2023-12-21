import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zechat/futcher/Auth/controller/logincontroller.dart';
import 'package:zechat/futcher/Auth/view/widget/EdtTxt/edtTextCreate.dart';
import 'package:zechat/futcher/Auth/view/widget/btnCreate/BtnLogin.dart';
import 'package:zechat/helper/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:GetBuilder(
            init: LoginController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: width * 0.5,
                    height: width * 0.5,
                    child: Lottie.asset("assets/lottie/login.json"),
                  ),
                  Text('LOGIN IN',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Sansation',
                        fontSize: width *0.05
                    ),
                  ),

                  EdtTxt(hintText: 'Ahmed@.com',labletxt: 'Email', obscureText: false,keyboardType: TextInputType.emailAddress,
                    prefixIcon:  Icon(Icons.email_outlined),
                    suffixIcon: Icon(Icons.question_mark),
                    tec: controller.emailTec,
                    errorText: controller.emailerror,
                  ),
                  EdtTxt(hintText: 'Password',labletxt: 'Password', obscureText: true,keyboardType: TextInputType.text,
                    prefixIcon:  Icon(Icons.lock_outline_rounded),
                    suffixIcon:IconButton(onPressed: (){},icon:  Icon(Icons.remove_red_eye_outlined),),
                    tec: controller.passwordTec,
                    errorText: controller.passworderror,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: EdgeInsets.only(top:15,right: 25),
                          child: InkWell(
                              onTap: (){
                                // Get.toNamed('/forgotpassword');
                              },
                              child: Text('Forgot Password?')))),
                  Text('${controller.errorMessage}',style: TextStyle(
                      fontFamily: 'Sansation',
                      color: Colors.red.shade400
                  ),),
                 !controller.isLoading? BtnLogin(press: (){
                    // Get.toNamed('/homeview');
                    controller.Login();
                  },):LinearProgressIndicator(),


                  Container(
                    margin: EdgeInsets.only(left: 10,bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Don’t have an account ?'),
                        Container(margin: EdgeInsets.only(left: 10,),
                          child: InkWell(
                              onTap: (){
                                Get.toNamed("/createaccount");
                              },
                              child: Text('Sign up')),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
