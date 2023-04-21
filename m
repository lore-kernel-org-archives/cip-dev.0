Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7071C77B7D
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 15:05:52 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.14927.1682089549493940391
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 08:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HMVax8sz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20230421150546d4268fcaaa6f69391e-a0iqfd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230421150546d4268fcaaa6f69391e
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 17:05:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zW5GnE2g3y1HF5rp1cIrRLUMNUM3mKon4ihtzsV0o3U=;
 b=HMVax8sz9UY2CV2j7LvYCw2VxI9uwDLKdfyq+tKgdwX51uy+mNMigKb3TU51//AiNgB11Y
 HwhRcysD8NYtD87xf016MuPGRTEPlK0IE5oaDurRdjf4R4dToo+20eUbsAsZWKl/J9GetAG6
 Bw2hshCbWJdBUWxdFl85p8Ui+cDos=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 2/4] initramfs-crypt-hook: Add support for buster
Date: Fri, 21 Apr 2023 17:05:43 +0200
Message-Id: <20230421150545.4073324-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
References: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 15:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11324

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This introduces the necessary changes for Debian buster(10) with
inplace encryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.hook       | 20 +++++++++++++++----
 .../files/encrypt_partition.clevis.script     |  3 ++-
 .../initramfs-crypt-hook_0.1.bb               |  5 +++--
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 5dbc5be..924ee7f 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -9,7 +9,7 @@ prereqs()
 {
      echo "$PREREQ"
 }
-
+set -x
 case $1 in
 prereqs)
      prereqs
@@ -45,15 +45,26 @@ copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tp
 copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
 copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
 copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
+if [ -x /usr/bin/clevis-luks-list ]; then  
 copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
-copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+fi
+if [ -x /usr/bin/clevis-luks-common-functions  ]; then  
+    copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+fi
 copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary"
 copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
 copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
 copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
-copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+if [ -x /usr/bin/tpm2_pcrread ]; then
+    copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+fi
+if [ -x /usr/bin/tpm2_pcrlist ]; then
+    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+fi
 copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
+if [ -x /usr/bin/tpm2_flushcontext ]; then 
 copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
+fi
 copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
 copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
 copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
@@ -66,8 +77,9 @@ copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
 copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
 copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
 copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
+copy_exec /usr/lib/gcc/*/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/gcc/*/*/libgcc_s.so.1 "
 
-if [ -x cryptsetup-reencrypt ]; then
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


