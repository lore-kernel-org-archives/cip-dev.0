Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D713BCD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 07:26:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.161232.1712733970331648003
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 00:26:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 43A7Q7Z0113112; Wed, 10 Apr 2024 16:26:07 +0900
X-Iguazu-Qid: 2yAajzvdb1fx0maTcv
X-Iguazu-QSIG: v=2; s=0; t=1712733967; q=2yAajzvdb1fx0maTcv; m=4U6k4vFMtDdGdYYa6N6aiEGtixv3rGQ+mcI/U0asTcE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 43A7Q6GA1692762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Apr 2024 16:26:07 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] swupdate.bbclass: Fix setting reproducible timestamps for files in .swu file
Date: Wed, 10 Apr 2024 12:56:50 +0530
X-TSB-HOP2: ON
Message-Id: <20240410072650.1701309-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Apr 2024 07:26:04.0200 (UTC) FILETIME=[588D9280:01DA8B18]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 07:26:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15528

Fix setting reproducible timestamps for the files that are included in the
.swu file.

This fixes issue #103

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 1c495da..25704aa 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -252,7 +252,7 @@ IMAGE_CMD:swu() {
                 if [ -f "$cpio_file" ]; then
                     # Set file timestamps for reproducible builds
                     if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-                        touch -d@"${SOURCE_DATE_EPOCH}" "$file"
+                        touch -d@"${SOURCE_DATE_EPOCH}" "$cpio_file"
                     fi
                     case "$cpio_file" in
                         sw-description*)
-- 
2.39.2



