Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D75FF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 09:11:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9078.1777367487896069215
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 02:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=FSWshcD1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202604280911244fc010839a000207c5-4ufmhf@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202604280911244fc010839a000207c5
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 Apr 2026 11:11:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=H4vP4tm11xMT3Nz+HCxP2IZdKuKIveS8/R0i1LqAGyw=;
 b=FSWshcD1WreweQMzZWBmi194AiHtjenQ+tCwjoePdG+Vgr7sP4xyXMsmU9rE/8GX0VWuzh
 xxVygQviM0Bp2wzuV6tGLzHynpq8WOe7+E0xQUigDiOm6I/0XE8pKLiY4mKMTctmhk4zc5+b
 aDAJXi8AaNyFhTGJcephYHXPsD/NiB6huF/Bxr3eTdMOs3mIgr4JJpa77C2MqJQrSwiEzHzM
 NPmFdxtB/boDifiByYFfkvGIAzq/Cl9EJ3fnsLDBecCp2fTC3VKM66X4zHdGS+umLqlfuVi7
 83pUwg1OWzxg6/MtIVoxFyvZtL8rdLtR2A/AxgmxfHZb43SDHQcm22BQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] crypt-hook: Check if WATCHDOG_DEV is set and available
Date: Tue, 28 Apr 2026 11:11:02 +0200
Message-ID: <20260428091124.1765253-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 09:11:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22814

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids an error message on systems without the given `WATCHDOG_DEV`
and allows the user to disable the watchdog by emptying the variable
`INITRAMFS_WATCHDOG_DEVICE`.

Reported-by: Stefan Koch <stefan.koch@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete    | 12 +++++++-----
 ...ypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 4f3eafc..fa4980c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -64,10 +64,12 @@ if [ -z "${create_file_system_cmd}" ]; then
 fi
 
 service_watchdog() {
-	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-		printf '\0'
-		sleep 10
-	done > "$WATCHDOG_DEV"
+	if [ -n "$WATCHDOG_DEV" ] && [ -f "$WATCHDOG_DEV" ]; then
+		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+			printf '\0'
+			sleep 10
+		done > "$WATCHDOG_DEV"
+	fi
 }
 
 check_partitions()
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
similarity index 99%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index c0572f2..331a662 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2025
+# Copyright (c) Siemens AG, 2020-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-- 
2.53.0


