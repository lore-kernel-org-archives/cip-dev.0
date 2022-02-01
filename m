X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.49804.1643730015622065525
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 07:40:16 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 211FeCPW018488; Wed, 2 Feb 2022 00:40:13 +0900
X-Iguazu-Qid: 2wGrYolv9doEUs4Ttw
X-Iguazu-QSIG: v=2; s=0; t=1643730012; q=2wGrYolv9doEUs4Ttw; m=DouDAPdje4NGp1V/YNbNK8pPPKpnsw+gEHah8+2W79c=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 211FeB7e006382
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 2 Feb 2022 00:40:12 +0900
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        akihiro27.suzuki@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] README.swupdate.md: add readme file with steps to verify swupdate
Date: Tue,  1 Feb 2022 21:05:02 +0530
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220201153502.14230-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
MIME-Version: 1.0
X-OriginalArrivalTime: 01 Feb 2022 15:39:54.0496 (UTC) FILETIME=[F587B000:01D81781]
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Prepare readme file with necessary steps to verify swupdate feature
with rollback functionality.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 208 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 doc/README.swupdate.md

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
new file mode 100644
index 0000000..56bc77c
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
+host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
+```
+- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
+- build the image again without `kernel-panic.yml` recipe using below command
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



