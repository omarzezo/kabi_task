import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabi_task/base/constants/app_constants.dart';
import 'package:kabi_task/base/states/base_state.dart';
import 'package:kabi_task/base/views/base_view.dart';
import 'package:kabi_task/core_widgets/app_bar.dart';
import 'package:kabi_task/screens/kabi_board/kabi_service.dart';
import 'package:kabi_task/screens/kabi_board/viewmodels/job_board_viewmodel.dart';
import 'package:kabi_task/screens/create_post_screen.dart';
import 'package:kabi_task/screens/kabi_board/views/posts_view.dart';
import 'package:kabi_task/screens/kabi_board/widgets/try_again_widget.dart';
import 'package:kabi_task/translations/locale_keys.g.dart';
import 'package:kabi_task/utils/extensions/string_extension.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context:context,text:LocaleKeys.appBarTitle.locale,backBtn:false),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.white,
              child: BaseView<KabiViewModel>(
                vmBuilder: (context) => KabiViewModel(KabiService()),
                listener: (context, state) => debugPrint(state.runtimeType.toString()),
                builder: (context, state) => _buildTabBarView(state as BaseCompletedState),
                errorBuilder: (context, state) => TryAgainWidget(errorState: state),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BaseCompletedState state){
    return PostsView(posts: (state.data));
  }
}
