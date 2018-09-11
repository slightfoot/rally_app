import 'package:app/screens/launch.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';


class RallyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Rally',
			theme: AppTheme.theme,
			debugShowCheckedModeBanner: false,
			home: LaunchScreen(),
		);
	}
}
