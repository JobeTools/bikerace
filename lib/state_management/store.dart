import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

// Define actions for settings and user data
// Define actions for settings and user data
// Define actions for settings and user data
enum Actions {
  ToggleDarkMode,
  UpdateUsername,
  SetAuthenticatedUser,
  // Add more actions as needed
}

// Define the shape of your state
class AppState {
  bool isDarkMode;
  // Add more state properties as needed

  AppState({
    required this.isDarkMode,
    // Initialize other state properties here
  });
}

class User {
  final String userId;
  final String username;
  final String email;
  final String points;
  final String bannerImagePath;

  User(this.userId, this.username, this.email, this.bannerImagePath,
      this.points);
}

// Define your reducers
AppState appReducer(AppState state, dynamic action) {
  if (action is ToggleDarkModeAction) {
    return AppState(
      isDarkMode: !state.isDarkMode,
      // Update other state properties as needed
    );
  } else if (action is UpdateUsernameAction) {
    return AppState(
      isDarkMode: state.isDarkMode,
      // Update other state properties as needed
    );
  } else if (action is SetAuthenticatedUserAction) {
    return AppState(
      isDarkMode: state.isDarkMode,
      // Update other state properties with authenticated user information
    );
  }
  return state;
}

// Define actions for settings
class ToggleDarkModeAction {}

// Define actions for user data
class UpdateUsernameAction {
  final String username;

  UpdateUsernameAction(this.username);
}

// Define actions for authenticated user
class SetAuthenticatedUserAction {
  final String userId;

  SetAuthenticatedUserAction(this.userId);
}

class SetUserDataAction {
  final User? userData;

  SetUserDataAction(this.userData);
}

class AppThunk {
  static Function fetchUserData(String userId) {
    return (Store<AppState> store) async {
      // Perform API request or database query to fetch user data
      // Example: Assuming an API method called `fetchUserById`
      try {
        //User userData = await API.fetchUserById(userId); this line is a place holder
        //store.dispatch(SetUserDataAction(userData));
      } catch (error) {
        // Handle error if fetching user data fails
      }
    };
  }
}

// Create a Redux store for the app state
final store = Store<AppState>(
  appReducer,
  initialState: AppState(isDarkMode: false),
  middleware: [saveStateMiddleware, asyncActionMiddleware],
);

// Add a middleware to save the state to the database when it changes
void saveStateMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  next(action); // Call the next middleware in the chain

  // Save the state to the database
  final database = await openDatabase(
    join(await getDatabasesPath(), 'app_database.db'),
    version: 1,
  );

  if (action is ToggleDarkModeAction) {
    await database.rawInsert(
        'INSERT OR REPLACE INTO settings(id, isDarkMode) VALUES(1, ?)',
        [store.state.isDarkMode ? 1 : 0]);
  } else if (action is UpdateUsernameAction) {
    await database.rawInsert(
        'INSERT OR REPLACE INTO user(id, username) VALUES(1, ?)',
        [store.state]);
  }
}

// Define a custom middleware for handling asynchronous actions
void asyncActionMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is Future) {
    await action;
  } else {
    next(action);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the SQLite database
  final database = await openDatabase(
    join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) {
      // Create tables for settings and user data
      db.execute(
          'CREATE TABLE settings(id INTEGER PRIMARY KEY, isDarkMode INTEGER)');
      db.execute('CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT)');
    },
    version: 1,
  );

  // Fetch initial settings and user data from the database
  final List<Map<String, dynamic>> settingsResults =
      await database.query('settings');
  final List<Map<String, dynamic>> userResults = await database.query('user');
  final bool initialDarkMode = settingsResults.isNotEmpty
      ? settingsResults[0]['isDarkMode'] == 1
      : false;
  final String initialUsername =
      userResults.isNotEmpty ? userResults[0]['username'] : '';

  // Dispatch initial actions to populate the store with the data from the database
  store.dispatch(ToggleDarkModeAction());
  store.dispatch(UpdateUsernameAction(initialUsername));
}
