import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/web.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Step 2a: Define table
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get contact => text()();
}

// Step 2b: Define database
@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Insert a user
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  // Get all users
  Future<List<User>> getAllUsers() => select(users).get();
}

// Step 2c: Open connection (Web or Mobile)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      return WebDatabase('app_db'); // IndexedDB for web
    } else {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app.db'));
      return NativeDatabase(file);
    }
  });
}
