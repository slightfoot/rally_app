import 'package:flutter/material.dart';

class AppTheme {

	static const backgroundColor = const Color(0xFF2E2F36);
	static const inputColor = const Color(0xFF27292F);

	static const greenColor = const Color(0xFF1EB980);
	static const greenColor1 = const Color(0xFF29524F);
	static const greenColor2 = const Color(0xFF56AD79);
	static const greenColor3 = const Color(0xFF7AE7B6);
	static const greenColor4 = const Color(0xFF37704C);

	static const yellowColor1 = const Color(0xFFFDDD78);
	static const yellowColor2 = const Color(0xFFF96A51);
	static const yellowColor3 = const Color(0xFFFFD7CF);
	static const yellowColor4 = const Color(0xFFFFA808);

	static const panelColor = const Color(0xFF363840);

	static final theme = ThemeData(
		brightness: Brightness.dark,
		backgroundColor: backgroundColor,
		accentColor: greenColor,
		//fontFamily: 'Roboto Condensed'
	);

	static final loginTheme = theme.copyWith(
		inputDecorationTheme: InputDecorationTheme(
			fillColor: inputColor,
			filled: true,
			border: InputBorder.none,
		),
	);
}
