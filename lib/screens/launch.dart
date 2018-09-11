import 'dart:async';

import 'package:app/assets.dart';
import 'package:app/screens/main.dart';
import 'package:app/theme.dart';
import 'package:app/ui/widgets.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
	@override
	_LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

	final GlobalKey<FormState> _formKey = GlobalKey();

	FocusNode _usernameFocus;
	FocusNode _passwordFocus;
	FocusNode _submitFocus;

	bool _usernameValidated;
	bool _passwordValidated;

	bool _processing = false;


	@override
	void initState() {
		super.initState();
		_usernameFocus = FocusNode();
		_passwordFocus = FocusNode();
		_submitFocus = FocusNode();
	}

	@override
	void dispose() {
		_submitFocus.dispose();
		_passwordFocus.dispose();
		_usernameFocus.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return BackgroundWidget(
			theme: AppTheme.loginTheme,
			child: Form(
				key: _formKey,
				child: ScrollviewMax(
					child: IgnorePointer(
						ignoring: _processing,
						child: SafeArea(
							child: Stack(
								children: <Widget>[
									Padding(
										padding: const EdgeInsets.symmetric(horizontal: 16.0),
										child: Column(
											children: <Widget>[
												Expanded(
													child: Center(
														child: Image.asset(Images.logo, width: 140.0,),
													),
												),
												TextFormField(
													focusNode: _usernameFocus,
													validator: _validateRequired('Username',
															(value) => _usernameValidated = value),
													decoration: InputDecoration(
														suffixIcon: _buildValidationIcon(context, _usernameValidated),
														hintText: 'Username',
													),
													onFieldSubmitted: _onUsernameSubmitted,
												),
												SizedBox(height: 16.0),
												TextFormField(
													focusNode: _passwordFocus,
													validator: _validateRequired('Password',
															(value) => _passwordValidated = value),
													obscureText: true,
													decoration: InputDecoration(
														suffixIcon: _buildValidationIcon(context, _passwordValidated),
														hintText: 'Password',
													),
													onFieldSubmitted: _onPasswordSubmitted,
												),
												Expanded(
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: <Widget>[
															Icon(Icons.fingerprint,
																size: 72.0,
																color: Colors.black,
															),
															SizedBox(height: 8.0),
															Text('Or login with Touch ID'),
															SizedBox(height: 36.0),
														],
													)
												),
											],
										),
									),
									AnimatedSwitcher(
										duration: const Duration(milliseconds: 450),
										child: !_processing ? null : Center(
											child: CircularProgressIndicator(),
										),
									),
								],
							),
						),
					),
				),
			),
		);
	}

	Widget _buildValidationIcon(BuildContext context, bool validated) {
		final theme = Theme.of(context);
		if (validated == null) {
			return null;
		}
		if (validated) {
			return Icon(Icons.check, color: theme.accentColor);
		} else {
			return Icon(Icons.close, color: theme.errorColor);
		}
	}

	FormFieldValidator<String> _validateRequired(String fieldName, ValueSetter<bool> validated) {
		return (String value) {
			if (value == null || value
				.trim()
				.isEmpty) {
				validated(false);
				return 'Please enter $fieldName';
			}
			else {
				validated(true);
				return null;
			}
		};
	}

	void _onUsernameSubmitted(String value) {
		_formKey.currentState.validate();
		FocusScope.of(context).requestFocus(_passwordFocus);
	}

	void _onPasswordSubmitted(String value) {
		_formKey.currentState.validate();
		FocusScope.of(context).requestFocus(_submitFocus);
		_onSubmitLogin();
	}

	void _onSubmitLogin() async {
		setState(() => _processing = true);

		// Pretend magic server stuff happens here
		await Future.delayed(Duration(seconds: 2));

		if (mounted) {
			setState(() => _processing = false);
			Navigator.of(context).push(MainScreen.route());
		}
	}
}
