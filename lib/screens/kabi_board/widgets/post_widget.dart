import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabi_task/base/models/posts_response_model.dart';
import 'package:kabi_task/utils/extensions/context_extension.dart';
import 'package:kabi_task/utils/extensions/string_extension.dart';
import '../../../base/constants/app_constants.dart';
import '../../../core_widgets/button_widget.dart';
import '../../../translations/locale_keys.g.dart';

class PostWidget extends StatelessWidget {
  final PostsResponseModel posts;
  final bool showButtons;
  final Function? primaryAction;
  final Function? secondaryAction;
  const PostWidget({
    Key? key,
    required this.posts,
    this.showButtons= false,
    this.primaryAction,
    this.secondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0)),
        side: BorderSide(color: AppColors.primary, width: 1),
      ),
      child: Container(
        width: context.width,
        padding: EdgeInsets.all(AppSpacing.spacingMedium.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(Text(posts.title ?? "-", style: context.textTheme.subtitle1?.copyWith(fontWeight: AppFontUtils.medium))),
            _buildText(
              Text(
                posts.body?? "-",
                style: context.textTheme.bodyText1,
              ),
            ),
            _buildButtons(context)
          ],
        ),
      ),
    );
  }

  Widget _buildText(Widget child) => Container(
        margin: EdgeInsets.only(bottom: AppSpacing.spacingXSmall.h),
        child: child,
      );

  Widget _buildButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(secondaryAction!=null)ButtonWidget(
            onPressed: secondaryAction,
            title: LocaleKeys.delete.locale,
            textStyle: context.textTheme.button,
            borderColor: AppColors.primary,
          ),
          SizedBox(width: AppSpacing.spacingSmall.w),
         if(primaryAction!=null) ButtonWidget(
            onPressed: primaryAction,
            title: LocaleKeys.show.locale,
            textStyle: context.textTheme.button?.copyWith(color: AppColors.white),
            backgroundColor: AppColors.black,
          ),
        ],
      );
}
