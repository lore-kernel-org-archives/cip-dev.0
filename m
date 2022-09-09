Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E0BECAAA1
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 13:34:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.1287.1662730442680095981
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 06:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 289DY0KT015220;
 Fri, 9 Sep 2022 22:34:00 +0900
X-Iguazu-Qid: 34tKHR6adpIkSxaFHM
X-Iguazu-QSIG: v=2; s=0; t=1662730440; q=34tKHR6adpIkSxaFHM;
 m=Bh3W2rKL/5nQOeWSNhOsduNQE1LWyAnKe5rMnCcV5Zw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 289DXxQB006452
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 22:33:59 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] README.swupdate.md: Add steps to verify SWUpdate on
 BBB
Date: Fri,  9 Sep 2022 18:55:35 +0530
X-TSB-HOP2: ON
Message-Id: <20220909132535.3671-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Sep 2022 13:33:57.0175 (UTC)
 FILETIME=[CFE50470:01D8C450]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 13:34:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9482

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Most of the steps are similar for both qemu-amd64 and BBB targets.
Add reference link wherever required instead of repeating steps.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1b242a2..72690d6 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -32,6 +32,8 @@ Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder in
 host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
 ```
 
+## SWUpdate verification
+
 Check which partition is booted, e.g. with lsblk:
 ```
 root@demo:~# lsblk
@@ -215,3 +217,53 @@ user variables:
 
 
 ```
+
+# Building and testing the CIP Core image for BBB
+
+Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
+- Replace qemu-amd64.yml kas file with BBB board specific file i.e bbb.yml
+- .swu file will be generated in the following folder build/tmp/deploy/images/bbb/
+
+Flash the BeagleBone Black image into SDcard
+```
+host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
+   of=/dev/<medium-device> bs=1M status=progress
+```
+
+Prepare the hardware connections
+
+- Connect a serial port cable between host PC and BBB
+- Connect an Ethernet cable between host PC and BBB
+
+Insert SD card to BBB, hold S2 button while applying power suppy to BBB.
+Once the system is up, execute below command to configure static IP address to BBB
+
+```
+root@demo:~# cat <<EOF >> /etc/network/interfaces
+auto eth0
+iface eth0 inet static
+  address 192.168.2.2
+  netmask 255.255.255.0
+  network 192.168.2.0
+  broadcast 192.168.2.255
+EOF
+root@demo:~# /etc/init.d/networking restart
+```
+
+In host PC, configure below settings for Ethernet IPv4.
+
+- IP address: 192.168.2.1
+- Subnet mask: 255.255.255.0
+
+Execute below command to confirm 192.168.2.1 is accessible from BBB.
+```
+root@demo:~# ping 192.168.2.1
+```
+
+Copy .swu file from `tmp` folder to BBB from host PC using below command.
+
+```
+host$ scp tmp/cip-core-image-cip-core-bullseye-bbb.swu root@192.168.2.2:/root/
+```
+
+For verifying swupdate on BBB use the same steps as mentioned in above [SWUpdate Verification](README.swupdate.md#swupdate-verification).
-- 
2.20.1



