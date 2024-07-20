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
# /etc/fstab
```
# blkid

# cat /etc/fstab 
# <file system> <mount point> <type> <options> <dump> <pass>
/dev/pve/root / ext4 errors=remount-ro 0 1
UUID=Exxxxxx /boot/efi vfat defaults 0 1
/dev/pve/swap none swap sw 0 0
proc /proc proc defaults 0 0
/dev/sdb1 /mnt/ssd1gb xfs defaults 0 1

# mount -av
/                        : ignored
/boot/efi                : already mounted
none                     : ignored
/proc                    : already mounted
/mnt/ssd1gb              : already mounted

dump 설정 : 파일 시스템의 덤프 가능 여부를 설정한다.

0: dump 되지 않는 파일 시스템
1 : 백업 등의 목적으로 덤프 가능한 filesystem
```
