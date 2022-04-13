X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.3438.1649834200604021533
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=AyODwE+a;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202204130716431385b12f32016f4265-1lusyr@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id 202204130716431385b12f32016f4265
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=le2mND6VwDa7A+MTMyLG91h9BqQ8xoQ28ymoQVEaaco=;
 b=AyODwE+aVl+ozARE0eW3C4k/ulzEjZL0JXo8dWG4N4NCgi+riTnblcKFtNDY/+qtfxsvXc
 jVEZMSIrbbYtMKztuqYX9lLTVieoFgWyb5/qyfWDcsoRD0JjPQemXcBkxoRGn1VDMkyquYBQ
 jfFKlIoA+g9NUh8du9fIj4gl2+oDA=;
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 18/19] doc: Update README.swupdate
Date: Wed, 13 Apr 2022 09:16:35 +0200
Message-Id: <09173a76dd97f3b97ec34a10531eb4354f6d3b03.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Reflect the changes on the non-secure SWUpdate procedure in the
documentation and streamline it a bit. Also switch to host-originated
scp to transfer the swu image to avoid the need for sshd on the host.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.swupdate.md | 166 ++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 76 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 05768da..e28db24 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -1,31 +1,38 @@
+# SWUpdate support for the CIP core image
 
-Clone the isar-cip-core repository
+This document describes how to build and test the SWUpdate pre-integration for
+isar-cip-core, targeting a QEMU x86 virtual machine.
+
+Start with cloning the isar-cip-core repository:
 ```
 host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 ```
 
-Build the CIP Core image
+# Building and testing the CIP Core image
 
 Set up `kas-container` as described in the [top-level README](../README.md).
-Then build the image:
+Then build the image which will later serve as update package:
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
 ```
-- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
-- modify the image for example add a new version to the image by adding PV=2.0.0 to cip-core-image.bb
-- rebuild the image using above command and start the new target
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` into a separate folder (ex: /tmp).
+
+Next, rebuild the image, switching to the RT kernel as modification:
 ```
-host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
+Now start the image which will contain the RT kernel:
+```
+host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
 
+Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
 ```
 
 Check which partition is booted, e.g. with lsblk:
-
 ```
 root@demo:~# lsblk
 NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
@@ -37,11 +44,22 @@ sda      8:0    0    2G  0 disk
 └─sda5   8:5    0 1000M  0 part
 ```
 
-Apply swupdate and reboot
+Also check that you are running the RT kernel:
+```
+root@demo:~# uname -a
+Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
+root@demo:~# ls /lib/modules
+4.19.233-cip69-rt24
+root@demo:~# cat /sys/kernel/realtime
+1
+```
+
+Now apply swupdate and reboot
 ```
 root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
 root@demo:~# reboot
 ```
+
 Check which partition is booted, e.g. with lsblk and the rootfs should have changed
 ```
 root@demo:~# lsblk
@@ -54,150 +72,146 @@ sda      8:0    0    2G  0 disk
 └─sda5   8:5    0 1000M  0 part /
 ```
 
+Check the active kernel:
+```
+root@demo:~# uname -a
+Linux demo 4.19.235-cip70 #1 SMP Tue Apr 12 09:08:39 UTC 2022 x86_64 GNU/Linux
+root@demo:~# ls /lib/modules
+4.19.235-cip70
+```
+
 Check bootloader ustate after swupdate
 ```
 root@demo:~# bg_printenv
+
 ----------------------------
-Config Partition #0 Values:
+ Config Partition #0 Values:
 in_progress:      no
 revision:         2
-kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+kernel:           C:BOOT0:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
 user variables:
 
+
+
 ----------------------------
  Config Partition #1 Values:
 in_progress:      no
 revision:         3
-kernel:           C:BOOT1:vmlinuz
-kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+kernel:           C:BOOT1:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           2 (TESTING)
+
+user variables:
+
+
 ```
 
-if Partition #1 usate is 2 (TESTING) then execute below command to confirm swupdate and the command will set ustate to "OK"
+If Partition #1 ustate is 2 (TESTING) then execute below command to confirm swupdate and the command will set ustate to "OK".
 ```
 root@demo:~# bg_setenv -c
 ```
 
-# swupdate rollback example
+## SWUpdate rollback example
 
-Build the image for swupdate with service which causes kernel panic during system boot using below command.
+Build the image for swupdate with a service which causes kernel panic during system boot using below command:
 
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
 ```
-- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
-- build the image again without `kernel-panic.yml` recipe using below command
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` in a separate folder.
+Then build the image without `kernel-panic.yml` recipe using below command:
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
 ```
 
-Start the target on QEMU
+Start the target on QEMU:
 ```
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
-
+Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
 ```
 
-Check which partition is booted, e.g. with lsblk:
-
+Apply swupdate as below:
 ```
-root@demo:~# lsblk
-NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    2G  0 disk
-├─sda1   8:1    0 16.4M  0 part
-├─sda2   8:2    0   32M  0 part
-├─sda3   8:3    0   32M  0 part
-├─sda4   8:4    0 1000M  0 part /
-└─sda5   8:5    0 1000M  0 part
+root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
 ```
 
-Check bootloader ustate before swupdate and should be as below
+Check bootloader ustate after swupdate. If the swupdate is successful then **revision number** should be **3** and status should be changed to **INSTALLED** for Partition #1.
 ```
 root@demo:~# bg_printenv
+
 ----------------------------
-Config Partition #0 Values:
+ Config Partition #0 Values:
 in_progress:      no
 revision:         2
-kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+kernel:           C:BOOT0:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
 user variables:
-----------------------------
-Config Partition #1 Values:
-in_progress:      no
-revision:         1
-kernel:           C:BOOT1:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
-watchdog timeout: 60 seconds
-ustate:           0 (OK)
-```
 
-Apply swupdate as below
-```
-root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
-```
 
-check bootloader ustate after swupdate. if the swupdate is successful then **revision number** should increase to **3** and status should be changed to **INSTALLED** for Partition #1.
-```
-root@demo:~# bg_printenv
-----------------------------
-Config Partition #0 Values:
-in_progress:      no
-revision:         2
-kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
-watchdog timeout: 60 seconds
-ustate:           0 (OK)
 
-user variables:
 ----------------------------
-Config Partition #1 Values:
+ Config Partition #1 Values:
 in_progress:      no
 revision:         3
-kernel:           C:BOOT1:vmlinuz
-kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
+kernel:           C:BOOT1:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           1 (INSTALLED)
+
+user variables:
+
+
 ```
 
-Execute reboot command
-- reboot command should cause kernel panic error.
-- watchdog timer should expire and restart the qemu. bootloader should select previous partition to boot.
+Execute the reboot command.
 ```
 root@demo:~# reboot
 ```
 
-Once the system is restarted, check the bootloader ustate
-- if update is failed then **revision number** should reduce to **0** and status should change to **FAILED** for Partition #1.
+The new kernel should cause a kernel panic error.
+The watchdog timer should expire and restart the VM (it will take 2 minutes due to an issue in.
+The bootloader will then select the previous, working partition and boot from it.
+
+Once the system is restarted, check the bootloader ustate.
+If update is failed then **revision number** should be reduced to **0** and status should have changed to **FAILED** for Partition #1.
 ```
 root@demo:~# bg_printenv
+
 ----------------------------
  Config Partition #0 Values:
 in_progress:      no
 revision:         2
-kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-corg
+kernel:           C:BOOT0:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
 user variables:
+
+
+
 ----------------------------
  Config Partition #1 Values:
 in_progress:      no
 revision:         0
-kernel:           C:BOOT1:vmlinuz
-kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-corg
+kernel:           C:BOOT1:linux.efi
+kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
 watchdog timeout: 60 seconds
 ustate:           3 (FAILED)
+
+user variables:
+
+
 ```
-- 
2.34.1


