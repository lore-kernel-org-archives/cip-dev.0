Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B2C636F7
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:14 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web08.28336.1650887389129579320
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 04:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=iw8J0h0X;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220425114950866321e5e3d02703cf-qsfqg1@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220425114950866321e5e3d02703cf
        for <cip-dev@lists.cip-project.org>;
        Mon, 25 Apr 2022 13:49:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u8zys2BaEHqc0dIDxuwj2oNu0LOItZAXqnzb9IebYMI=;
 b=iw8J0h0X+u4/ohmIo6qNXtxiQjJqqBBjkfIpPzvBIo+Q4u6G2ruV1sv1fmV+h6oulSSKi/
 4wKJ0iPLXErc6BJJPsS8+ZWura769BImTrNah2dSu7ELJ7E9Qjn0A7A/Q7L2CiW67j3YsKfB
 BaVRB+J4djkcf5bmpIiTbfr92IEEY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v3 6/7] initramfs-verify-hook: Optimize probing
 of partitions
Date: Mon, 25 Apr 2022 13:49:43 +0200
Message-Id: 
 <5d7042d930fa037b3e4e2b57e3dcb9dc3350eab6.1650887383.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650887383.git.jan.kiszka@siemens.com>
References: <cover.1650887383.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8198

From: Jan Kiszka <jan.kiszka@siemens.com>

Rather than verifying the complete device, match on the UUID embedded
into the dm-verity superblock. That is much faster and, thus, saves boot
time with large partitions and/or slow devices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/verity.script.tmpl                   | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
index 7c75b5b..da37711 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
+++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
@@ -37,12 +37,20 @@ case "$ROOT" in
     "")
         # No Root device was given. Use veritysetup verify to search matching roots
         partitions=$(blkid -o device)
-        for part in $partitions; do
+        for part in ${partitions}; do
             if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
-                if veritysetup verify \
-                   "$part" "$part" "${ROOT_HASH}" \
-                   --hash-offset "${HASH_OFFSET}";then
-                    ROOT="$part"
+                verity_uuid=$(
+                    veritysetup dump "${part}" --hash-offset "${HASH_OFFSET}" | \
+                        while IFS=":" read key value; do
+                            if [ "${key}" = "UUID" ]; then
+                                # this pattern must use a real tab
+                                echo "${value##*	}"
+                                break
+                            fi
+                        done
+                    )
+                if [ "${UUID}" = "${verity_uuid}" ]; then
+                    ROOT="${part}"
                     break
                 fi
             fi
-- 
2.34.1


