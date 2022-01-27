X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.29398.1643293879227010554
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 06:31:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 20REVGNJ001530; Thu, 27 Jan 2022 23:31:17 +0900
X-Iguazu-Qid: 2wGrAvx2o98xFuPLs0
X-Iguazu-QSIG: v=2; s=0; t=1643293876; q=2wGrAvx2o98xFuPLs0; m=tjnTIPx7+IXCi/iqq11mx1YcEHuGYl3e9ALe8vPCyls=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 20REVFMo000755
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 23:31:16 +0900
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com
Subject: [isar-cip-core] README.swupdate.md: add readme file with steps to verify swupdate
Date: Thu, 27 Jan 2022 19:56:27 +0530
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220127142627.6812-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-OriginalArrivalTime: 27 Jan 2022 14:31:14.0078 (UTC) FILETIME=[89810BE0:01D8138A]
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Cc: dinesh.kumar@toshiba-tsip.com,
    kazuhiro3.hayashi@toshiba.co.jp,
    akihiro27.suzuki@toshiba.co.jp

Added readme file with necessary steps to verify swupdate feature along
with swupdate rollback.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 208 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 doc/README.swupdate.md

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
new file mode 100644
index 0000000..41b5f87
--- /dev/null
+++ b/doc/README.swupdate.md
@@ -0,0 +1,208 @@
+
+Clone the isar-cip-core repository
+```
+host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+```
+
+Install `kas-container` from the [kas project](https://github.com/siemens/kas):
+
+```
+host$ wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
+host$ chmod a+x kas-container
+```
+
+Build the image for swupdate
+
+```
+host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+```
+- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
+- modify the image for example add a new version to the image by adding PV=2.0.0 to cip-core-image.bb
+- rebuild the image using above command and start the new target
+```
+host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+
+Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
+
+```
+root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
+```
+
+Check which partition is booted, e.g. with lsblk:
+
+```
+root@demo:~# lsblk
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
+sda      8:0    0    2G  0 disk
+├─sda1   8:1    0 16.4M  0 part
+├─sda2   8:2    0   32M  0 part
+├─sda3   8:3    0   32M  0 part
+├─sda4   8:4    0 1000M  0 part /
+└─sda5   8:5    0 1000M  0 part
+```
+
+Apply swupdate and reboot
+```
+root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+root@demo:~# reboot
+```
+Check which partition is booted, e.g. with lsblk and the rootfs should have changed
+```
+root@demo:~# lsblk
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
+sda      8:0    0    2G  0 disk
+├─sda1   8:1    0 16.4M  0 part
+├─sda2   8:2    0   32M  0 part
+├─sda3   8:3    0   32M  0 part
+├─sda4   8:4    0 1000M  0 part
+└─sda5   8:5    0 1000M  0 part /
+```
+
+Check bootloader ustate after swupdate
+```
+root@demo:~# bg_printenv
+----------------------------
+Config Partition #0 Values:
+in_progress:      no
+revision:         2
+kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+
+user variables:
+
+----------------------------
+ Config Partition #1 Values:
+in_progress:      no
+revision:         3
+kernel:           C:BOOT1:vmlinuz
+kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           2 (TESTING)
+```
+
+if Partition #1 usate is 2 (TESTING) then execute below command to confirm swupdate and the command will set ustate to "OK"
+```
+root@demo:~# bg_setenv -c
+```
+
+# swupdate rollback example
+
+Build the image for swupdate with service which causes kernel panic during system boot using below command.
+
+```
+host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/swupdate-rollback.yml
+```
+- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
+- build the image again without `swupdate-rollback.yml` recipe using below command
+```
+host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+```
+
+Start the target on QEMU
+```
+host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+
+Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
+
+```
+root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
+```
+
+Check which partition is booted, e.g. with lsblk:
+
+```
+root@demo:~# lsblk
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
+sda      8:0    0    2G  0 disk
+├─sda1   8:1    0 16.4M  0 part
+├─sda2   8:2    0   32M  0 part
+├─sda3   8:3    0   32M  0 part
+├─sda4   8:4    0 1000M  0 part /
+└─sda5   8:5    0 1000M  0 part
+```
+
+Check bootloader ustate before swupdate and should be as below
+```
+root@demo:~# bg_printenv
+----------------------------
+Config Partition #0 Values:
+in_progress:      no
+revision:         2
+kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+
+user variables:
+----------------------------
+Config Partition #1 Values:
+in_progress:      no
+revision:         1
+kernel:           C:BOOT1:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+```
+
+Apply swupdate as below
+```
+root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+```
+
+check bootloader ustate after swupdate. if the swupdate is successful then **revision number** should increase to **3** and status should be changed to **INSTALLED** for Partition #1.
+```
+root@demo:~# bg_printenv
+----------------------------
+Config Partition #0 Values:
+in_progress:      no
+revision:         2
+kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+
+user variables:
+----------------------------
+Config Partition #1 Values:
+in_progress:      no
+revision:         3
+kernel:           C:BOOT1:vmlinuz
+kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+watchdog timeout: 60 seconds
+ustate:           1 (INSTALLED)
+```
+
+Execute reboot command
+- reboot command should cause kernel panic error.
+- watchdog timer should expire and restart the qemu. bootloader should select previous partition to boot.
+```
+root@demo:~# reboot
+```
+
+Once the system is restarted, check the bootloader ustate
+- if update is failed then **revision number** should reduce to **0** and status should change to **FAILED** for Partition #1.
+```
+root@demo:~# bg_printenv
+----------------------------
+ Config Partition #0 Values:
+in_progress:      no
+revision:         2
+kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-corg
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+
+user variables:
+----------------------------
+ Config Partition #1 Values:
+in_progress:      no
+revision:         0
+kernel:           C:BOOT1:vmlinuz
+kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-corg
+watchdog timeout: 60 seconds
+ustate:           3 (FAILED)
+```
-- 
2.20.1



