import 'package:app/models/accounts.dart';
import 'package:flutter/material.dart';


class ScrollviewMax extends StatelessWidget {
	const ScrollviewMax({
		Key key,
		@required this.child,
	}) : super(key: key);

	final Widget child;

	@override
	Widget build(BuildContext context) {
		final mediaQuery = MediaQuery.of(context);
		return LayoutBuilder(
			builder: (BuildContext context, BoxConstraints viewportConstraints) {
				return SingleChildScrollView(
					padding: mediaQuery.viewInsets,
					child: ConstrainedBox(
						constraints: BoxConstraints(
							minHeight: viewportConstraints.maxHeight,
							maxHeight: viewportConstraints.maxHeight,
						),
						child: child,
					),
				);
			},
		);
	}
}

class BackgroundWidget extends StatelessWidget {
	const BackgroundWidget({
		Key key,
		this.theme,
		@required this.child,
	}) : super(key: key);

	final Widget child;
	final ThemeData theme;

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		Widget child = this.child;
		if (theme != null) {
			child = Theme(
				data: theme,
				child: child,
			);
		}
		return Material(
			color: theme.backgroundColor,
			child: child,
		);
	}
}

typedef AccountListCallback = void Function(BuildContext context);

class AccountListTile extends StatelessWidget {

	const AccountListTile({
		Key key,
		@required this.account,
		@required this.heroTag,
		this.onPressed,
	}) : super(key: key);

	final AccountModel account;
	final String heroTag;
	final AccountListCallback onPressed;

	@override
	Widget build(BuildContext context) {
		return Material(
			type: MaterialType.transparency,
			child: InkWell(
				onTap: () => onPressed(context),
				child: Row(
					children: <Widget>[
						Container(
							width: 5.0,
							height: 38.0,
							color: account.color,
						),
						Expanded(
							child: Padding(
								padding: const EdgeInsets.only(left: 12.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Hero(
											tag: heroTag,
											child: Material(
												type: MaterialType.transparency,
												child: Text(account.name,
													style: const TextStyle(
														fontSize: 16.0,
														letterSpacing: 0.8,
													),
													overflow: TextOverflow.clip,
													maxLines: 1,
												),
											),
										),
										Text('·····${account.number.substring(account.number.length - 4)}',
											style: const TextStyle(
												fontFamily: 'monospace',
												fontSize: 16.0,
												color: Colors.grey,
											),
										),
									],
								),
							),
						),
						Row(
							mainAxisSize: MainAxisSize.min,
							children: <Widget>[
								Text(account.formattedBalance,
									style: const TextStyle(
										fontFamily: 'monospace',
										fontSize: 20.0,
									),
								),
								Icon(Icons.chevron_right,
									color: Colors.grey,
								),
							],
						),
					],
				),
			),
		);
	}
}
