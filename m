Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09494C001B0
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.21490.1688365359701304096
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3636Mcwx3084847; Mon, 3 Jul 2023 15:22:38 +0900
X-Iguazu-Qid: 2rWh7t7B0U1DTxtjXy
X-Iguazu-QSIG: v=2; s=0; t=1688365357; q=2rWh7t7B0U1DTxtjXy; m=f0XdVJIdApAnMNgY0iQ76cDa9hDcr9TqimytDOrqbnk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3636MasZ688689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:37 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 6/6] swupdate.bbclass: Fix file timestamps are not reproducible in swu file
Date: Mon,  3 Jul 2023 11:52:31 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-7-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0796 (UTC) FILETIME=[BFB16340:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12177

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The generated .swu file is not reproducible due to its file contents are
copied with its build time stamps, so set all file timestamps to
SOURCE_DATE_EPOCH value if it is set.

Closes #69

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 classes/swupdate.bbclass | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index ac59c00..3d2b5f0 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -115,6 +115,10 @@ IMAGE_CMD:swu() {
         done
         cd "${PP_WORK}/swu"
         for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
+            # Set file timestamps for reproducible builds
+            if [ -n "${SOURCE_DATE_EPOCH}" ]; then
+                touch -d@"${SOURCE_DATE_EPOCH}" "$file"
+            fi
             echo "$file"
             if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
                 if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
@@ -129,9 +133,13 @@ IMAGE_CMD:swu() {
                         -inkey "${PP_WORK}/dev.key" \
                         -outform DER -nosmimecap -binary
                 fi
+                # Set file timestamps for reproducible builds
+                if [ -n "${SOURCE_DATE_EPOCH}" ]; then
+                    touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
+                fi
                 echo "$file.${SWU_SIGNATURE_EXT}"
            fi
-        done | cpio -ovL -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
+        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
 }
 
 python do_check_swu_partition_uuids() {
-- 
2.20.1



