import 'package:hive/hive.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/persistence/hive_constants.dart';

class MomentDaoImpl {
  MomentDaoImpl._internal();

  static final MomentDaoImpl _singleton = MomentDaoImpl._internal();

  factory MomentDaoImpl() => _singleton;

  Future<void> saveMoment(MomentVO moment) {
    return getMomentBox().put(moment.id ?? '', moment);
  }

  List<MomentVO> getMomentList() {
    return getMomentBox().values.toList();
  }

  Stream<List<MomentVO>> getMomentListStream() {
    return Stream.value(getMomentList());
  }

  // Reacting Programming
  Stream<void> getAllMoviesEventStream() {
    return getMomentBox().watch();
  }

  Box<MomentVO> getMomentBox() {
    return Hive.box<MomentVO>(BOX_NAME_MOMENT_VO);
  }
}
