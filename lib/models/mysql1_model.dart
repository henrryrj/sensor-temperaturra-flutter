import 'package:mysql1/mysql1.dart';

class BDMysql {
  static String host =
          'lyn7gfxo996yjjco.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
      user = 'ezavw7z2w51th1gn',
      password = 'oyxj6mhjwrl1qrp1',
      database = 'ta8n3f167849xcmb';
  static int port = 3306;
  BDMysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: database);
    return await MySqlConnection.connect(settings);
  }
}
