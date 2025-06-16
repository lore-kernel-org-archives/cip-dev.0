Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B9C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 10:48:04 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.27586.1750070877569639901
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 03:47:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=ToxsFKQ9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025061610475491755fb9db78c13c4e-i3t_tu@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025061610475491755fb9db78c13c4e
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Jun 2025 12:47:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=a74FRXnX1htCZYDYjkbchWXWvuy1uTll4QtNon5cUfM=;
 b=ToxsFKQ9e6cXWX9BbP1yBCEpTIL7+d3yfl1qwYbxhk6dXXKGnPq45/YJGdJAVWLp3MGsVD
 02Q/+mRdN9VylYqG5gM0lXx51RS7d6pg1JPE309DiobbVa1Q7Cjn7EcT3gguoF0okfE35TQj
 32jEVnybjU1xMQD+q+LSKajZn0OUkeuDkbdPuggvywS0YxcfH8oMOkkP2o1N1WSGMjhrwGfB
 SIXFXtHtGHdmIWxxXEZtV0Hfuza/VJHxm7RLEOYsIL4b+Peu9HXIhNLOnCRD0K3YezZH2cnn
 XlWnrB4DS247xlt0JsgUXQX1IjEMK8kiXn14693jifUDH7tO8hDP0IjQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] fix: Shutdown the TPM after disk are decrypted
Date: Mon, 16 Jun 2025 12:47:00 +0200
Message-ID: <20250616104736.1839331-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 10:48:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19105

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If an power failure occurs and the TPM was open/in-use the DA lockout
counter will be increased. If enough shutdowns occur the device will go
into lock down mode.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - use tpm2_shutdown direct instead the wrapper command tpm2 shutdown

 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index ae0dcef..009289b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
 	finalize_tpm2_encryption "$part_device"
 done
 
+# shutdown the TPM to avoid DA lockout due to powerfailure
+tpm2_shutdown
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


