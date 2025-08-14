Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1FCA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 10:31:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.19339.1755167474261736788
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 03:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 57EAVBoj3270166; Thu, 14 Aug 2025 19:31:12 +0900
X-Iguazu-Qid: 2rWhEqwpnsUbCRjtwH
X-Iguazu-QSIG: v=2; s=0; t=1755167471; q=2rWhEqwpnsUbCRjtwH; m=7vCkuoeZlsIFsF2nVFTLCPh1eRE0obkOooTUnlOZl00=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 57EAVAea3426259
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:31:11 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 2/5] delta-update.yml: Add previous image kernel file for rdiff delta update
Date: Thu, 14 Aug 2025 15:51:12 +0530
X-TSB-HOP2: ON
Message-Id: <20250814102117.2608463-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2025 10:31:07.0335 (UTC) FILETIME=[8B5CC570:01DC0D06]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 10:31:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19744

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



