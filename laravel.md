# Composer를 통한 설치
```
composer create-project laravel/laravel example-app
cd example-app
php artisan serve

composer create-project laravel/jetstream example-app
cd example-app
php artisan serve
```

# mysql on macos

```
We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -uroot

To restart mysql after an upgrade:
  brew services restart mysql
Or, if you don't want/need a background service you can just run:
  /usr/local/opt/mysql/bin/mysqld_safe --datadir=/usr/local/var/mysql
```
