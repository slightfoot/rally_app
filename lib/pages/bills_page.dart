import 'package:app/mock/mock.dart';
import 'package:app/screens/account.dart';
import 'package:app/ui/layouts.dart';
import 'package:app/ui/widgets.dart';
import 'package:flutter/material.dart';


class BillsPage extends StatelessWidget {
	const BillsPage({
		Key key
	}) : super(key: key);


	@override
	Widget build(BuildContext context) {
		return AccountChartLayout(
			accountSet: mockBills, // TODO: replace with backend call.
			builder: (BuildContext context, int index) {
				final bill = mockBills[index];
				final heroTag = 'bills-page-item-$index';
				return AccountListTile(
					account: bill,
					heroTag: heroTag,
					onPressed: (context) {
						Navigator.of(context).push(
							AccountScreen.route(context, bill, heroTag),
						);
					},
				);
			},
		);
	}
}
