abstract class LocalStorage {
  Future<String?> getString({required String key});

  Future<void> setString({required String key, required String content});
  Future<bool> clear();

  Future<List<String>?> getStringList({required String key});

  Future<void> setStringList({
    required String key,
    required List<String>? content,
  });

  Future<void> setJsonList({
    required String key,
    required List<Map<String, dynamic>> content,
  });
  Future<List<Map<String, dynamic>>?> getJsonList({
    required String key,
  });
}
