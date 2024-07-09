# lvdisplay
```
  --- Logical volume ---
  LV Path                /dev/rl/swap
  LV Name                swap
  VG Name                rl
  LV UUID                B7T9k7-Rja3-x05B-umFr-K5vu-6Qgp-rGeFaq
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-06-01 19:47:53 +0900
  LV Status              available
  # open                 2
  LV Size                2.00 GiB
  Current LE             512
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/rl/root
  LV Name                root
  VG Name                rl
  LV UUID                pSTr12-OxhZ-2JlU-eHFi-Ex0q-dO0R-ZAistu
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-06-01 19:47:53 +0900
  LV Status              available
  # open                 1
  LV Size                <17.00 GiB
  Current LE             4351
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0
```

# lvresize -L +80G /dev/rl/root
```
  Size of logical volume rl/root changed from <17.00 GiB (4351 extents) to <97.00 GiB (24831 extents).
  Logical volume rl/root successfully resized.
```

# xfs filesystem
```
xfs_growfs /dev/mapper/rl-root
```

# ext4 filesystem
```
resize2fs /dev/mapper/rl-root
```

# file 생성
```
fallocate -l 70G filename
dd if=/dev/zero of=filename bs=1G count=70
truncate -s 70G filename
```

