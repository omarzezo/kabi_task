import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabi_task/base/models/posts_response_model.dart';
import 'package:kabi_task/base/views/base_view.dart';
import 'package:kabi_task/core_widgets/app_bar.dart';
import 'package:kabi_task/core_widgets/k_button.dart';
import 'package:kabi_task/core_widgets/k_text.dart';
import 'package:kabi_task/core_widgets/k_text_field.dart';
import 'package:kabi_task/screens/kabi_board/kabi_service.dart';
import 'package:kabi_task/screens/kabi_board/viewmodels/job_board_viewmodel.dart';
import 'package:kabi_task/screens/kabi_board/widgets/try_again_widget.dart';
import 'package:kabi_task/translations/locale_keys.g.dart';
import 'package:kabi_task/utils/extensions/string_extension.dart';
import '../base/constants/app_constants.dart';


class CreatePost extends StatefulWidget {
  final String title,body;
  const CreatePost({Key? key,required this.title,required this.body}) : super(key: key);
  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost>{
 late String title=widget.title;
  late String body=widget.body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context:context,text:LocaleKeys.createPost.locale),
      body: Container(
          padding: EdgeInsets.all(AppSpacing.spacingMedium.h),
          color: AppColors.white,
          child:BaseView<KabiViewModel>(
              vmBuilder: (context) => KabiViewModel(KabiService()),
              listener: (context, state) => debugPrint(state.runtimeType.toString()),
              builder: (context, state) =>createPostView(context),
              errorBuilder: (context, state) => TryAgainWidget(errorState: state))
      ),
    );
  }
  Widget createPostView(BuildContext context){
    var vm = context.read<KabiViewModel>();
    return   SingleChildScrollView(
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
        Padding(padding: const EdgeInsets.only(top:5,bottom:4),
          child: KText(title:LocaleKeys.title.locale, size:PSize.large),
        ),
        KTextField(initialText:title,hintText:'', feedback:(value) {
          title=value??'';
        }, validator:(value) => null,),
        Padding(padding: const EdgeInsets.only(top:14,bottom:4),
          child: KText(title:LocaleKeys.body.locale, size:PSize.large),
        ),
        KTextField(initialText:body,maxLines:6,maxLength:200,hintText:'', feedback:(value) {
          body=value??'';
        }, validator:(value) => null,),
        Container(height:60,margin:const EdgeInsets.only(top:30),
          child: KButton(onPressed:() async {
            if(title.isNotEmpty||body.isNotEmpty){
            bool isSuccess =  await vm.createPost(1,title,body);
            if(isSuccess){
              Navigator.pop(context,true);
            }
            }else{
              var snackBar = const SnackBar(content: Text('Please Enter Title and Body'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },title:LocaleKeys.createPost.locale,),
        )
      ],),
    );
  }
}
