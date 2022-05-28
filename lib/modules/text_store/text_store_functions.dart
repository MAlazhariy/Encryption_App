import 'package:encryption_app/models/text_store_model.dart';
import 'package:encryption_app/shared/components/constants.dart';
import 'package:encryption_app/shared/network/local/text_store_cache.dart';

class Groups {

  static bool isGroupExists(String groupName) {
    return groups?.groups?.firstWhere((element) => element.groupName == groupName) != null;
  }

  static bool isTitleExists({
    required String title,
    required int groupIndex,
}) {
    if(groupIndex == -1){
      return false;
    }
    return groups!.groups![groupIndex].groupContent.where((e) => e.title == title).isNotEmpty;
  }

  static int getGroupIndex(String groupName) {
    return groups?.groups?.indexWhere((element) => element.groupName == groupName)
        ?? -1;
  }

  static void addToExistGroup({
    required String groupName,
    required GroupContentModel groupModel,
  }) {
    groups!.groups![getGroupIndex(groupName)].groupContent.add(groupModel);
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void addGroup({
    required String groupName,
    required GroupContentModel groupModel,
  }) {
    if(groups?.groups == null){
      groups = StoreModel([
        GroupModel(
          groupName: groupName,
          groupContent: [groupModel],
        ),
      ]);
    } else {
      groups!.groups!.add(
        GroupModel(
          groupName: groupName,
          groupContent: [groupModel],
        ),
      );
    }

    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void addTextToGroup({
    required String groupName,
    required GroupContentModel groupModel,
  }) {
    if (isGroupExists(groupName)) {
      addToExistGroup(
        groupName: groupName,
        groupModel: groupModel,
      );
    } else {
      addGroup(
        groupName: groupName,
        groupModel: groupModel,
      );
    }

    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void deleteGroup(int groupIndex) {
    groups!.groups!.removeAt(groupIndex);
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void insertGroup({
    required int groupIndex,
    required GroupModel groupModel,
  }) {
    groups!.groups!.insert(groupIndex, groupModel);
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void changeGroupName({
    required int groupIndex,
    required GroupModel groupModel,
    required String newName,
  }) {
    groups!.groups![groupIndex].groupName = newName;
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void deleteTitle({
    required int groupIndex,
    required int titleIndex,
  }) {
    groups!.groups![groupIndex].groupContent.removeAt(titleIndex);
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void insertTitle({
    required int groupIndex,
    required int titleIndex,
    required GroupContentModel content,
  }) {
    groups!.groups![groupIndex].groupContent.insert(titleIndex, content);
    TextStoreCache.setGroups(groups!.toMap()!);
  }

  static void editTitle({
    required int groupIndex,
    required int titleIndex,
    required String newTitle,
  }) {
    groups!.groups![groupIndex].groupContent[titleIndex].title = newTitle;
    TextStoreCache.setGroups(groups!.toMap()!);
  }

}
