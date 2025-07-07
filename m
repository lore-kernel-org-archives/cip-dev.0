Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCEBC83F0C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.56250.1751879784103062781
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VsWupf6H;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20250707091620c15bc87975d2b85d46-wr0dyg@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250707091620c15bc87975d2b85d46
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BOQP1xWHccTIxQf9ad7uUCMC/1dJK9B4B34NeKdQK1A=;
 b=VsWupf6HxlMQO1rlaBBOaKpMl3vgyUVGp8/eeL+016Jds8Qk4an4C9tIRpza40lbktSdVB
 HP9yQt3x/ptPF+tkEVm1zMdlz7IQ2wEfBTfmu4H96fn0dsoLmlxuyOAXeSvNxKJ9VuWUYefU
 Z+Sp2x2Z0+qhoRNKQDWsoykNa8h0xevDAp+TC1MQFN5YIIg1TI8xv3cJwl/IPGtH4fBWJAqF
 fuekzpJO1LYLF6rNDuUufbJdOtMi8QbyarsKb03dECrPA+DGU+GuRBL3mP9g0ovdAxL9UbRD
 p5wd/+I0n65Yo/BqgF90M9/oU3zo4OTRAWUsNCyCtUOCSQF57B9TIURQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 1/8] initramfs-crypt-hook: Use pwgen instead of openssl for initial passphrase
Date: Mon,  7 Jul 2025 11:16:13 +0200
Message-ID: <0d4671e2284c07001c7978ca4a057859487e690a.1751879779.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1751879779.git.jan.kiszka@siemens.com>
References: <cover.1751879779.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19375

From: Jan Kiszka <jan.kiszka@siemens.com>

Reduces the initramfs by almost 400K on amd64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete           | 4 ++--
 ...tramfs-crypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} (97%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 2b4bed02..087da96e 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -262,7 +262,7 @@ for partition_set in $partition_sets; do
 	# create random password for initial encryption
 	# this will be dropped after reboot
 	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
+	pwgen -s -1 32 > "$tmp_key"
 
 	case "${partition_format}" in
 		"reencrypt")
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
similarity index 97%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index f3b6c82e..6815476a 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2024
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,7 +14,7 @@ require recipes-initramfs/initramfs-hook/hook.inc
 DEBIAN_DEPENDS .= ", \
     cryptsetup, \
     awk, \
-    openssl, \
+    pwgen, \
     e2fsprogs, \
     tpm2-tools, \
     coreutils, \
@@ -40,7 +40,7 @@ HOOK_ADD_MODULES = " \
     ecb aes_generic xts"
 
 HOOK_COPY_EXECS = " \
-    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
+    pwgen mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
     e2fsck resize2fs cryptsetup \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
     /usr/lib/*/libgcc_s.so.1"
-- 
2.43.0


