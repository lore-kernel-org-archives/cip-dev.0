Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD2CFF8868
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 11:32:53 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10900.1777375971141705727
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 04:32:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=eA4bvoNV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20260428113247ffe847953800020799-lnjaps@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260428113247ffe847953800020799
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 Apr 2026 13:32:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=dKryMYnJmJbwMx2oKxGztPgUR55KZS1OjJjdJRZQA4Q=;
 b=eA4bvoNVG6DNsSeopki6t3+HbVx+M2p/BeD0x4LcmTsBQF0+PputCaWCKZJs39tu4TxzKr
 +gFbROtdEiBJPEQxiM/csgvMy59/d1gqZRo+abeVzJGtvaSBz2e/TQVsJPw5m6dV8apqpwv3
 UccZIp75fCUYDeIS/98phU1L5esPHNXRQLX3HXYLlL71mtw1qtn5UE0YVYhLjaVqVMkdKiPu
 MGq31UObs5DsvhD8Hiph8yy/v80qXZG/JGrm3ZrbSo7BkOJELN+TIremukIDqs6obWytktvH
 PSD/wwkz/JF0OgQLX989YMjTdH+8hzOYZFVCet2q27AWgRcg8zrXurhg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] crypt-hook: Check if WATCHDOG_DEV is set and available
Date: Tue, 28 Apr 2026 13:32:36 +0200
Message-ID: <20260428113247.27835-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 11:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22818

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to disable the watchdog by emptying the variable
`INITRAMFS_WATCHDOG_DEVICE`.

Also add  a panic if the watchdog device is configured
and not available.

Reported-by: Stefan Koch <stefan.koch@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - if the watchdog is configured and not available panic the initrd
 - add a message if the watchdog is disable

 .../files/local-top-complete                    | 17 ++++++++++++-----
 ...ook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 4f3eafc..e802f0b 100644
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
@@ -64,10 +64,17 @@ if [ -z "${create_file_system_cmd}" ]; then
 fi
 
 service_watchdog() {
-	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-		printf '\0'
-		sleep 10
-	done > "$WATCHDOG_DEV"
+	if [ -n "$WATCHDOG_DEV" ]; then
+		if [ ! -f "$WATCHDOG_DEV" ]; then
+			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
+		fi
+		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+			printf '\0'
+			sleep 10
+		done > "$WATCHDOG_DEV"
+	else
+		echo "Watchdog is disabled."
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


