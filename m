Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDFFC77B71
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 10:48:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.76326.1682419719642697352
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 03:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=jAbVLy8l;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230425104837dc3900142e1628d9c3-zlhjs_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230425104837dc3900142e1628d9c3
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 12:48:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wEans4RDXNdZDLs0Ql8N02ufUOKvZaESHX+5HodUAAQ=;
 b=jAbVLy8lo4QV7cVZu2LK2I6FgTQELabyyAEAeEnrMhbZbnMryoTzNa+iW+5pCUkfOWAQ1/
 3AzB1WgiUhNvB2mkD/oiscUVLKBX1f9L7wQ3Sw+J5MpNSkWXqUo7ePejcYQuLPc+t4IE017s
 Dtp8OG4yUKlTwaQeigY2gqIrcm+oI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 2/6] initramfs-crypt-hook: Add support for buster
Date: Tue, 25 Apr 2023 12:48:31 +0200
Message-Id: <20230425104835.655946-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
References: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 10:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11340

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This introduces the necessary changes for Debian buster(10) with
inplace encryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.hook       | 28 +++++++++++++++----
 .../files/encrypt_partition.clevis.script     |  3 +-
 .../initramfs-crypt-hook_0.1.bb               |  5 ++--
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 5dbc5be..807974b 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -19,6 +19,9 @@ esac
 
 . /usr/share/initramfs-tools/hook-functions
 
+if [ -f /etc/os-release ]; then
+    . /etc/os-release
+fi
 hook_error() {
     echo "(ERROR): $2" >&2
     exit 1
@@ -45,15 +48,26 @@ copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tp
 copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
 copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
 copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
-copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
-copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/clevis-luks-list ]; then
+    copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
+fi
+if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/clevis-luks-common-functions  ]; then
+    copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+fi
 copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary"
 copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
 copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
 copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
-copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_pcrread ]; then
+    copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+fi
+if [ "$VERSION_CODENAME" = "buster" ] && [ -x /usr/bin/tpm2_pcrlist ]; then
+    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+fi
 copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
-copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
+if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_flushcontext ]; then
+    copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
+fi
 copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
 copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
 copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
@@ -66,8 +80,10 @@ copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
 copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
 copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
 copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
-
-if [ -x cryptsetup-reencrypt ]; then
+if [ "$VERSION_CODENAME" = "buster" ]; then
+    copy_exec /usr/lib/gcc/*/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/gcc/*/*/libgcc_s.so.1 "
+fi
+if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
 
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 37bb024..bcb5a04 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -8,6 +8,7 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
+
 prereqs()
 {
 	# Make sure that this script is run last in local-top
@@ -67,7 +68,7 @@ reencrypt_existing_partition() {
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
 	resize2fs "$1" "${reduced_size_in_kb}"
-	if [ -x cryptsetup-reencrypt ]; then
+	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
 		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 1436b94..997f469 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -10,11 +10,12 @@
 
 inherit dpkg-raw
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
-    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
+    awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
+    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs"
 
 CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
-DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}"
+DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
 DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
 DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
 
-- 
2.39.2


