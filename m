Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD39C47088
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.5940.1650613665583308849
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 00:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Q/XBgxM6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202204220747421b15ce5ea9c51c463e-y9a5ei@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202204220747421b15ce5ea9c51c463e
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Apr 2022 09:47:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u8zys2BaEHqc0dIDxuwj2oNu0LOItZAXqnzb9IebYMI=;
 b=Q/XBgxM6M7N9yDWFxp3K+ZKBDVTTsCYB7gWQ4BoYf3EydA2z3P43TNtPwanq23jFqBJmZS
 wS6OLQ1dhBjjvWP2vZVbUPd7cx4K5ZaW0rGxfHsYa56sNvhJcbXbeHKc1R7JMHYVgjh/Cnur
 XLRWsKk96olVR4Oq+pARj4QoaW81k=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 5/6] initramfs-verify-hook: Optimize probing
 of partitions
Date: Fri, 22 Apr 2022 09:47:37 +0200
Message-Id: 
 <8980b6e18b02a48e469f2033b0d53d1e7c1761d6.1650613658.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650613658.git.jan.kiszka@siemens.com>
References: <cover.1650613658.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8180

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


