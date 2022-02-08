X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.9863.1644320249457308132
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Feb 2022 03:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 218BbRin027343; Tue, 8 Feb 2022 20:37:27 +0900
X-Iguazu-Qid: 2wGqgqrv965I5WG2jp
X-Iguazu-QSIG: v=2; s=0; t=1644320247; q=2wGqgqrv965I5WG2jp; m=op4orrxygc23UKtzXYup5j+NqHGr19Ug4oS23+22Oc8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 218BbP0f040410
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 8 Feb 2022 20:37:26 +0900
From: "Kunijadar Shivanand" <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        akihiro27.suzuki@toshiba.co.jp
Subject: [isar-cip-core v3] README.swupdate.md: add readme file with steps to verify swupdate
Date: Tue,  8 Feb 2022 17:02:25 +0530
X-TSB-HOP2: ON
Message-Id: <20220208113225.22682-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c5e89aca-caf7-17dc-7a96-94e86cade48c@siemens.com>
References: <c5e89aca-caf7-17dc-7a96-94e86cade48c@siemens.com>
MIME-Version: 1.0
X-OriginalArrivalTime: 08 Feb 2022 11:37:24.0308 (UTC) FILETIME=[3DD57140:01D81CE0]
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Prepare readme file with necessary steps to verify swupdate feature
with rollback functionality.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 203 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 doc/README.swupdate.md

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
new file mode 100644
index 0000000..05768da
--- /dev/null
+++ b/doc/README.swupdate.md
@@ -0,0 +1,203 @@
+
+Clone the isar-cip-core repository
+```
+host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+```
+
+Build the CIP Core image
+
+Set up `kas-container` as described in the [top-level README](../README.md).
+Then build the image:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
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
+root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
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
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
+```
+- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
+- build the image again without `kernel-panic.yml` recipe using below command
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
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
+root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
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



