Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7597CECAAD8
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 10:45:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.10172.1663670726241051392
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 03:45:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 28KAjMJ4031334;
 Tue, 20 Sep 2022 19:45:22 +0900
X-Iguazu-Qid: 2wGrOipqTTF673PeK0
X-Iguazu-QSIG: v=2; s=0; t=1663670722; q=2wGrOipqTTF673PeK0;
 m=HHLxWIsEtwwOPRD+kZJYaaVjfFsNY9EPDT+F7VEVdZI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 28KAjKED012374
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Sep 2022 19:45:21 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3] README.swupdate.md: Add steps to verify SWUpdate
 on BBB
Date: Tue, 20 Sep 2022 16:06:46 +0530
X-TSB-HOP2: ON
Message-Id: <20220920103646.25672-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Sep 2022 10:45:18.0830 (UTC)
 FILETIME=[136F58E0:01D8CCDE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 10:45:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9526

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Most of the steps are similar for both qemu-amd64 and BBB targets.
Add reference link wherever required instead of repeating steps.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1b242a2..97de777 100644
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
@@ -215,3 +217,27 @@ user variables:
 
 
 ```
+
+# Building and testing the CIP Core image for BBB
+
+Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
+- Replace qemu-amd64.yml kas file with BBB board specific file i.e bbb.yml
+- .swu file will be generated in the following folder build/tmp/deploy/images/bbb/
+- Create Non-RT and RT Kernel images as mentioned in the section
+
+Flash the BeagleBone Black RT kernel image into SDcard
+```
+host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
+   of=/dev/<medium-device> bs=1M status=progress
+```
+
+After flashing the BBB RT kernel image into SD card, mount the SD card on host PC and copy .swu file from `tmp` folder to root partition like below.
+
+```
+host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu /<mnt>/home/root/
+```
+
+Connect a serial port cable between host PC and BBB.
+Insert SD card to BBB, hold S2 button while applying power supply to BBB.
+
+For verifying swupdate on BBB use the same steps as mentioned in above [SWUpdate Verification](README.swupdate.md#swupdate-verification).
-- 
2.20.1



