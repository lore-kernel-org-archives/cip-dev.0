Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8C7C54EE9
	for <webhook@archiver.kernel.org>; Fri, 16 Sep 2022 11:52:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.5025.1663329124214410216
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Sep 2022 04:52:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 28GBq1JX019692;
 Fri, 16 Sep 2022 20:52:01 +0900
X-Iguazu-Qid: 34tKrWNyUPAciSLNAY
X-Iguazu-QSIG: v=2; s=0; t=1663329121; q=34tKrWNyUPAciSLNAY;
 m=/rTZJU26JQkO6lemG5i3JTMWcuIRvKCRSqPF7tLvJIA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 28GBq0Mb030315
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Sep 2022 20:52:01 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2] README.swupdate.md: Add steps to verify SWUpdate
 on BBB
Date: Fri, 16 Sep 2022 17:13:30 +0530
X-TSB-HOP2: ON
Message-Id: <20220916114330.18443-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Sep 2022 11:51:58.0605 (UTC)
 FILETIME=[B9D593D0:01D8C9C2]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Sep 2022 11:52:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9497

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Most of the steps are similar for both qemu-amd64 and BBB targets.
Add reference link wherever required instead of repeating steps.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1b242a2..9be3498 100644
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
@@ -215,3 +217,26 @@ user variables:
 
 
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
+After flashing the BBB image into SD card, mount the SD card on host PC and copy .swu file directly to root partition like below.
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



