import 'dart:io';

import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';
import 'package:wechat_redesign/persistence/daos/moment_dao_impl.dart';

class WeChatModelImpl extends WeChatModel {
  WeChatModelImpl._();

  static final WeChatModelImpl _singleton = WeChatModelImpl._();

  factory WeChatModelImpl() => _singleton;

  // Network Data Agent
  final WeChatDataAgent dataAgent = CloudFireStoreDataAgentImpl();
  final AuthenticationModel authModel = AuthenticationModelImpl();

  // Persistence DAO
  final MomentDaoImpl momentDao = MomentDaoImpl();

  @override
  Future<void> addNewMoment(String description, List<File>? files) {
    if (files != null && files.isNotEmpty) {
      return uploadMultipleFile(files).then((urls) {
        return crafNewMomentVO(description, urls);
      }).then((value) {
        return dataAgent.addNewMoment(value);
      });
    } else {
      return crafNewMomentVO(description, []).then((value) {
        return dataAgent.addNewMoment(value);
      });
    }
  }

  Future<MomentVO> crafNewMomentVO(String description, List<String> imageUrl) {
    var time = DateTime.now().microsecondsSinceEpoch;

    var newFeed = MomentVO(
      id: '$time',
      description: description,
      postImages: imageUrl,
      timeStamp: '${DateTime.now()}',
      profilePicture: authModel.getLoggedInUser().profilePhoto,
      userName: authModel.getLoggedInUser().userName,
    );
    return Future.value(newFeed);
  }

  Future<List<String>> uploadMultipleFile(List<File> files) async {
    List<String> downloadFileList = [];

    // files.map((file) async {
    //   var url = await dataAgent.uploadFileToFirebase(file);
    //   return url;
    // });

    downloadFileList = await Future.wait(
      files.map((file) async {
        var url = await dataAgent.uploadFileToFirebase(file);
        return url;
      }),
    );
    return Future.value(downloadFileList);
  }

  @override
  Future<void> deleteNewMoment(String postId) {
    return dataAgent.deleteNewMoment(postId);
  }

  @override
  Future<void> editNewMoment(MomentVO newMoment, List<File>? file) {
    return dataAgent.addNewMoment(newMoment);
  }

  @override
  Stream<List<MomentVO>> getNewMoment() {
    return dataAgent.getNewMoment().map((event) {
      return event.map((e) {
        e.updateReaction("${authModel.getLoggedInUser().id}");
        return e;
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getNewMomentById(String postId) {
    return dataAgent.getNewMomentById(postId);
  }

  @override
  Future<UserVO?> getUserFromDatabse(String uid) {
    return dataAgent.getUserFromDatabse(uid);
  }

  @override
  Future<void> addNewContant(UserVO sender, UserVO reciver) {
    return dataAgent.addNewContant(sender, reciver).then((value) {
      return dataAgent.addNewContant(reciver, sender);
    });
  }

  @override
  Stream<List<UserVO>?> getUserContant(String uid) {
    return dataAgent.getUserContant(uid);
  }

  @override
  Future<void> updateUserActiveTime() {
    return getUserFromDatabse(authModel.getLoggedInUser().id ?? '')
        .then((user) {
      user?.activeTime = DateTime.now().toIso8601String();
    });
  }

  @override
  Stream<List<MomentVO>?> getBookMartMovement() {
    return momentDao.getMomentListStream();
  }

  @override
  Future<void> saveMoment(MomentVO moment) {
    return momentDao.saveMoment(moment);
  }

  @override
  Future<void> addBookMarkMoment(String uid, MomentVO moment) {
    return dataAgent.addBookMarkMomentByUid(uid, moment);
  }

  @override
  Stream<List<MomentVO>> getBookMarkMomentByUid(String uid) {
    return dataAgent.getBookMarkMomentByUid(uid);
  }

  @override
  Future<void> removeBookMarkMomentByUid(String uid, String momentId) {
    return dataAgent.removeBookMarkMomentByUid(uid, momentId);
  }
}
