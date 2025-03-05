Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D50C28B23
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 12:00:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11601.1741176028346165463
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 04:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=U+B3cn/W;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8809E10381919;
	Wed,  5 Mar 2025 13:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741176026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xcCyhcGu2r0nuRsIHgzPkBE3xajeJLfWmoOAiA62FXE=;
	b=U+B3cn/W5UnY5Oy1GavjyEMdnMEQb5i+0m/9CMut6657XGud31t4m72KLxvCJj6WZ8ubIR
	aDPwEK7gbrzE0iAcoejGysZhYpRnJ4pjolHUNviEP5uJJgXpKsIw9jaWt1PY4/MMBF+DBI
	gv3YZUesKGUS0KQFxL25krM6NOvURxOli7x8GIS19xFQ2WICMQ+8XQV57ctXxq4j3ZLJV+
	c9I/thC+/vmHuNa/wTZv8D9jF1Dv3juqPQaQ5WjuSVfWuobROMfGXDwfz0t4VmVpnFW4Zz
	dQUCRGhBHZKAyezDMEHboDDht7Zva+9uSgZVSis7yf73qFhydM+z7JKohp7iwg==
From: Claudius Heine <ch@denx.de>
Date: Wed, 05 Mar 2025 13:00:20 +0100
Subject: [PATCH v4 2/5] initramfs-crypt-hook: use static temporary
 encryption key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
In-Reply-To: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 12:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18043

Using a temporary random value for the temporary encryption key makes it
impossible to continue encryption if it was aborted at a later date.

Instead a static key can be used, which will allow the continuation of
the encryption process.

Security wise the partially encrypted volume, with a static temporary
encryption key can be considered the same as the un-encrypted partition
that was there before the system has booted. So using a known temporary
encryption key should not affect the system security in that way.

It is just important to let the re-encryption process properly finish
until the temporary encryption key is removed.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete    | 7 ++++---
 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index ae0dcef4cb62a135beb6d4229237144b6d4edf8b..ea9b6352daadbea625d6168d1dc75ad616028fe0 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -259,10 +259,11 @@ for partition_set in $partition_sets; do
 		watchdog_pid=$!
 	fi
 
-	# create random password for initial encryption
-	# this will be dropped after reboot
+	# use partuuid of the partition for initial encryption password, this key
+	# will be removed after the reencryption has finished and the TPM2 token is
+	# registered:
 	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
+	blkid -s PARTUUID -o value "$part_device" > "$tmp_key"
 
 	case "${partition_format}" in
 		"reencrypt")
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
index df335c9f75d6e74b3e167689ec9c73dd3781a890..69d204e9539c2e5024db832e5b305fe73396317b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
@@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
 DEBIAN_DEPENDS .= ", \
     cryptsetup, \
     awk, \
-    openssl, \
     e2fsprogs, \
     tpm2-tools, \
     coreutils, \
@@ -40,7 +39,7 @@ HOOK_ADD_MODULES = " \
     ecb aes_generic xts"
 
 HOOK_COPY_EXECS = " \
-    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
+    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
     e2fsck resize2fs cryptsetup \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext \
     /usr/lib/*/libgcc_s.so.1"

-- 
2.47.2


