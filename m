Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C162C64ED6
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 15:03:19 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.25606.1677596595527471544
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 07:03:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="98482101"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 28 Feb 2023 07:03:07 -0800
IronPort-SDR: Ryj25qbY2zgS2SjvC66Bh9/2Xae1s4tPHvokNz7h8WtLeLRUKXNpQzZ1c5wZsd/uG1RjWxW+gV
 3p8Jyn/J6ZUD2wJ7A5k59dACpHWauQX0kZ3KwVk/O1SmGOf8zg0eNjpBdUOejOZ6WHlBTo2Lmr
 mp0md4hnaN/aYdRtgyx0BeFxxG5NiFK4ailm8T4zGQIXAbWkT3lBRbfyyriUjb1EIPQ8kbgYev
 W0dO5hbSpmsxsrPWUM2pnNcOisLxqGSy0oV+ROEPkJsguE+2CZ7vgYoDxckbS4I3kVrYLULm6K
 GAw=
From: Srinuvasan A <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] README.swupdate.md: Update SWUpdate document
Date: Tue, 28 Feb 2023 20:32:46 +0530
Message-ID: <20230228150246.2523007-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 15:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10868

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update SWUpdate document based on the current implementation.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.swupdate.md | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 97de777..00359c7 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -38,12 +38,14 @@ Check which partition is booted, e.g. with lsblk:
 ```
 root@demo:~# lsblk
 NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    2G  0 disk
-├─sda1   8:1    0 16.4M  0 part
+sda      8:0    0    6G  0 disk
+├─sda1   8:1    0 16.1M  0 part
 ├─sda2   8:2    0   32M  0 part
 ├─sda3   8:3    0   32M  0 part
-├─sda4   8:4    0 1000M  0 part /
-└─sda5   8:5    0 1000M  0 part
+├─sda4   8:4    0    1G  0 part /
+├─sda5   8:5    0    1G  0 part
+├─sda6   8:6    0  1.3G  0 part /home
+└─sda7   8:7    0  2.6G  0 part /var
 ```
 
 Also check that you are running the RT kernel:
@@ -66,12 +68,14 @@ Check which partition is booted, e.g. with lsblk and the rootfs should have chan
 ```
 root@demo:~# lsblk
 NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
-sda      8:0    0    2G  0 disk
-├─sda1   8:1    0 16.4M  0 part
+sda      8:0    0    6G  0 disk
+├─sda1   8:1    0 16.1M  0 part
 ├─sda2   8:2    0   32M  0 part
 ├─sda3   8:3    0   32M  0 part
-├─sda4   8:4    0 1000M  0 part
-└─sda5   8:5    0 1000M  0 part /
+├─sda4   8:4    0    1G  0 part
+├─sda5   8:5    0    1G  0 part /
+├─sda6   8:6    0  1.3G  0 part /home
+└─sda7   8:7    0  2.6G  0 part /var
 ```
 
 Check the active kernel:
@@ -91,7 +95,7 @@ root@demo:~# bg_printenv
 in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
@@ -104,7 +108,7 @@ user variables:
 in_progress:      no
 revision:         3
 kernel:           C:BOOT1:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           2 (TESTING)
 
@@ -155,7 +159,7 @@ root@demo:~# bg_printenv
 in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
@@ -168,7 +172,7 @@ user variables:
 in_progress:      no
 revision:         3
 kernel:           C:BOOT1:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           1 (INSTALLED)
 
@@ -196,7 +200,7 @@ root@demo:~# bg_printenv
 in_progress:      no
 revision:         2
 kernel:           C:BOOT0:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           0 (OK)
 
@@ -209,7 +213,7 @@ user variables:
 in_progress:      no
 revision:         0
 kernel:           C:BOOT1:linux.efi
-kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk
+kernelargs:
 watchdog timeout: 60 seconds
 ustate:           3 (FAILED)
 
-- 
2.34.1


