Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1250CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 13:56:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.101994.1755093384559938784
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 06:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57DDuM583204225; Wed, 13 Aug 2025 22:56:22 +0900
X-Iguazu-Qid: 2rWhMjEQNN4BFLrJ0i
X-Iguazu-QSIG: v=2; s=0; t=1755093381; q=2rWhMjEQNN4BFLrJ0i; m=7eU57WXB14fpPtb5p1EawdtBfxxMBhqApno9Kdi/ZrY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 57DDuKPA2497940
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 22:56:21 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/5] delta-update.yml: Add previous image kernel file for rdiff delta update
Date: Wed, 13 Aug 2025 19:16:26 +0530
X-TSB-HOP2: ON
Message-Id: <20250813134630.3943194-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Aug 2025 13:56:17.0707 (UTC) FILETIME=[0A80B7B0:01DC0C5A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 13:56:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19729

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 kas/opt/delta-update.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
index a2f583c..7d4c28c 100644
--- a/kas/opt/delta-update.yml
+++ b/kas/opt/delta-update.yml
@@ -17,4 +17,5 @@ local_conf_header:
     IMAGE_FSTYPES:append = " delta_update"
     DELTA_UPDATE_TYPE = "rdiff"
     DELTA_RDIFF_REF_IMAGE = "${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
+    DELTA_RDIFF_REF_KERNEL_IMAGE = "linux.efi"
     DELTA_ZCK_URL = ""
-- 
2.39.5



