import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Views/homepage.dart';
import 'package:pizza/providers/authentiction.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
 final  TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white10
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       child: Stack(
         children: [
           Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 stops: [
                   .2,.45,.6,.9
                 ],
                 colors: [
                   Color(0xFF200B4B),Color(0xFF201F22),Color(0xFF1A1031),Color(0xFF19181F)               ]

               )
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: 500,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage('images/sign.png')
                 )
               ),
             ),
           ),
           Positioned(
               top: 440,
               left: 10,
               child:Container(
                 height: 200,
                 width: 220,
                 child: RichText(
                   text: TextSpan(
                     text: 'Pizzato',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold,fontSize: 46),
                     children: <TextSpan>[
                       TextSpan(
                         text: ' At Your',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)
                       ),
                       TextSpan(
                           text: ' Service',style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold)
                       )
                     ]
                   ),
                 ),
               )),
           Positioned(
               top: 620,

               child:Container(
                 width: 400,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     GestureDetector(
                     onTap: (){
                       loginSheet(context);
                     },
                       child: Container(
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.white),
                           borderRadius: BorderRadius.circular(25)
                         ),
                         width: 100,
                         height: 50,
                         child: Center(
                           child: Text('Login',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)),




                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         signupSheet(context);
                       },
                       child: Container(
                         decoration: BoxDecoration(
                             border: Border.all(color: Colors.white),
                             borderRadius: BorderRadius.circular(25)
                         ),
                         width: 100,
                         height: 50,
                         child: Center(
                           child: Text('SignUp',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20,fontWeight: FontWeight.bold)),




                         ),
                       ),
                     )
                   ],
                 ),
               )),
           Positioned(
               top: 720,
               left: 20,
               right: 20,

               child: Container(
                 width: 400,
                 constraints: BoxConstraints(maxHeight: 200),
                 child: Column(
                   children: [
                     Text("By Continuing You Agree Pizzato's Terms",style: TextStyle(color: Colors.grey.shade600,fontSize: 12,)),
                     Text("Service & Privacy Policy",style: TextStyle(color: Colors.grey.shade600,fontSize: 12,))
                   ],
                 ),
               ))
         ],

       )
      ),
    );
  }
  loginSheet(BuildContext context)
  {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (context){

      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF191531)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Email..'
                            ,hintStyle:TextStyle(
                          color: Colors.white
                      ),
                      ),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white
                          ,fontWeight: FontWeight.bold
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter password..'
                        ,hintStyle:TextStyle(
                          color: Colors.white
                      ),
                      ),
                      controller: password,
                      style: TextStyle(
                          color: Colors.white
                          ,fontWeight: FontWeight.bold
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(FontAwesomeIcons.check,color: Colors.white,),
                        onPressed: ()=>Provider.of<Authentiction>(context,listen: false)
                            .loginToAccount(email.text, password.text).whenComplete(() {
                              if(Provider.of<Authentiction>(context,listen: false).getErrMessage==''){
                                Navigator.pushReplacement(context,
                                    PageTransition(child: HomePage(), type:PageTransitionType.rightToLeft));
                              }
                               else //(Provider.of<Authentiction>(context,listen: false).getErrMessage!='')
                              {
                                showToast(Provider.of<Authentiction>(context,listen: false).getErrMessage, context);
                                Navigator.pushReplacement(context,
                                    PageTransition(child: Login(), type:PageTransitionType.rightToLeft));
                              erroMessage='';
                              }
                              //erroMessage='';
                        }

                        )),
                  ),
                  Text(Provider.of<Authentiction>(context,listen: true).getErrMessage,style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
          ),
        ),
      );

    });
  }
 signupSheet(BuildContext context){
   return showModalBottomSheet(

       isScrollControlled: true,
       context: context, builder: (context){

     return Padding(
       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
       child: Container(
         height: 400,
         width: 400,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(25),
             color: Color(0xFF191531)
         ),
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextField(
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       hintText: 'Enter Email..'
                       ,hintStyle:TextStyle(
                         color: Colors.white
                     ),
                     ),
                     controller: email,
                     style: TextStyle(
                         color: Colors.white
                         ,fontWeight: FontWeight.bold
                     ),

                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextField(
                     obscureText: true,
                     decoration: InputDecoration(
                       hintText: 'Enter password..'
                       ,hintStyle:TextStyle(
                         color: Colors.white
                             ,fontWeight: FontWeight.bold
                     ),
                     ),
                     controller: password,
                     style: TextStyle(
                         color: Colors.white
                     ),

                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child:FloatingActionButton(
                       backgroundColor: Colors.lightBlueAccent,
                       child: Icon(FontAwesomeIcons.check,color: Colors.white,),
                       onPressed: ()=>Provider.of<Authentiction>(context,listen: false)
                           .createNewAccount(email.text, password.text).whenComplete(() {
                         if(Provider.of<Authentiction>(context,listen: false).getErrMessage==''){
                           Navigator.pushReplacement(context,
                               PageTransition(child: HomePage(), type:PageTransitionType.rightToLeft));
                         }
                         //if(Provider.of<Authentiction>(context,listen: false).getErrMessage!='')
                         else{
                           showToast(Provider.of<Authentiction>(context,listen: false).getErrMessage, context);

                           Navigator.pushReplacement(context,
                               PageTransition(child: Login(), type:PageTransitionType.rightToLeft)
                           );
                         erroMessage='';
                         }
                       })),
                 ),
                 Text(Provider.of<Authentiction>(context,listen: true).getErrMessage,style: TextStyle(
                     color: Colors.white,fontWeight: FontWeight.bold
                 ),)
               ],
             ),
           ),
         ),
       ),
     );

   });

 }
 void showToast(String msg, BuildContext ctx) {

   Widget cancelButton = TextButton(
     child: Text("Cancel"),
     onPressed:  () {
       Navigator.pop(ctx);
     },
   );
   Widget continueButton = TextButton(
     child: Text("Continue"),
     onPressed:  () {},
   );

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text("Alert"),
     content: Text(msg),
     actions: [
       cancelButton,
       continueButton,
     ],
   );

   // show the dialog
   showDialog(
     context: ctx,
     builder: (BuildContext context) {
       return alert;
     },
   );
   /*Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
    );*/
 }
}
