Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA2CE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:44:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.30550.1695188641712832610
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 38K5hxGa079967; Wed, 20 Sep 2023 14:44:00 +0900
X-Iguazu-Qid: 2yAaEO0URrpJ2ssgmD
X-Iguazu-QSIG: v=2; s=0; t=1695188639; q=2yAaEO0URrpJ2ssgmD; m=sbZ2o3iYbixUBgkhlRdYyeNStjs/7mJEQgaOElXnxbM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 38K5hw2M3281065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Sep 2023 14:43:59 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] bbb.wks: Add fsuuid value to the rootfs device
Date: Wed, 20 Sep 2023 11:13:57 +0530
X-TSB-HOP2: ON
Message-Id: <20230920054357.7957-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Sep 2023 05:43:56.0638 (UTC) FILETIME=[72628FE0:01D9EB85]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:44:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13175

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The filesystem images are not reproducible because the partition UUID
values is generated randomly.

To fix this assigned fixed UUID value to partition.

Fixes: #77

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 wic/bbb.wks | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/bbb.wks b/wic/bbb.wks
index 6131c78..a797e95 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
 
 bootloader --append "rootwait console=ttyO0,115200"
-- 
2.20.1



