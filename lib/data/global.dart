import 'package:digifest/data/db/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

late DatabaseHelper databaseHelper;
final NumberFormat rupiah = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
late final SharedPreferences dataCache;
