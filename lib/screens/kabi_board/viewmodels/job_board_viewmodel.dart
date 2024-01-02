import 'dart:async';
import 'package:kabi_task/base/models/posts_response_model.dart';
import 'package:kabi_task/base/states/base_state.dart';
import 'package:kabi_task/base/viewmodels/base_viewmodel.dart';
import 'package:kabi_task/translations/locale_keys.g.dart';
import 'package:kabi_task/utils/extensions/string_extension.dart';
import '../kabi_service.dart';

class KabiViewModel extends BaseViewModel {
  final KabiService service;

  KabiViewModel(this.service);

  List<PostsResponseModel> posts = [];


  @override
  Future<void> init() async {
    if (!(state is BaseLoadingSate)) emit(BaseLoadingSate(true));
    var response = await service.getPosts();
    if (response.isSuccess && response.data != null) {
      posts = PostsResponseModel.listFromJson(response.data);
      emit(BaseCompletedState(data:posts));
    } else {
      emit(ShowErrorToastState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
      emit(BaseErrorState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
    }
  }

  @override
  FutureOr<bool> createPost(int userId,String title,String body) async{
    var response = await service.createPost(body:{title:title, body:body, userId: userId,});
    if (response.isSuccess && response.data != null) {
      emit(ShowSuccessToastState(message:'Post Added Successfully'));
      return true;
    } else {
      // emit(ShowErrorToastState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
      // emit(BaseErrorState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
      return false;
    }
  }

}
