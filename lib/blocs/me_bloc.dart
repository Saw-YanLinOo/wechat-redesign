import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/view_items/moment_view_item.dart';

class MeBloc extends ChangeNotifier {
  bool isDisposed = false;

  UserVO? mUser;

  List<MomentVO>? moments;
  UserVO? user;

  final AuthenticationModel authModel = AuthenticationModelImpl();
  final WeChatModel weChatModel = WeChatModelImpl();

  MeBloc() {
    user = authModel.getLoggedInUser();

    weChatModel
        .getUserFromDatabse(authModel.getLoggedInUser().id ?? '')
        .then((user) {
      mUser = user;
      notifySafely();
    });

    weChatModel
        .getBookMarkMomentByUid(authModel.getLoggedInUser().id ?? '')
        .listen((event) {
      moments = event;
      notifySafely();
    });
  }

  Future onTapLike(bool value, MomentVO previousMoment, ReactionType type) {
    if (value == true) {
      previousMoment.reactions?.remove("${user?.id}");

      return weChatModel.editNewMoment(previousMoment, null);
    } else {
      previousMoment.reactions ??= {};
      previousMoment.reactions?.addAll({"${user?.id}": type.name});

      return weChatModel.editNewMoment(previousMoment, null);
    }
  }

  Future onTapBookMarked(bool value, MomentVO moment) {
    if (value == true) {
      return weChatModel.addBookMarkMoment('${user?.id}', moment).then((value) {
        moment.bookmarks ??= [];
        if (!(moment.bookmarks?.contains('${user?.id}') ?? true)) {
          moment.bookmarks?.add(user?.id ?? '');
        }
        return weChatModel.editNewMoment(moment, null);
      });
    } else {
      return weChatModel
          .removeBookMarkMomentByUid('${user?.id}', moment.id ?? '')
          .then((event) {
        moment.bookmarks?.remove(user?.id ?? '');

        return weChatModel.editNewMoment(moment, null);
      });
    }
  }

  void notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    isDisposed = true;
  }
}
