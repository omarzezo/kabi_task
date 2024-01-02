import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabi_task/base/constants/app_constants.dart';
import 'package:kabi_task/core_widgets/k_text.dart';



AppBar appBar({String? text,bool fromMainCategory = false,bool isTimeLogged=false,bool toHome=false,int userId=0,int mainId=0,bool isCenter = false,bool backBtn = true,required BuildContext context,List<Widget>? actions,
  refreshCheck=true,double? elevation,Widget? titleWidget}){
  return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: isCenter,titleSpacing: 0,bottomOpacity: 0,
      elevation: elevation ?? 0,
      // backgroundColor:ThemeController().isDark()?kBlackColor:kWhiteColor,title: Padding(
      // backgroundColor:kBlackColor,title: Padding(
      backgroundColor:Colors.transparent,title: Padding(
    padding:EdgeInsets.only(right:10,left:context.locale=='en'?24:0),
    child: Row(mainAxisSize:MainAxisSize.max,crossAxisAlignment:CrossAxisAlignment.center,
      children: [
        (backBtn)? Padding(padding: const EdgeInsets.only(top:10),
          child: IconButton(onPressed:() async {
            Navigator.pop(context,refreshCheck);
          },icon:
          const Icon(Icons.arrow_back_ios_rounded,color:AppColors.black)),
        ):const SizedBox(width:20,),
        Center(child: KText(title: text??'', size: PSize.large))
      ],
    ),
  ),leading:null,actions: actions);
}

