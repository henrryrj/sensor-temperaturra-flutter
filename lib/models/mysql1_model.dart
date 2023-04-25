import 'package:mysql_client/mysql_client.dart';

class BDMysql {
  Future<void> getConnection() async {
    print('QUERIENDO CONECTARNOS');
    final conn = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: '',
      databaseName: 'sensores', // optional
    );
    await conn.connect();
    print("Connected");
  }
}
