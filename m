Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71245C00140
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.38191.1660795956713326893
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 21:12:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 27I4CZXM006110;
 Thu, 18 Aug 2022 13:12:35 +0900
X-Iguazu-Qid: 34tIWdU4gpg8cBpjrV
X-Iguazu-QSIG: v=2; s=0; t=1660795955; q=34tIWdU4gpg8cBpjrV;
 m=8kT2+HKbezwEJBvSlV6jfQ0Qh9JxTbzmYCMPndihBiA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 27I4CYM3024152
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 13:12:35 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 4/4] Added README for BBB swupdate
Date: Thu, 18 Aug 2022 09:34:28 +0530
X-TSB-HOP2: ON
Message-Id: <20220818040428.11124-5-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Aug 2022 04:12:28.0332 (UTC)
 FILETIME=[BAB106C0:01D8B2B8]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9288

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.bbb.md | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 doc/README.swupdate.bbb.md

diff --git a/doc/README.swupdate.bbb.md b/doc/README.swupdate.bbb.md
new file mode 100644
index 0000000..82b96aa
--- /dev/null
+++ b/doc/README.swupdate.bbb.md
@@ -0,0 +1,90 @@
+# SWUpdate support for the CIP core image
+
+This document describes how to build and test the SWUpdate on BBB
+
+Start with cloning the isar-cip-core repository:
+```
+host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+host$ cd isar-cip-core
+```
+
+# Building and testing the CIP Core image
+
+Set up `kas-container` as described in the [top-level README](../README.md).
+Then build the image which will later serve as update package:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/bbb.yml:kas/opt/swupdate.yml
+```
+
+To flash, e.g., the BeagleBone Black image to an SD card, run
+```
+dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
+        of=/dev/<medium-device> bs=1M status=progress
+```
+
+or via bmap-tools
+```
+bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic /dev/<medium-device>
+```
+
+Prepare the hardware connections
+
+* Connect a serial port cable between the host PC and the BBB
+* Connect an Ethernet cable between the host PC and the BBB
+
+Insert SD card to BBB, hold S2 button while applying power suppy to BBB.
+
+Once the system is up, check which partition is booted, e.g. with "df -h" command :
+```
+root@demo:~# df -h
+Filesystem      Size  Used Avail Use% Mounted on
+udev            238M     0  238M   0% /dev
+tmpfs           500M  6.5M  494M   2% /run
+/dev/mmcblk0p2  2.5G  297M  2.1G  13% /
+tmpfs           249M     0  249M   0% /dev/shm
+tmpfs           5.0M     0  5.0M   0% /run/lock
+tmpfs           249M     0  249M   0% /sys/fs/cgroup
+tmpfs           249M     0  249M   0% /tmp
+/dev/mmcblk0p1   32M  936K   32M   3% /boot
+```
+
+In host PC, configure below settings for Ethernet IPv4. 
+
+* IP address: 192.168.2.1
+* Subnet mask: 255.255.255.0
+
+Execute below command to confirm 192.168.2.1 is accessible from BBB.
+```
+root@demo:~# ping 192.168.2.1
+```
+
+Copy .swu file to BBB from host PC using below command.
+```
+host$ scp build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.swu root@192.168.2.2:/root/
+```
+
+Now apply swupdate and reboot
+```
+root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-bbb.swu
+root@demo:~# reboot
+```
+
+Check which partition is booted, e.g. with "df -h" command and the rootfs should have changed
+```
+root@demo:~# df -h
+Filesystem      Size  Used Avail Use% Mounted on
+udev            238M     0  238M   0% /dev
+tmpfs           500M  6.5M  494M   2% /run
+/dev/mmcblk0p3  2.5G  297M  2.1G  13% /
+tmpfs           249M     0  249M   0% /dev/shm
+tmpfs           5.0M     0  5.0M   0% /run/lock
+tmpfs           249M     0  249M   0% /sys/fs/cgroup
+tmpfs           249M     0  249M   0% /tmp
+/dev/mmcblk0p1   32M  936K   32M   3% /boot
+```
+
+Set ustate to 0 after successful swupdate
+```
+root@demo:~# ln -s /usr/bin/fw_printenv /usr/bin/fw_setenv
+root@demo:~# fw_setenv ustate 0
+```
-- 
2.20.1



