import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF3F4F6),
          onPrimary: Color(0xFFF3F4F6),
          secondary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFFF44336),
          onError: Color(0xFFF44336),
          background: Color(0xFFF3F4F6),
          onBackground: Color(0xFFF3F4F6),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
          tertiary: Color(0xFF2196F3),
          onTertiary: Color(0xFF8b9cb5),
          outline: Color(0xFF0891B2),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 64, color: Color(0xFF111827)),
          displayMedium: TextStyle(fontSize: 52, color: Color(0xFF111827)),
          displaySmall: TextStyle(fontSize: 44, color: Color(0xFF111827)),
          headlineLarge: TextStyle(fontSize: 40, color: Color(0xFF111827)),
          headlineMedium: TextStyle(fontSize: 36, color: Color(0xFF111827)),
          headlineSmall: TextStyle(fontSize: 32, color: Color(0xFF111827)),
          titleLarge: TextStyle(fontSize: 28, color: Color(0xFF111827)),
          titleMedium: TextStyle(fontSize: 24, color: Color(0xFF111827)),
          titleSmall: TextStyle(fontSize: 20, color: Color(0xFF111827)),
          labelLarge: TextStyle(fontSize: 20, color: Color(0xFF111827)),
          labelMedium: TextStyle(fontSize: 16, color: Color(0xFF111827)),
          labelSmall: TextStyle(fontSize: 12, color: Color(0xFF111827)),
          bodyLarge: TextStyle(fontSize: 24, color: Color(0xFF111827)),
          bodyMedium: TextStyle(fontSize: 20, color: Color(0xFF111827)),
          bodySmall: TextStyle(fontSize: 16, color: Color(0xFF111827)),
        ),
        hintColor: const Color(0xFF8B9CB5),
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: const Color(0xFF0891B2),
          prefixIconColor: const Color(0xFF0891B2),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF0891B2), width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF0891B2), width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
        ),
        primaryColor: const Color(0xFF111827),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        iconTheme: const IconThemeData(color: Color(0xFF0891B2), size: 40),
        dividerTheme: const DividerThemeData(color: Color(0xFF0891B2)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          enableFeedback: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFF0891B2),
          unselectedItemColor: Color(0xFF4B5563),
          type: BottomNavigationBarType.fixed,
        ),
        switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(Color(0xFF111827)),
          trackColor: MaterialStatePropertyAll(Color(0xFFF3F4F6)),
          trackOutlineColor: MaterialStatePropertyAll(Color(0xFF0891B2)),
          overlayColor: MaterialStatePropertyAll(Color(0xFF0891B2)),
          trackOutlineWidth: MaterialStatePropertyAll(2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF111827),
              elevation: 0,
              shadowColor: const Color(0xFF1F2937),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xFFF3F4F6),
          elevation: 5.0,
          shadowColor: Color(0xFF111827),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xFF0891B2)),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF1F2937),
          onPrimary: Color(0xFF1F2937),
          secondary: Color(0xFF111827),
          onSecondary: Color(0xFF111827),
          error: Color(0xFFF44336),
          onError: Color(0xFFF44336),
          background: Color(0xFF1F2937),
          onBackground: Color(0xFF1F2937),
          surface: Color(0xFF1F2937),
          onSurface: Color(0xFF1F2937),
          tertiary: Color(0xFF2196F3),
          onTertiary: Color(0xFF8b9cb5),
          outline: Color(0xFF0891B2),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 64, color: Color(0xFFF9FAFB)),
          displayMedium: TextStyle(fontSize: 52, color: Color(0xFFF9FAFB)),
          displaySmall: TextStyle(fontSize: 44, color: Color(0xFFF9FAFB)),
          headlineLarge: TextStyle(fontSize: 40, color: Color(0xFFF9FAFB)),
          headlineMedium: TextStyle(fontSize: 36, color: Color(0xFFF9FAFB)),
          headlineSmall: TextStyle(fontSize: 32, color: Color(0xFFF9FAFB)),
          titleLarge: TextStyle(fontSize: 28, color: Color(0xFFF9FAFB)),
          titleMedium: TextStyle(fontSize: 24, color: Color(0xFFF9FAFB)),
          titleSmall: TextStyle(fontSize: 20, color: Color(0xFFF9FAFB)),
          labelLarge: TextStyle(fontSize: 20, color: Color(0xFFF9FAFB)),
          labelMedium: TextStyle(fontSize: 16, color: Color(0xFFF9FAFB)),
          labelSmall: TextStyle(fontSize: 16, color: Color(0xFFF9FAFB)),
          bodyLarge: TextStyle(fontSize: 24, color: Color(0xFFF9FAFB)),
          bodyMedium: TextStyle(fontSize: 20, color: Color(0xFFF9FAFB)),
          bodySmall: TextStyle(fontSize: 16, color: Color(0xFFF9FAFB)),
        ),
        hintColor: const Color(0xFF8B9CB5),
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: const Color(0xFF0891B2),
          prefixIconColor: const Color(0xFF0891B2),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF0891B2), width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF0891B2), width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: Color(0xFF8FD7E9), width: 2.0)),
        ),
        primaryColor: const Color(0xFF111827),
        scaffoldBackgroundColor: const Color(0xFF1F2937),
        iconTheme: const IconThemeData(color: Color(0xFF0891B2), size: 40),
        dividerTheme: const DividerThemeData(color: Color(0xFF0891B2)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF111827),
          elevation: 0,
          enableFeedback: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFF0891B2),
          unselectedItemColor: Color(0xFFD1D5DB),
          type: BottomNavigationBarType.fixed,
        ),
        switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(Color(0xFFF9FAFB)),
          trackColor: MaterialStatePropertyAll(Color(0xFF1F2937)),
          trackOutlineColor: MaterialStatePropertyAll(Color(0xFF0891B2)),
          overlayColor: MaterialStatePropertyAll(Color(0xFF0891B2)),
          trackOutlineWidth: MaterialStatePropertyAll(2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFF9FAFB),
              backgroundColor: const Color(0xFF111827),
              elevation: 0,
              shadowColor: const Color(0xFF1F2937),
              textStyle: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xFF111827),
          elevation: 5.0,
          shadowColor: Color(0xFFF9FAFB),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xFF0891B2)),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
          iconColor: Color(0xFF0891B2),
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Color(0xFFFF6347),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xFF0891B2),
          labelStyle: TextStyle(fontSize: 15),
          unselectedLabelColor: Color(0xFFD1D5DB),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF111827),
          foregroundColor: Color(0xFFF9FAFB),
        ),
      );
}
