Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA4C00528
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.13569.1688739362404946411
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 367EG0sk1368985; Fri, 7 Jul 2023 23:16:00 +0900
X-Iguazu-Qid: 2rWhW3wiOEgeNQSSi8
X-Iguazu-QSIG: v=2; s=0; t=1688739360; q=2rWhW3wiOEgeNQSSi8; m=ccmTjAMKYR0S8GghYcEBdpySsuAKBOrvIuWWiJ9RCJA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 367EFxtb1727345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:16:00 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 6/8] swupdate.bbclass: Fix file timestamps are not reproducible in swu file
Date: Fri,  7 Jul 2023 19:45:48 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-7-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0558 (UTC) FILETIME=[8AB5EDE0:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12270

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



