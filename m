Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F9C64ED6
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 12:08:58 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.21539.1677586129252402499
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 04:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="99781332"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 28 Feb 2023 04:08:48 -0800
IronPort-SDR: 9uKko4JOxAwHbT3Px6nVpZ5+uLMYz39GBUb0xHnDO73vGV8vrhZLRFKjMala+6ocjT6TKvna7I
 3G5myU8/Jx4Kn7XLB5MeV/s5IeyBoWIxdc6NANsufD+jVCcaYjXBl6E1us+slKuYFrBCLW/7nP
 o072Eg8T3XUyq5ozuQc8rHeIYHiFquEBUE+hLtcPMfD7qU/gN8PlPCT8DcMgDYZATBVQ85ibYm
 u1QsTNYFKXTSMz8Q5at0iP5Zt37JI+ITE4HNhbvx3TuDSN/wAomb79/5233urm07PYm2J1YSVa
 BlU=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] README.secureboot.md: update the document
Date: Tue, 28 Feb 2023 17:38:25 +0530
Message-ID: <20230228120825.2522604-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 12:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10865

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update the secureboot document based on the current implementation.

Note: Now secureboot directly boot the linux hence no need to provide the efi
file path in efi shell.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.secureboot.md | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index b15ea93..54d67c7 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -67,10 +67,9 @@ Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 ### Prerequisites
 
 - OVMF from edk2 release edk2-stable201911 or newer
-  - This documentation was tested under Debian 10 with OVMF (0.0~20200229-2) backported from Debian
-  bullseye
+  - This documentation was tested under Debian 11 with OVMF (2020.11-2+deb11u1) from Debian bullseye
 - efitools for KeyTool.efi
-  - This documentation was tested under Debian 10 with efitools (1.9.2-1) backported from Debian bullseye
+  - This documentation was tested under Debian 11 with efitools (1.9.2-2~deb11u1) from Debian bullseye
 - libnss3-tools
 
 ### Debian Snakeoil keys
@@ -80,7 +79,7 @@ You can use them as described in section [Start Image](#start-the-image).
 
 ### Generate Keys
 
-#### Reuse exiting keys
+#### Reuse existing keys
 
 It is possible to use exiting keys like /usr/share/ovmf/PkKek-1-snakeoil.pem' from Debian
 by executing the script  `scripts/generate-sb-db-from-existing-certificate.sh`, e.g.:
@@ -196,12 +195,6 @@ and the following command is sufficient:
 ./start-qemu.sh amd64
 ```
 
-The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. To boot Linux enter the following command:
-```
-FS0:\EFI\BOOT\bootx64.efi
-```
-To change the boot behavior, enter `exit` in the shell to enter the bios and change the boot order.
-
 #### User-generated keys
 Start the image with the following command:
 ```
@@ -239,14 +232,17 @@ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1
 ```
 - check which partition is booted, e.g. with `lsblk`:
 ```
-root@demo:/mnt# lsblk
-NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    2G  0 disk
-├─sda1   8:1    0 16.4M  0 part
-├─sda2   8:2    0   32M  0 part
-├─sda3   8:3    0   32M  0 part
-├─sda4   8:4    0 1000M  0 part /
-└─sda5   8:5    0 1000M  0 part
+root@demo:~# lsblk
+NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
+sda              8:0    0     6G  0 disk
+├─sda1           8:1    0  16.1M  0 part
+├─sda2           8:2    0    32M  0 part
+├─sda3           8:3    0    32M  0 part
+├─sda4           8:4    0     1G  0 part
+│ └─verityroot 252:0    0 110.9M  1 crypt /
+├─sda5           8:5    0     1G  0 part
+├─sda6           8:6    0   1.3G  0 part  /home
+└─sda7           8:7    0   2.6G  0 part  /var
 ```
 
 - install the swupdate and reboot the image
@@ -257,11 +253,14 @@ root@demo:~# reboot
 - check which partition is booted, e.g. with `lsblk`. The rootfs should have changed:
 ```
 root@demo:~# lsblk
-NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    2G  0 disk
-├─sda1   8:1    0 16.4M  0 part
-├─sda2   8:2    0   32M  0 part
-├─sda3   8:3    0   32M  0 part
-├─sda4   8:4    0 1000M  0 part
-└─sda5   8:5    0 1000M  0 part /
+NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
+sda              8:0    0     6G  0 disk
+├─sda1           8:1    0  16.1M  0 part
+├─sda2           8:2    0    32M  0 part
+├─sda3           8:3    0    32M  0 part
+├─sda4           8:4    0     1G  0 part
+├─sda5           8:5    0     1G  0 part
+│ └─verityroot 252:0    0 110.9M  1 crypt /
+├─sda6           8:6    0   1.3G  0 part  /home
+└─sda7           8:7    0   2.6G  0 part  /var
 ```
-- 
2.34.1


