import 'package:app/mock/mock.dart';
import 'package:app/models/accounts.dart';
import 'package:app/screens/account.dart';
import 'package:app/ui/layouts.dart';
import 'package:app/ui/widgets.dart';
import 'package:flutter/material.dart';


class AccountsPage extends StatelessWidget {
	const AccountsPage({
		Key key
	}) : super(key: key);


	@override
	Widget build(BuildContext context) {
		return AccountChartLayout(
			accountSet: mockAccounts, // TODO: replace with backend call.
			builder: (BuildContext context, int index) {
				final account = mockAccounts[index];
				final heroTag = 'accounts-page-item-$index';
				return AccountListTile(
					account: account,
					heroTag: heroTag,
					onPressed: (context) {
						Navigator.of(context).push(
							AccountScreen.route(context, account, heroTag),
						);
					},
				);
			},
		);
	}
}
