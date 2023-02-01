Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E618C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:29:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.24828.1675261782063378723
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 06:29:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 311ETd9m031052; Wed, 1 Feb 2023 23:29:39 +0900
X-Iguazu-Qid: 2wGr0AvYwzTdGakMZW
X-Iguazu-QSIG: v=2; s=0; t=1675261778; q=2wGr0AvYwzTdGakMZW; m=IBRI6eiSh0oC0oeDgrJOs8svREkSMugHa+9wt5y2res=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 311ETbrq009321
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Feb 2023 23:29:38 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] kas/opt/swupdate.yml: Add tar.gz for reproducible build checks
Date: Wed,  1 Feb 2023 19:59:46 +0530
X-TSB-HOP2: ON
Message-Id: <20230201142946.25192-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2023 14:29:31.0569 (UTC) FILETIME=[993EEA10:01D93649]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 14:29:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10559

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/swupdate.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index f0d3f1b..7941769 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -21,7 +21,7 @@ local_conf_header:
   wic-swu: |
     IMAGE_CLASSES += "squashfs"
     IMAGE_TYPEDEP_wic += "squashfs"
-    IMAGE_FSTYPES = "wic"
+    IMAGE_FSTYPES = "wic tar.gz"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
     WIC_DEPLOY_PARTITIONS = "1"
-- 
2.20.1



