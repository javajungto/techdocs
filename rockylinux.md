# neofetch
```
dnf install epel-release
dnf -y install neofetch
neofetch
```
# nmcli
```
nmcli connection show
nmcli connection show enp0s25
```

# mv 대신
```
rsync -ah --progress --remove-source-files /mnt/c/*.img .
```

# 온도 측정
```
on rockylinux 9.4

# dnf -y install lm_sensors
# sensors-detect
# sensors

```
