Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28837C7113B
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 10:41:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7989.1692873689647231368
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Aug 2023 03:41:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37OAfO3G808194; Thu, 24 Aug 2023 19:41:24 +0900
X-Iguazu-Qid: 2rWgqlGKyH0WfEubtS
X-Iguazu-QSIG: v=2; s=0; t=1692873684; q=2rWgqlGKyH0WfEubtS; m=3WgJpI70WBwSc5ade4NsxSD4QLeUtDbiZuk8Qezo4kQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 37OAfM8S364727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Aug 2023 19:41:23 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] qemu*.wks.in: Add filessystem UUID to home and var partitions
Date: Thu, 24 Aug 2023 16:11:19 +0530
X-TSB-HOP2: ON
Message-Id: <20230824104119.5464-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <177DF6549CC2A4D6.6662@lists.cip-project.org>
References: <177DF6549CC2A4D6.6662@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Aug 2023 10:41:19.0648 (UTC) FILETIME=[847E9200:01D9D677]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 10:41:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12845

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The filesystem images are not reproducible without constant UUID's, so
assigned UUID's for home and var partition.

Fixes: #74

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
 wic/x86-efibootguard.wks.in                   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 12fa45f..4a21fa7 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid "1f55d66a-40d8-11ee-be56-0242ac120002"
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid "96be3374-4258-11ee-be56-0242ac120002"
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index a58928a..9145379 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid "1f55d66a-40d8-11ee-be56-0242ac120002"
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid "96be3374-4258-11ee-be56-0242ac120002"
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index bcd736e..9e9567b 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid "1f55d66a-40d8-11ee-be56-0242ac120002"
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid "96be3374-4258-11ee-be56-0242ac120002"
 
 bootloader --ptable gpt
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index 38ad411..d39f92d 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M 
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid "1f55d66a-40d8-11ee-be56-0242ac120002"
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid "96be3374-4258-11ee-be56-0242ac120002"
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.20.1



