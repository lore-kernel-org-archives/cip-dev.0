Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA3C25B5F
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:45 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.21519.1715005118938730790
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=oox6vEZT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240506141836b348947f6bb149e8db-xpeojc@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240506141836b348947f6bb149e8db
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=CsDk/I44tpNEBC69t9t6muDeP5tGvNsrQcP7JzgVh+8=;
 b=oox6vEZT/TcSEpavRezvvCQ1A4xzf+m8gMgh2+5xU0FaUryEZrMGzSI0C4Of2y+QgH72PN
 cnuSSFvaiC0nmL/GllMwxwx4fuzMk4fluyhb90dRTHkMLwMq6AvrRk1OfW1vm1uOVY+IiqIO
 /Q0uMIjlrYQLf7Tvn/t2JJbS6EJZY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 10/11] fix: Remove spurious '-'
Date: Mon,  6 May 2024 16:17:31 +0200
Message-ID: <20240506141833.3622989-11-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15838

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This remove the `-` introduced with cfef8103(initramfs-crypt-hook: Consolidate clevis and systemd scripts) to fix the following error:
```
/scripts/local-top/encrypt_partition: 55: /scripts/local-top/encrypt_partition: -: not found
```

Also set the missing parameter $part_device.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 857b73f..d9a85e5 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -183,7 +183,7 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	finalize_tpm2_encryption
+	finalize_tpm2_encryption "$part_device"
 done
 
 if [ -n "$watchdog_pid" ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 611f9cf..1b7c83b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -52,6 +52,6 @@ prepare_for_encryption() {
 
 finalize_tpm2_encryption() {
 	partition_device="$1"
--	/usr/bin/systemd-cryptenroll --wipe-slot=0 "$partition_device"
+	/usr/bin/systemd-cryptenroll --wipe-slot=0 "$partition_device"
 }
 
-- 
2.43.0


