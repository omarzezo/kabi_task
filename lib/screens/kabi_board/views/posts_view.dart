import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabi_task/base/models/posts_response_model.dart';
import 'package:kabi_task/screens/kabi_board/viewmodels/job_board_viewmodel.dart';
import 'package:kabi_task/screens/create_post_screen.dart';
import '../../../base/constants/app_constants.dart';
import '../../../core_widgets/no_post_widget.dart';
import '../widgets/post_widget.dart';

class PostsView extends StatelessWidget {
  final List<PostsResponseModel> posts;
  const PostsView({Key? key,this.posts=const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<KabiViewModel>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(AppSpacing.spacingMedium.h),
        color: AppColors.white,
        child: posts.isEmpty
            ? const NoPostWidget()
            : RefreshIndicator(
                onRefresh: () async {
                  await vm.init();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int index = 0; index < posts.length; index++)
                        PostWidget(
                          key: ValueKey<int>(posts[index].id!),
                          posts: posts[index],
                          showButtons:true,
                          primaryAction: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                CreatePost(title:posts[index].title??'',body:posts[index].body??''))).then((value) async {
                              if(value!=null&&value){
                                await vm.init();
                              }
                            });
                          },
                        )
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton(
        hoverColor: Colors.black,
        elevation: 10,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePost(title:'',body:'',))).then((value) async {
            if(value!=null&&value){
              await vm.init();
            }
          });
        },
        backgroundColor:AppColors.black,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: const Icon(Icons.add,),
      ),
    );
  }
}
