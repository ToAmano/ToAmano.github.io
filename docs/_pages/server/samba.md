

目標：サーバーをファイルサーバーにしてローカル環境からいつでもみられるようにする．

ssh接続はできるようになった．次の目標として，サーバーマシンに入れた4TBのHDDをNASのようにしてローカル環境からいつでもアクセスできるようにする．例えば写真や音楽をこのHDDにいれておけば，家のどこからでも聴けるようになる．もちろんmacのfinderからファイルを操作することもできるので仕事用のデータをこっちに移すことでmacの容量節約にもつながる．

## sambaをインストール

```bash
sudo apt install samba
```

## sambaのユーザを設定

サーバーマシンのユーザーとは別に，`samba`用のユーザーが必要．とりあえずマシンのユーザー名hogeと同名のユーザーを作った．パスワードを設定するように要求されるので適当に設定する．

```bash
sudo pdbedit -a hoge
new password: ← 新しいパスワードを設定
retype new password:
Unix username:        hoge
NT username:
Account Flags:        [U          ]
User SID:             S-1-5-21-1393800765-2537459517-2143735988-1000
Primary Group SID:    S-1-5-21-1393800765-2537459517-2143735988-513
Full Name:            hoge
Home Directory:       \\KAGA\hoge
HomeDir Drive:
Logon Script:
Profile Path:         \\KAGA\hoge\profile
Domain:               KAGA
Account desc:
Workstations:
Munged dial:
Logon time:           0
Logoff time:          木, 07  2月 2036 00:06:39 JST
Kickoff time:         木, 07  2月 2036 00:06:39 JST
Password last set:    日, 02 10月 2022 17:23:11 JST
Password can change:  日, 02 10月 2022 17:23:11 JST
Password must change: never
Last bad password   : 0
Bad password count  : 0
Logon hours         : FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
```


## 共有するディレクトリの設定

```bash
# もしディレクトリがなければ適当に作成
mkdir /home/data
# アクセス権を修正
sudo chmod -R 777 /home/data/
```

## 設定変更

`samba`の設定ファイルは`/etc/samba/smb.conf`で，ここに以下のような記述を追加．

```bash
[share]
path = /home/data/  # 共有するディレクトリ
browsable = yes     
writable = yes
guest ok = yes
read only = no%
```

## 設定の反映

```bash
$ sudo systemctl restart smbd
$ sudo systemctl status smbd                                             
● smbd.service - Samba SMB Daemon
     Loaded: loaded (/lib/systemd/system/smbd.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2022-10-02 17:08:24 JST; 8s ago
       Docs: man:smbd(8)
             man:samba(7)
             man:smb.conf(5)
    Process: 67492 ExecStartPre=/usr/share/samba/update-apparmor-samba-profile (code=exited, status=0/SUCCESS)
   Main PID: 67501 (smbd)
     Status: "smbd: ready to serve connections..."
      Tasks: 4 (limit: 76779)
     Memory: 6.9M
     CGroup: /system.slice/smbd.service
             ├─67501 /usr/sbin/smbd --foreground --no-process-group
             ├─67503 /usr/sbin/smbd --foreground --no-process-group
             ├─67504 /usr/sbin/smbd --foreground --no-process-group
             └─67505 /usr/sbin/smbd --foreground --no-process-group

10月 02 17:08:23 kaga systemd[1]: Starting Samba SMB Daemon...
10月 02 17:08:24 kaga systemd[1]: Started Samba SMB Daemon.
```

## macからの接続

特に新しい
Finderで`cmd+k`とおし，そこで`smb://192.168.1.54`と入れる．**ユーザー名とパスワードは`samba`のものなので注意．** これで接続できるはず．

## 参考文献
https://tamnology.com/ubuntu-samba/

