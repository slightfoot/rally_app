import 'package:app/models/accounts.dart';
import 'package:app/ui/widgets.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {

	static Route<dynamic> route(BuildContext context, AccountModel account, String heroTagTitle) {
		final mediaQuery = MediaQuery.of(context);
		final box = context.findRenderObject() as RenderBox;
		final sourceRect = box.localToGlobal(Offset.zero) & box.size;
		final destRect = Offset.zero & mediaQuery.size;
		final sourceRelRect = RelativeRect.fromRect(sourceRect, destRect);
		final destRelRect = RelativeRect.fromSize(destRect, destRect.size);
		return PageRouteBuilder(
			pageBuilder: (BuildContext context, _, __) {
				return AccountScreen(
					account: account,
					heroTagTitle: heroTagTitle,
				);
			},
			transitionsBuilder: (BuildContext context, Animation<double> animation, _, Widget child) {
				Animation<RelativeRect> pos = RelativeRectTween(
					begin: sourceRelRect,
					end: destRelRect,
				).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn));
				Animation<double> fade = CurvedAnimation(parent: animation,
					curve: Interval(0.0, 0.3, curve: Curves.ease),
				);
				return FadeTransition(
					opacity: fade,
					child: Stack(
						children: <Widget>[
							PositionedTransition(
								rect: pos,
								child: child,
							),
						],
					),
				);
			},
			transitionDuration: const Duration(milliseconds: 450),
		);
	}

	const AccountScreen({
		Key key,
		@required this.account,
		@required this.heroTagTitle,
	}) : super(key: key);

	final AccountModel account;
	final String heroTagTitle;

	@override
	_AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		return BackgroundWidget(
			child: CustomScrollView(
				slivers: <Widget>[
					SliverAppBar(
						pinned: true,
						backgroundColor: theme.backgroundColor,
						title: Hero(
							tag: widget.heroTagTitle,
							child: Material(
								type: MaterialType.transparency,
								child: Text(widget.account.name,
									style: const TextStyle(
										fontWeight: FontWeight.normal,
										letterSpacing: 0.8,
									),
									overflow: TextOverflow.clip,
									maxLines: 1,
								),
							),
						),
						centerTitle: true,
						actions: <Widget>[
							IconButton(
								onPressed: _onSearchPressed,
								icon: Icon(Icons.search),
							),
						],
					),
					SliverToBoxAdapter(
						child: Container(
							height: 300.0,
							color: Colors.black12,
						),
					),
					SliverList(
						delegate: SliverChildBuilderDelegate(_buildAccountListItem),
					),
				],
			),
		);
	}

	void _onSearchPressed() {
		// FIXME: implement delegate
		/*
		showSearch(
			context: context,
			delegate: null,
		);
		*/
	}

	Widget _buildAccountListItem(BuildContext context, int index) {
		final int itemIndex = index ~/ 2;
		if (itemIndex >= 50) {
			return null;
		} else if (index.isEven) {
			return ListTile(
				title: Text('Title $index'),
				subtitle: Text('Subtitle $index'),
			);
		} else {
			return Divider(
				height: 24.0,
				color: Colors.black26,
			);
		}
	}
}
