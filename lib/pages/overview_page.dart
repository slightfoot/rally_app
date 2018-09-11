import 'package:app/mock/mock.dart';
import 'package:app/models/accounts.dart';
import 'package:app/screens/account.dart';
import 'package:app/screens/main.dart';
import 'package:app/theme.dart';
import 'package:app/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OverviewPage extends StatelessWidget {

	const OverviewPage({
		Key key,
		@required this.jumpToMainTab,
	}) : super(key: key);

	final MainTabJumper jumpToMainTab;

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			padding: const EdgeInsets.symmetric(vertical: 8.0),
			child: Column(
				children: <Widget>[
					// Alerts
					_OverviewPanel(
						margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
						padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 16.0),
						top: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text('Alerts'),
								SizedBox(
									child: _SeeAll(
										onPressed: () {}, // FIXME Link to tab
									),
								),
							],
						),
						bottom: Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Expanded(
									child: Text('Heads up, you\'ve used up 90% of your Shopping budge for this month.',
										style: const TextStyle(
											letterSpacing: 0.8,
										),
									),
								),
								Icon(Icons.pie_chart),
							],
						),
					),
					// Accounts
					_AccountListPanel(
						title: 'Accounts',
						accountSet: mockAccounts,
						maxAccounts: 3,
						margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
						onSeeAll: () => jumpToMainTab(MainTab.Accounts),
					),
					// Bills
					_AccountListPanel(
						title: 'Bills',
						accountSet: mockBills,
						margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
						onSeeAll: () => jumpToMainTab(MainTab.Bills),
					),
				],
			),
		);
	}
}

class _AccountListPanel extends StatelessWidget {
	const _AccountListPanel({
		Key key,
		@required this.title,
		@required this.accountSet,
		this.onSeeAll,
		this.maxAccounts,
		this.margin = const EdgeInsets.all(16.0),
	}) : super(key: key);

	final String title;
	final AccountSet accountSet;
	final int maxAccounts;
	final VoidCallback onSeeAll;
	final EdgeInsetsGeometry margin;

	@override
	Widget build(BuildContext context) {
		return _OverviewPanel(
			margin: margin,
			padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
			top: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Text(title),
					Text(accountSet.formattedTotal, style: const TextStyle(
						fontSize: 48.0,
					)),
					Container(
						height: 1.0,
						color: Colors.black12,
					),
					Padding(
						padding: const EdgeInsets.symmetric(vertical: 12.0),
						child: ListView.separated(
							physics: const NeverScrollableScrollPhysics(),
							shrinkWrap: true,
							itemCount: maxAccounts != null ? math
								.min(maxAccounts, accountSet.length) : accountSet.length,
							itemBuilder: (BuildContext context, int index) {
								final account = accountSet[index];
								final heroTag = '$title-panel-$index';
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
							separatorBuilder: (BuildContext context, int index) {
								return Divider(
									height: 24.0,
									color: Colors.black26,
								);
							},
						),
					),
				],
			),
			bottom: _SeeAll(
				onPressed: onSeeAll,
			),
		);
	}
}

class _OverviewPanel extends StatelessWidget {
	const _OverviewPanel({
		Key key,
		@required this.top,
		@required this.bottom,
		this.margin = const EdgeInsets.all(16.0),
		this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
	})
		: assert(margin != null && padding != null),
			super(key: key);

	final Widget top;
	final Widget bottom;
	final EdgeInsetsGeometry margin;
	final EdgeInsetsGeometry padding;

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: margin,
			color: AppTheme.panelColor,
			child: Padding(
				padding: padding,
				child: Column(
					children: <Widget>[
						top,
						Container(
							height: 1.0,
							color: Colors.black12,
						),
						bottom,
					],
				),
			),
		);
	}
}

class _SeeAll extends StatelessWidget {
	final VoidCallback onPressed;

	const _SeeAll({
		Key key, this.onPressed,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Semantics(
			container: true,
			button: true,
			enabled: onPressed != null,
			child: Material(
				type: MaterialType.transparency,
				child: InkWell(
					onTap: onPressed,
					child: Container(
						alignment: Alignment.center,
						height: 38.0,
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 8.0),
							child: Text('SEE ALL',
								style: const TextStyle(
									fontWeight: FontWeight.w500,
									letterSpacing: 2.0,
								),
							),
						),
					),
				),
			),
		);
	}
}
