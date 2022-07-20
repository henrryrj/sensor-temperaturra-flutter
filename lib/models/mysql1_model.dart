import 'package:mysql1/mysql1.dart';

class BDMysql {
  static String host =
          'lcpbq9az4jklobvq.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
      user = 'qjo6u6wws7494j3b',
      password = 'ayp4dq7o4ie548uf',
      database = 'n9n7mcbwue2jqi15';
  static int port = 3306;
  BDMysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: database);
    return await MySqlConnection.connect(settings);
  }
}
