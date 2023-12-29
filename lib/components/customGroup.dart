import 'package:flutter/material.dart';

class GroupBlood extends StatelessWidget {
  const GroupBlood({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset("images/group.png",width: 75,height: 75 ,),
        Text("A+",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.w800),),
      ],
    );
  }
}
   