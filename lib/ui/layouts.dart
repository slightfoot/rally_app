import 'package:app/models/accounts.dart';
import 'package:app/ui/charts.dart';
import 'package:flutter/material.dart';


class AccountChartLayout extends StatelessWidget {
	const AccountChartLayout({
		Key key,
		@required this.accountSet,
		@required this.builder,
	}) : super(key: key);

	final AccountSet accountSet;
	final IndexedWidgetBuilder builder;

	@override
	Widget build(BuildContext context) {
		return CustomScrollView(
			slivers: <Widget>[
				SliverToBoxAdapter(
					child: Container(
						height: 300.0,
						padding: const EdgeInsets.all(16.0),
						alignment: Alignment.center,
						child: AspectRatio(
							aspectRatio: 1.0,
							child: CustomPaint(
								painter: CircleChartPainter(
									accountSet: accountSet,
									strokeWidth: 4.0,
								),
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Text('Total',
											style: const TextStyle(
												letterSpacing: 0.8,
											),
										),
										Padding(
											padding: const EdgeInsets.symmetric(vertical: 24.0),
											child: Text(accountSet.formattedTotal,
												style: const TextStyle(
													fontSize: 44.0,
												),
											),
										),
										Icon(Icons.info_outline, color: Colors.grey),
									],
								),
							),
						)
					),
				),
				SliverToBoxAdapter(
					child: Divider(
						color: Colors.black26,
					),
				),
				// TODO: Wrap with decoration for panelColor
				SliverPadding(
					padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
					sliver: SliverList(
						delegate: SliverChildBuilderDelegate(_buildAccountListItem),
					),
				),
			],
		);
	}

	Widget _buildAccountListItem(BuildContext context, int index) {
		final int itemIndex = index ~/ 2;
		if (itemIndex >= accountSet.length) {
			return null;
		} else if (index.isEven) {
			return builder(context, itemIndex);
		} else {
			return Divider(
				height: 24.0,
				color: Colors.black26,
			);
		}
	}
}