import '../../features/auth/models/user_info.dart';
import '../services/hive.dart';

extension UserModelCache on HiveLocalStorage {
  Future<void> saveUserModel(UserModel userModel) async {
    if (containsKey('userModel')) {
      await delete('userModel');
    }
    await put('userModel', userModel.toJson());
  }

  UserModel? getUserModel() {
    final userJson = get('userModel');
    if (userJson != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    }
    return null;
  }
}
