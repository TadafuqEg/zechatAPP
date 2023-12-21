import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zechat/futcher/Auth/controller/createAcountcontroller.dart';
import 'package:zechat/futcher/Auth/view/widget/EdtTxt/edtTextCreate.dart';
import 'package:zechat/futcher/Auth/view/widget/btnCreate/BtnCreate.dart';
import 'package:zechat/helper/color.dart';
class CreateAcoountScreen extends StatelessWidget {
  const CreateAcoountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child:GetBuilder<CreateAccountController>(
            init: CreateAccountController(),
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
                  Text('Create your account',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Sansation',
                        fontSize: width *0.05
                    ),

                  ),
                  EdtTxt(hintText: 'Your Name',labletxt: 'Name', obscureText: false,keyboardType: TextInputType.text,
                    prefixIcon:  Image.asset('assets/icons/iconname.webp'),
                    tec: controller.unameTec,
                    errorText: controller.usernameerror,
                  ),

                  EdtTxt(hintText: 'Ahmed@.com',labletxt: 'Email', obscureText: false,keyboardType: TextInputType.emailAddress,
                    prefixIcon:  Icon(Icons.email_outlined),
                    suffixIcon: Icon(Icons.question_mark),
                    tec: controller.emailTec,
                    errorText: controller.emailerror,
                  ),

                  EdtTxt(hintText: 'Password',labletxt: 'Password', obscureText: controller.passwordobscureText,keyboardType: TextInputType.text,
                    prefixIcon:  Icon(Icons.lock_outline_rounded),
                    suffixIcon:IconButton(onPressed: (){
                      controller.ShowPassword();
                    },icon:  controller.passwordobscureText?Icon(Icons.visibility):Icon(Icons.visibility_off),),
                    tec: controller.passwordTec,
                      errorText:controller.passworderror
                  ),
                  EdtTxt(hintText: 'Confirm Password',labletxt: 'ConfirmPassword', obscureText: controller.confirmpasswordobscureText,keyboardType: TextInputType.text,
                    prefixIcon:  Icon(Icons.lock_outline_rounded),
                    suffixIcon:IconButton(onPressed: (){controller.ShowconfirmPassword();},icon: controller.confirmpasswordobscureText?Icon(Icons.visibility):Icon(Icons.visibility_off),),
                  tec: controller.ConfirmpasswordTec,
                  errorText: controller.confirmpassworderror,
                  ),

                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          margin: EdgeInsets.only(top:15,left: 25,right: 25),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [Checkbox(value: controller.checkboxterms,onChanged: (value){
                                    controller.oncheckboxChange(value);
                                  },),
                                    Flexible(child: Text('By continuing, You are agree to our',style: TextStyle(fontSize: width*0.03),)),
                                  ],
                                ),
                              ),
                              Flexible(child: Text('Terms & Condition',style: TextStyle(fontSize: width*0.03,color: kPrimaryColor)))
                            ],
                          )
                      )),
                  Text('${controller.errorMessage}',style: TextStyle(
                      fontFamily: 'Sansation',
                      color: Colors.red.shade400
                  ),),
                  !controller.isLoading?BtnCreate(press: (){
                    controller.CreateAnAccount(context);
                  },):LinearProgressIndicator(),

                  Container(
                    margin: EdgeInsets.only(left: 10,bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Already have an account ?'),
                        Container(margin: EdgeInsets.only(left: 10,),
                          child: InkWell(
                              onTap: (){
                                Get.toNamed("/login");
                              },
                              child: Text('Login')),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
