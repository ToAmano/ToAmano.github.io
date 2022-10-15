

## サーバーにHDDをマウントする

サーバーの容量を増やすためにHDDを追加した．しかし，ただ単に追加しただけでは本体に認識されていない．実際に`df`コマンドをやるとまだ追加したHDDは見えない（/dev/nvme0n1p2は既に追加してあるやつで違う．）

```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev             32G     0   32G   0% /dev
tmpfs           6.3G  2.4M  6.3G   1% /run
/dev/nvme0n1p2  916G   11G  859G   2% /
tmpfs            32G     0   32G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs            32G     0   32G   0% /sys/fs/cgroup
/dev/loop0       56M   56M     0 100% /snap/core18/2284
/dev/loop1      128K  128K     0 100% /snap/bare/5
/dev/loop5      219M  219M     0 100% /snap/gnome-3-34-1804/77
/dev/loop4       62M   62M     0 100% /snap/core20/1270
/dev/loop6      248M  248M     0 100% /snap/gnome-3-38-2004/87
/dev/nvme0n1p1  511M  5.3M  506M   2% /boot/efi
/dev/loop8       66M   66M     0 100% /snap/gtk-common-themes/1519
/dev/loop11     219M  219M     0 100% /snap/gnome-3-34-1804/72
/dev/loop12      55M   55M     0 100% /snap/snap-store/558
/dev/loop13      64M   64M     0 100% /snap/core20/1623
/dev/loop14      56M   56M     0 100% /snap/core18/2566
/dev/loop2       48M   48M     0 100% /snap/snapd/17029
/dev/loop7       46M   46M     0 100% /snap/snap-store/599
/dev/loop15     347M  347M     0 100% /snap/gnome-3-38-2004/119
tmpfs           6.3G   44K  6.3G   1% /run/user/1000
/dev/loop16      92M   92M     0 100% /snap/gtk-common-themes/1535
```

一方で，HDDデバイス自体が認識されていることは`lshw`コマンドで確認できる．このコマンドだと商品の型番まで表示してくれるのでわかりやすい．

```bash
% sudo lshw -c disk
  *-namespace
       description: NVMe namespace
       physical id: 1
       logical name: /dev/nvme0n1
       size: 931GiB (1TB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: guid=a5fffa96-1db9-4188-917a-ee3eda5f1fed logicalsectorsize=512 sectorsize=512
  *-disk
       description: ATA Disk
       product: APPLE HDD HTS541
       physical id: 0.0.0
       bus info: scsi@0:0.0.0
       logical name: /dev/sda
       version: B5N0
       serial: J88000D8G94MTD
       size: 931GiB (1TB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=5 guid=47a20605-966b-4749-8783-f78ac800df95 logicalsectorsize=512 sectorsize=4096
  *-disk
       description: ATA Disk
       product: WDC WD10EZEX-60M
       vendor: Western Digital
       physical id: 0.0.0
       bus info: scsi@1:0.0.0
       logical name: /dev/sdb
       version: 1A03
       serial: WD-WCC3F3ZFFC0S
       size: 931GiB (1TB)
       capabilities: partitioned partitioned:dos
       configuration: ansiversion=5 logicalsectorsize=512 sectorsize=4096 signature=41855b71
  *-cdrom
       description: DVD reader
       product: DVDROM DUD1N
       vendor: hp HLDS
       physical id: 0.0.0
       bus info: scsi@4:0.0.0
       logical name: /dev/cdrom
       logical name: /dev/dvd
       logical name: /dev/sr0
       version: MDM2
       capabilities: removable audio dvd
       configuration: ansiversion=5 status=nodisc
```

認識されていることがわかったら，`lsblk`コマンドや`fdisk`コマンドでさらに詳細をみてみる．

```bash
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0         7:0    0  55.5M  1 loop /snap/core18/2284
loop1         7:1    0     4K  1 loop /snap/bare/5
loop2         7:2    0    48M  1 loop /snap/snapd/17029
loop4         7:4    0  61.9M  1 loop /snap/core20/1270
loop5         7:5    0   219M  1 loop /snap/gnome-3-34-1804/77
loop6         7:6    0 247.9M  1 loop /snap/gnome-3-38-2004/87
loop7         7:7    0  45.9M  1 loop /snap/snap-store/599
loop8         7:8    0  65.2M  1 loop /snap/gtk-common-themes/1519
loop11        7:11   0   219M  1 loop /snap/gnome-3-34-1804/72
loop12        7:12   0  54.2M  1 loop /snap/snap-store/558
loop13        7:13   0  63.2M  1 loop /snap/core20/1623
loop14        7:14   0  55.6M  1 loop /snap/core18/2566
loop15        7:15   0 346.3M  1 loop /snap/gnome-3-38-2004/119
loop16        7:16   0  91.7M  1 loop /snap/gtk-common-themes/1535
sda           8:0    0 931.5G  0 disk
├─sda1        8:1    0    16M  0 part
└─sda2        8:2    0 931.5G  0 part
sdb           8:16   0 931.5G  0 disk
├─sdb1        8:17   0   549M  0 part
└─sdb2        8:18   0   931G  0 part
sr0          11:0    1  1024M  0 rom
nvme0n1     259:0    0 931.5G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
└─nvme0n1p2 259:2    0   931G  0 part /
```

```bash
% sudo fdisk -l
Disk /dev/loop0: 55.52 MiB, 58204160 bytes, 113680 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop1: 4 KiB, 4096 bytes, 8 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop2: 47.101 MiB, 50315264 bytes, 98272 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop4: 61.93 MiB, 64913408 bytes, 126784 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop5: 219 MiB, 229638144 bytes, 448512 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop6: 247.93 MiB, 259948544 bytes, 507712 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop7: 45.95 MiB, 48156672 bytes, 94056 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/nvme0n1: 931.53 GiB, 1000204886016 bytes, 1953525168 sectors
Disk model: Samsung SSD 980 PRO 1TB
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A5FFFA96-1DB9-4188-917A-EE3EDA5F1FED

Device           Start        End    Sectors  Size Type
/dev/nvme0n1p1    2048    1050623    1048576  512M EFI System
/dev/nvme0n1p2 1050624 1953523711 1952473088  931G Linux filesystem


Disk /dev/sdb: 931.53 GiB, 1000204886016 bytes, 1953525168 sectors
Disk model: WDC WD10EZEX-60M
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x41855b71

Device     Boot   Start        End    Sectors  Size Id Type
/dev/sdb1  *       2048    1126399    1124352  549M  7 HPFS/NTFS/exFAT
/dev/sdb2       1126400 1953521663 1952395264  931G  7 HPFS/NTFS/exFAT


Disk /dev/sda: 931.53 GiB, 1000204886016 bytes, 1953525168 sectors
Disk model: APPLE HDD HTS541
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 47A20605-966B-4749-8783-F78AC800DF95

Device     Start        End    Sectors   Size Type
/dev/sda1   2048      34815      32768    16M Microsoft reserved
/dev/sda2  34816 1953523711 1953488896 931.5G Microsoft basic data




Disk /dev/loop8: 65.22 MiB, 68378624 bytes, 133552 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop11: 219 MiB, 229638144 bytes, 448512 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop12: 54.24 MiB, 56872960 bytes, 111080 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop13: 63.23 MiB, 66293760 bytes, 129480 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop14: 55.58 MiB, 58261504 bytes, 113792 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop15: 346.34 MiB, 363151360 bytes, 709280 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop16: 91.7 MiB, 96141312 bytes, 187776 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

`/dev/sdb`が新しく追加したHDDだ．これはバックアップというかデータ保管用に使いたいので対応するディレクトリを`/home/data`という名前で作る．そこに`/dev/sdb2`をマウントするという流れ．


```bash
# まずはext4(linuxの標準的なファイルシステム)でフォーマット
sudo mkfs -t ext4 /dev/sdb2
# マウントする用のディレクトリを作成
sudo mkdir /home/data
# 実際にマウント
sudo mount /dev/sdb2 /home/data
```

