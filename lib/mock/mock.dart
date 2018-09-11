import 'package:app/models/accounts.dart';
import 'package:app/theme.dart';

// TODO: fetch from API

const mockAccounts = AccountSet(<AccountModel>[
	AccountModel('Checking', '1231231234', 2215.13, AppTheme.greenColor1),
	AccountModel('Home Savings', '1231235678', 8676.88, AppTheme.greenColor2),
	AccountModel('Car Savings', '1231239012', 987.48, AppTheme.greenColor3),
	AccountModel('Vacation', '1231233456', 253.0, AppTheme.greenColor4),
]);

// TODO: fetch from API
const mockBills = AccountSet(<AccountModel>[
	AccountModel('RedPay Credit', '1234', -45.36, AppTheme.yellowColor1),
	AccountModel('Rent', '1234', -1200.00, AppTheme.yellowColor2),
	AccountModel('TabFine Credit', '1234', -87.33, AppTheme.yellowColor3),
	AccountModel('ABC Loans', '1234', -400.00, AppTheme.yellowColor4),
]);
