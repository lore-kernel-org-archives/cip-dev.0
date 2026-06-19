Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE51CCD98F6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 11:09:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40243.1781867361214025745
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 04:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65JB9Jnq227730; Fri, 19 Jun 2026 20:09:19 +0900
X-Iguazu-Qid: 2yAbtjHMo8IwwDz6um
X-Iguazu-QSIG: v=2; s=0; t=1781867359; q=2yAbtjHMo8IwwDz6um; m=smu/jIli1T8PTMByAvCPirikGUghoLt3JMvwMX2bIPk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4ghZbz0hG6zyPQ; Fri, 19 Jun 2026 20:09:18 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] Revise README files to reflect the latest changes
Date: Fri, 19 Jun 2026 16:26:16 +0530
X-TSB-HOP2: ON
Message-Id: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Jun 2026 11:09:16.0731 (UTC) FILETIME=[1197A0B0:01DCFFDC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 11:09:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23231

The SWUpdate & Secure boot readme files are outdated, adjust these files
to reflect the current changes and debian version based on the master
branch.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.secureboot.md | 63 +++++++++++++--------------
 doc/README.swupdate.md   | 92 ++++++++++++++++++++--------------------
 2 files changed, 75 insertions(+), 80 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 8ab67a8..5ac8611 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -48,7 +48,7 @@ Supply the script name and path to wic by adding
 #### secure-boot-snakeoil
 
 This package uses the snakeoil key and certificate from the ovmf package from
-Debian bullseye or later for signing the image.
+Debian trixie or later for signing the image.
 
 #### secure-boot-key
 
@@ -66,10 +66,10 @@ Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 
 ### Prerequisites
 
-- OVMF from edk2 release edk2-stable201911 or newer
-  - This documentation was tested under Debian 11 with OVMF (2020.11-2+deb11u1) from Debian bullseye
+- OVMF from edk2 release 2025.02-8+deb13u1 or newer
+  - This documentation was tested under Debian 13 with OVMF (2025.02-8+deb13u1) from Debian trixie
 - efitools for KeyTool.efi
-  - This documentation was tested under Debian 11 with efitools (1.9.2-2~deb11u1) from Debian bullseye
+  - This documentation was tested under Debian 13 with efitools (1.9.2-3.5) from Debian trixie
 - libnss3-tools
 
 ### Debian Snakeoil keys
@@ -144,7 +144,7 @@ Build the image with a signed EFI Boot Guard and unified kernel image
 with the snakeoil keys by executing:
 
 ```bash
-kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-secure-boot-snakeoil.yml
 ```
 
 For user-generated keys, create a new option file in the repository. This option file could look like this:
@@ -186,7 +186,7 @@ need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
 Build the image with user-generated keys by executing the command:
 
 ```bash
-kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option>.yml
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:<path to the new option>.yml
 ```
 
 ### Start the image
@@ -196,7 +196,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option
 Start the image with the following command:
 
 ```bash
-SECURE_BOOT=y \
+DISTRO_RELEASE=trixie SECURE_BOOT=y \
 ./start-qemu.sh amd64
 ```
 
@@ -211,6 +211,7 @@ and the following command is sufficient:
 Start the image with the following command:
 
 ```bash
+DISTRO_RELEASE=trixie \
 SECURE_BOOT=y \
 OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd \
 OVMF_VARS=<path to the modified OVMF_VARS.fd> \
@@ -233,45 +234,43 @@ EFI stub: UEFI Secure Boot is enabled.
 
 For updating the image, the following steps are necessary:
 - [Build the image with snakeoil keys](#build-image)
-- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` to /tmp
+- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu` to /tmp
 - modify the image for example, switch to the RT kernel as modification:
 
 ```bash
-kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml:kas/opt/rt.yml
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-secure-boot-snakeoil.yml:kas/opt/rt.yml
 ```
 
 - start the new target
 
 ```bash
-SECURE_BOOT=y ./start-qemu.sh amd64
+DISTRO_RELEASE=trixie SECURE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the running system
+Copy the swu cip-core-image-cip-core-trixie-qemu-amd64.swu to the running system
 
 ```bash
-scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1:/home/
+scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu root@127.0.0.1:/
 ```
 
 - check which partition is booted, e.g. with `lsblk`:
 
 ```bash
 root@demo:~# lsblk
-NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
-sda              8:0    0     6G  0 disk
-├─sda1           8:1    0  16.1M  0 part
-├─sda2           8:2    0    32M  0 part
-├─sda3           8:3    0    32M  0 part
-├─sda4           8:4    0     1G  0 part
-│ └─verityroot 252:0    0 110.9M  1 crypt /
-├─sda5           8:5    0     1G  0 part
-├─sda6           8:6    0   1.3G  0 part  /home
-└─sda7           8:7    0   2.6G  0 part  /var
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
+sda      8:0    0  2.8G  0 disk
+├─sda1   8:1    0 20.8M  0 part /boot
+├─sda2   8:2    0  128M  0 part
+├─sda3   8:3    0  128M  0 part
+├─sda4   8:4    0    1G  0 part
+├─sda5   8:5    0    1G  0 part
+└─sda6   8:6    0  512M  0 part /var
 ```
 
 - install the swupdate and reboot the image
 
 ```bash
-root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-amd64.swu`
+root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
 root@demo:~# reboot
 ```
 
@@ -279,16 +278,14 @@ root@demo:~# reboot
 
 ```bash
 root@demo:~# lsblk
-NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
-sda              8:0    0     6G  0 disk
-├─sda1           8:1    0  16.1M  0 part
-├─sda2           8:2    0    32M  0 part
-├─sda3           8:3    0    32M  0 part
-├─sda4           8:4    0     1G  0 part
-├─sda5           8:5    0     1G  0 part
-│ └─verityroot 252:0    0 110.9M  1 crypt /
-├─sda6           8:6    0   1.3G  0 part  /home
-└─sda7           8:7    0   2.6G  0 part  /var
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
+sda      8:0    0  2.8G  0 disk
+├─sda1   8:1    0 20.8M  0 part /boot
+├─sda2   8:2    0  128M  0 part
+├─sda3   8:3    0  128M  0 part
+├─sda4   8:4    0    1G  0 part
+├─sda5   8:5    0    1G  0 part
+└─sda6   8:6    0  512M  0 part /var
 ```
 
 ## Secure boot on Generic UEFI x86
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index affb85b..10ce1cc 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -190,23 +190,23 @@ write it to `/etc/hwrevision`.
 Set up `kas-container` as described in the [top-level README](../README.md).
 Then build the image which will later serve as update package:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu` into a separate folder (ex: /tmp).
 
 Next, rebuild the image, switching to the RT kernel as modification:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
 ```
 
 Now start the image which will contain the RT kernel:
 ```
-host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ DISTRO_RELEASE=trixie SWUPDATE_BOOT=true ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu root@localhost:
 ```
 
 ## SWUpdate verification
@@ -214,28 +214,27 @@ host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@loc
 Check which partition is booted, e.g. with lsblk:
 ```
 root@demo:~# lsblk
-NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    6G  0 disk
-├─sda1   8:1    0 16.1M  0 part
-├─sda2   8:2    0   32M  0 part
-├─sda3   8:3    0   32M  0 part
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
+sda      8:0    0  2.8G  0 disk
+├─sda1   8:1    0   16M  0 part /boot
+├─sda2   8:2    0  128M  0 part
+├─sda3   8:3    0  128M  0 part
 ├─sda4   8:4    0    1G  0 part /
 ├─sda5   8:5    0    1G  0 part
-├─sda6   8:6    0  1.3G  0 part /home
-└─sda7   8:7    0  2.6G  0 part /var
+└─sda6   8:6    0  512M  0 part /var
 ```
 
-Also check that you are running the RT kernel:
+Also check that you are running the RT kernel (i.e PREEMPT_RT):
 ```
 root@demo:~# uname -a
-Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
+Linux demo 6.12.85-cip22 #1 SMP PREEMPT_RT Thu, 01 Jan 1970 06:30:00 +0530 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
-4.19.233-cip69-rt24
+6.12.85-cip22
 ```
 
 Now apply swupdate and reboot
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
 root@demo:~# reboot
 ```
 Use the `-v` flag when running swupdate for verbose logs of any errors.
@@ -243,23 +242,22 @@ Use the `-v` flag when running swupdate for verbose logs of any errors.
 Check which partition is booted, e.g. with lsblk and the rootfs should have changed
 ```
 root@demo:~# lsblk
-NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    6G  0 disk
-├─sda1   8:1    0 16.1M  0 part
-├─sda2   8:2    0   32M  0 part
-├─sda3   8:3    0   32M  0 part
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
+sda      8:0    0  2.8G  0 disk
+├─sda1   8:1    0   16M  0 part /boot
+├─sda2   8:2    0  128M  0 part
+├─sda3   8:3    0  128M  0 part
 ├─sda4   8:4    0    1G  0 part
 ├─sda5   8:5    0    1G  0 part /
-├─sda6   8:6    0  1.3G  0 part /home
-└─sda7   8:7    0  2.6G  0 part /var
+└─sda6   8:6    0  512M  0 part /var
 ```
 
 Check the active kernel:
 ```
 root@demo:~# uname -a
-Linux demo 4.19.235-cip70 #1 SMP Tue Apr 12 09:08:39 UTC 2022 x86_64 GNU/Linux
+Linux demo 6.12.85-cip22 #1 SMP PREEMPT_DYNAMIC Thu, 01 Jan 1970 06:30:00 +0530 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
-4.19.235-cip70
+6.12.85-cip22
 ```
 
 Check bootloader ustate after swupdate
@@ -272,7 +270,7 @@ in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           0 (OK)
 
 user variables:
@@ -285,7 +283,7 @@ in_progress:      no
 revision:         3
 kernel:           C:BOOT1:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           2 (TESTING)
 
 user variables:
@@ -303,27 +301,27 @@ root@demo:~# bg_setenv -c
 Build the image for swupdate with a service which causes kernel panic during system boot using below command:
 
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu` in a separate folder.
 Then build the image without `kernel-panic.yml` recipe using below command:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml
 ```
 
 Start the target on QEMU:
 ```
-host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ DISTRO_RELEASE=trixie SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu root@localhost:
 ```
 
 Apply swupdate as below:
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
 ```
 
 Check bootloader ustate after swupdate. If the swupdate is successful then **revision number** should be **3** and status should be changed to **INSTALLED** for Partition #1.
@@ -336,7 +334,7 @@ in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           0 (OK)
 
 user variables:
@@ -349,7 +347,7 @@ in_progress:      no
 revision:         3
 kernel:           C:BOOT1:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           1 (INSTALLED)
 
 user variables:
@@ -377,7 +375,7 @@ in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           0 (OK)
 
 user variables:
@@ -390,7 +388,7 @@ in_progress:      no
 revision:         0
 kernel:           C:BOOT1:linux.efi
 kernelargs:
-watchdog timeout: 60 seconds
+watchdog timeout: 120 seconds
 ustate:           3 (FAILED)
 
 user variables:
@@ -419,21 +417,21 @@ The build system looks for the reference artifact in a directory named `previous
 Copy the reference artifacts to the mentioned directory with the following commands:
 ```
 mkdir -p build-v2/previous-image
-cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.squashfs build-v2/previous-image
+cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.squashfs build-v2/previous-image
 cp build/tmp/deploy/images/qemu-amd64/linux.efi build-v2/previous-image
 ```
 Build the second image with `build-v2` as the build directory with the following command:
 ```
-KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
 ```
 Now start the first image. Run the following commands:
 ```
-host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ DISTRO_RELEASE=trixie SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
-Copy `cip-core-image-cip-core-bookworm-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
 ```
 host$ cd build-v2/tmp/deploy/images/qemu-amd64/
-host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 ./cip-core-image-cip-core-trixie-qemu-amd64.swu root@localhost:
 ```
 
 ## Delta Software Update using zchunk handler
@@ -520,7 +518,7 @@ Next, rebuild the image using the Kconfig menu, switching to the RT kernel as mo
 
 Now start the image which will contain the RT kernel:
 ```
-host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ DISTRO_RELEASE=trixie SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
 By default, SWUpdate uses the machine-id from `/etc/machine-id` as the `client-id` (configurable via `WFX_DEVICE_ID` in the `swupdate-config-wfx` recipe). This `client-id` is later used to create `wfx` job for the client:
@@ -604,14 +602,14 @@ Follow the steps mentioned in the section [Building and testing the CIP Core ima
 
 Flash the BeagleBone Black RT kernel image into SDcard
 ```
-host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
+host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-trixie-bbb.wic \
    of=/dev/<medium-device> bs=1M status=progress
 ```
 
 After flashing the BBB RT kernel image into SD card, mount the SD card on host PC and copy .swu file from `tmp` folder to root partition like below.
 
 ```
-host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu /<mnt>/home/root/
+host$ sudo cp tmp/cip-core-image-cip-core-trixie-bbb.swu /<mnt>/root/
 ```
 
 Connect a serial port cable between host PC and BBB.
-- 
2.39.5



