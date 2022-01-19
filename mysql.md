# couldn't connect Server : Too many connections

```
mysql> show variables like 'max_connections';
+-----------------+-------+
| Variable_name   | Value |
+-----------------+-------+
| max_connections | 151   |
+-----------------+-------+
1 row in set (0.00 sec)

mysql> show status like 'Max_used_connections';
+----------------------+-------+
| Variable_name        | Value |
+----------------------+-------+
| Max_used_connections | 153   |
+----------------------+-------+
1 row in set (0.00 sec)

mysql> show variables like '%timeout%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| connect_timeout            | 10    |
| delayed_insert_timeout     | 300   |
| innodb_lock_wait_timeout   | 50    |
| innodb_rollback_on_timeout | OFF   |
| interactive_timeout        | 28800 |
| net_read_timeout           | 30    |
| net_write_timeout          | 60    |
| slave_net_timeout          | 3600  |
| table_lock_wait_timeout    | 50    |
| wait_timeout               | 28800 |
+----------------------------+-------+
10 rows in set (0.00 sec)

mysql> show status like 'Aborted%';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| Aborted_clients  | 128   |
| Aborted_connects | 13788 |
+------------------+-------+
2 rows in set (0.00 sec)

mysql> show processlist;

151->500 변경 
mysql> set global max_connections=500;

view /etc/my.cnf
...
[mysqld]
max_connections = 500
...
```
