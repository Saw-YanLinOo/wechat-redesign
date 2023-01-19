import 'dart:io';

import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/otp_code_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

abstract class WeChatDataAgent {
  // Auth
  Future registerNewUser(UserVO newUser);
  Future login(String email, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();

  Future<OtpCodeVO> getOTP();

  Stream<List<MomentVO>> getNewMoment();
  Future<void> addNewMoment(MomentVO newMoment);
  Future<void> deleteNewMoment(String postId);
  Stream<MomentVO> getNewMomentById(String postId);
  Future<String> uploadFileToFirebase(File file);
  Future<UserVO?> getUserFromDatabse(String uid);

  Future<void> addBookMarkMomentByUid(String uid, MomentVO moment);
  Future<void> removeBookMarkMomentByUid(String uid, String momentId);
  Stream<List<MomentVO>> getBookMarkMomentByUid(String uid);

  Future<void> addNewContant(UserVO sender, UserVO reciver);
  Stream<List<UserVO>?> getUserContant(String uid);
}
