import 'dart:ui';

class AccountModel {
	final String name;
	final String number;
	final double balance;
	final Color color;

	const AccountModel(this.name, this.number, this.balance, this.color);

	String get formattedBalance => '\$${balance.toStringAsFixed(2)}';

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
			other is AccountModel &&
				runtimeType == other.runtimeType &&
				name == other.name &&
				number == other.number &&
				balance == other.balance;

	@override
	int get hashCode =>
		name.hashCode ^
		number.hashCode ^
		balance.hashCode;
}

class AccountSet {
	final List<AccountModel> _accounts;

	const AccountSet(List<AccountModel> accounts)
		: _accounts = accounts;

	operator [](int index) => _accounts[index];

	int get length => _accounts.length;

	double get total => _accounts.fold(0.0, (prev, account) => prev + account.balance);

	String get formattedTotal => '\$${total.toStringAsFixed(2)}';

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
			other is AccountSet &&
				runtimeType == other.runtimeType &&
				_accounts == other._accounts;

	@override
	int get hashCode => _accounts.hashCode;
}