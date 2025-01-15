import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification/screens/HomeScreen.dart';
import 'package:notification/screens/main_screen.dart';
import 'package:notification/screens/signup.dart';
import 'package:notification/utils/appColor.dart';
import 'package:notification/widgets/roundGradientButon.dart' show RoundGradientButton;
import 'package:notification/widgets/roundTestField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();

  Future<User?> signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login successful"),
      ));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login Failed, Please check your email and password"),
      ));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: media.height * 0.1),
                  SizedBox(
                    width: media.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: media.width * 0.03),
                        Text(
                          "Hey there",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: media.width * 0.01),
                        Text(
                          "Welcome back",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: media.width * 0.01),
                      ],
                    ),
                  ),
                  SizedBox(height: media.width * 0.01),
                  RoundedTextField(
                    textEditingController: emailController,
                    hintText: "Email", icon:"assets/email.png", textInputType: TextInputType.emailAddress,validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                  ),
                  SizedBox(height: media.width * 0.01),
                  RoundedTextField(
                    textEditingController: passController,
                    hintText: "password", icon:"assets/padlock.png", textInputType: TextInputType.text,isObsecureText:isObscure,validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your password";
                    }
                    else if(value.length<6){
                      return "password must be 6 character";
                    }
                    return null;
                  },
                    rightIcon: TextButton(
                      onPressed: (){
                        setState(() {
                          isObscure=! isObscure;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          isObscure
                          ? "assets/visible.png"
                          : "assets/eye.png"  ,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (){

                      },
                      child: Text(
                        "forgot your password ?",
                        style: TextStyle(
                          color: AppColors.secondaryColor1,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: media.width * 0.1),
                  RoundGradientButton(title:"login", onPressed:(){
                    if(_formKey.currentState!.validate()){
                      signIn(context, emailController.text, passController.text);
                    }
                  }),
                  SizedBox(height: media.width * 0.1),
                  Row(
                    children: [
                      Expanded(child:Container(width: double.maxFinite,
                      height: 1,
                      color: AppColors.grayColor.withOpacity(0.5),) ),
                      Text("or",
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      ),),
                      Expanded(child:Container(width: double.maxFinite,
                        height: 1,
                        color: AppColors.grayColor.withOpacity(0.5),) ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.primaryColor1.withOpacity(0.5),
                              width: 1,
                            )
                          ),
                          child: Image.asset("assets/google.png",height: 20,width: 20,),

                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primaryColor1.withOpacity(0.5),
                                width: 1,
                              )
                          ),
                          child: Image.asset("assets/facebook.png",height: 20,width: 20,),

                        ),
                      )
                    ],
                  ),SizedBox(height: media.width * 0.05),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  }, child: RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: "Don't have account?"),
                          TextSpan(
                            text: "register",
                            style: TextStyle(
                              color: AppColors.secondaryColor1,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          )

                        ]

                      ),
                  ))


                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
