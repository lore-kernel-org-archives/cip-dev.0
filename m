Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CFC3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 08:17:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.19439.1719908263852177222
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 01:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4628Hf1q1211598; Tue, 2 Jul 2024 17:17:42 +0900
X-Iguazu-Qid: 2yAag3vsnw14iicGc4
X-Iguazu-QSIG: v=2; s=0; t=1719908261; q=2yAag3vsnw14iicGc4; m=1juhMq6RiHv/Vt0bEugDVHIZ1xqnTszlF6qEy9Id5EI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 4628HeON2044692
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 17:17:41 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/1] wic: Set size for rootfs partition
Date: Tue,  2 Jul 2024 13:47:07 +0530
X-TSB-HOP2: ON
Message-Id: <20240702081708.3339644-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702081708.3339644-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240702081708.3339644-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jul 2024 08:17:38.0774 (UTC) FILETIME=[4D595760:01DACC58]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 08:17:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16356

In the case where no size parameter is set in the wks file, wic estimates
the rootfs size from the rootfs directory in WORKDIR. Sometimes the
ROOTFS_SIZE variable is not the same between builds, although the rootfs
contents are identical. This can lead to different partition images
(in terms of number of blocks in each partiton image) which makes the
partition images non-reproducible.

Although this patch doesn't fix the core problem, setting a reasonable
size to the rootfs partition would not cause any harm.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 wic/bbb.wks            | 2 +-
 wic/x86_64-generic.wks | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wic/bbb.wks b/wic/bbb.wks
index b46282d..6b441e8 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d --size 1G
 
 bootloader --append "rootwait console=ttyO0,115200"
diff --git a/wic/x86_64-generic.wks b/wic/x86_64-generic.wks
index a2b9c21..ac63bb7 100644
--- a/wic/x86_64-generic.wks
+++ b/wic/x86_64-generic.wks
@@ -8,6 +8,6 @@
 
 part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
 
-part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb --size 1G
 
 bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.39.2



