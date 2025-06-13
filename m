Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E7C71136
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 13:52:12 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.10933.1749822722217574397
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 06:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=psAlv6hH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202506131351566764dba3fdec005cbd-p_fz02@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202506131351566764dba3fdec005cbd
        for <cip-dev@lists.cip-project.org>;
        Fri, 13 Jun 2025 15:51:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=A50eozoXfEmCMb1UfsXed8tn9RHrV4NnKPO4izoocg8=;
 b=psAlv6hHAS+4jdvYQ2Bp9k5tbZSszxhIes+SMYh8bG2jpl897Eu0ECOlTI0U0zXRMSNhIC
 AxEI9vcEu6F5VH3+pVh0IGHKQ+3Zyruu+KiuNaKAmt0gtBLkOf/RT0kCxuCsdZm6L5oG1dtL
 ud+wA3UAtb274ChUBzTfgUFWG50TIwvzDUoDOGeBA+GuOcaFYNG9t1ynz7iC+iIBT2r1F3mv
 OO7USsKO2/zGIgghRIKxmzSz42AqN8U280Y0pT158RmG+A45/BXhAghySd9lPEIW/Ofe0qSI
 dGLt4ikrn/W8LXdMmydDM7X+V95sWyW4todU8A7xnRzIFjWTZisJ7ckA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] fix: Shutdown the TPM after disk are decrypted
Date: Fri, 13 Jun 2025 15:51:37 +0200
Message-ID: <20250613135155.1440058-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 13:52:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19084

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If an power failure occurs and the TPM was open/in-use the DA lockout
counter will be increased. If enough shutdowns occur the device will go
into lock down mode.

This error occurs on real hardware and in QEMU.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index ae0dcef..113f44c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
 	finalize_tpm2_encryption "$part_device"
 done
 
+# shutdown the TPM to avoid DA lockout due to powerfailure
+tpm2 shutdown
 if [ -n "$watchdog_pid" ]; then
 	kill "$watchdog_pid"
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
index 80a4755..41a3c83 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
@@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
 HOOK_COPY_EXECS = " \
     openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
     e2fsck resize2fs cryptsetup \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext  tpm2_shutdown \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
-- 
2.47.0


