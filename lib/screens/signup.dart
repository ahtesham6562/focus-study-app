import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification/screens/HomeScreen.dart';
import 'package:notification/screens/login.dart';
import 'package:notification/utils/appColor.dart';
import 'package:notification/widgets/roundGradientButon.dart' show RoundGradientButton;
import 'package:notification/widgets/roundTestField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users=FirebaseFirestore.instance.collection("users");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isObscure = true;
  bool isCheck=false;
  final _formKey = GlobalKey<FormState>();



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
                          "Create An Account",
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
                    textEditingController: firstNameController,
                    hintText: "FirstName", icon:"assets/user.png", textInputType: TextInputType.name,validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your First name";
                    }
                    return null;
                  },
                  ),
                  SizedBox(height: media.width * 0.01),

                  RoundedTextField(
                    textEditingController: lastNameController,
                    hintText: "LastName", icon:"assets/user.png", textInputType: TextInputType.name,validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your last name";
                    }
                    return null;
                  },
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
                  SizedBox(height: media.width*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          isCheck= ! isCheck;
                        });
                      }
                          , icon: Icon(
                            isCheck
                            ? Icons.check_box_outlined
                             : Icons.check_box_outline_blank,
                            color: AppColors.grayColor,
                          )),
                      Expanded(child: Text(
                        "By continuing you accept privacy policy & terms of use  ",
                        style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 10,
                        ),
                      ))
                    ],
                  )
                  ,
                  SizedBox(height: media.width * 0.05),
                  RoundGradientButton(title:"Create Account", onPressed:() async {
                    if(_formKey.currentState!.validate()){
                      if(isCheck){
                        try{
                          UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
                          String uid= userCredential.user!.uid;

                          await _users.doc(uid).set({
                            'email':emailController.text,
                            'firstName':firstNameController.text,
                            'lastName':lastNameController.text


                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Account created Successfully") ));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));


                        }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString()) ));
                        }
                      }
                    }
                  },
                  ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }, child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: "Already have account?"),
                          TextSpan(
                              text: "login",
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
