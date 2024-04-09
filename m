Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5DCCD129E
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.135725.1712668002644562274
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VoMs20zA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240409130640237458237183c91c5a-q6hhqz@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240409130640237458237183c91c5a
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/9EchmLfU9nprs/USFX4/6R1U5g1uq/u9eGaTRDxEh0=;
 b=VoMs20zAC8ksUoakFQ6oGZr3N2pX6hVFUuxmB819MGb7u6KClXkuYNs4mZ8ppSSYTKFWzf
 NYiNKstRhGWl2RivMEL+5UbjxCgOM/loRogmaQ2dW/cKA41AEzR6edlP9hVLmZqX6TC8jKzJ
 SkvLJ6OgAq8PW4aaz4W5dDMVr96TE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 04/15] initramfs-crypt-hook: Check if the TPM device fulfills the given requirements
Date: Tue,  9 Apr 2024 15:05:21 +0200
Message-ID: <20240409130638.559398-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15516

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This also adds the Crypt hash and Crypt algorithm parameter and avoids
errors on missmatches between Hardware and software.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.hook       |  7 ++---
 .../files/encrypt_partition.clevis.script     | 28 +++++++++++++++----
 .../files/encrypt_partition.env.tmpl          |  3 +-
 .../files/encrypt_partition.systemd.hook      |  4 ++-
 .../files/encrypt_partition.systemd.script    | 15 ++++++++--
 .../initramfs-crypt-hook_0.1.bb               |  7 +++--
 6 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index d08594c..347551a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -66,9 +66,10 @@ copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_creat
 copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
 if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_pcrread ]; then
     copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+    copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
 fi
 if [ "$VERSION_CODENAME" = "buster" ] && [ -x /usr/bin/tpm2_pcrlist ]; then
-    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrlist"
 fi
 copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
 if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_flushcontext ]; then
@@ -86,9 +87,7 @@ copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
 copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
 copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
 copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
-if [ "$VERSION_CODENAME" = "buster" ]; then
-    copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
-fi
+copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 0f82c1a..8de8015 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -43,12 +43,10 @@ modprobe xts
 # this needs to be probed particularly for re-encryption
 modprobe loop
 
-# fixed tpm device or do we need to find it
-tpm_device=/dev/tpmrm0
 partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
-hash_type="$HASH_TYPE"
-
+pcr_bank_hash_type="$HASH_TYPE"
+tpm_key_algorithm="$KEY_ALGORITHM"
 if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
@@ -69,7 +67,7 @@ open_tpm2_partition() {
 
 enroll_tpm2_token() {
 	if [ -x /usr/bin/clevis ]; then
-		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'","pcr_ids":"7"}' < "$2"
+		clevis luks bind -d "$1" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$2"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
@@ -102,6 +100,26 @@ mount_partition() {
 	fi
 }
 
+for candidate in /dev/tpm*; do
+	if [ -x /usr/bin/tpm2_pcrread ]; then
+		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
+			continue
+		fi
+	elif [ -x /usr/bin/tpm2_pcrlist ]; then
+		export TPM2TOOLS_DEVICE_FILE="$candidate"
+		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7 > /dev/null; then
+			continue
+		fi
+	fi
+	# Debian buster does not have tpm_testparms
+	if [ -x /usr/bin/tpm2_testparms ]; then
+		if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet; then
+			continue
+		fi
+	fi
+	tpm_device=$candidate
+done
+
 if [ ! -e "$tpm_device" ]; then
 	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index bcc57be..5d28dc5 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -2,4 +2,5 @@ PARTITIONS="${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
 SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
 WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
-HASH_TYPE="${CRYPT_HASH_TYPE}"
\ No newline at end of file
+HASH_TYPE="${CRYPT_HASH_TYPE}"
+KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index c3b31d6..6e2a211 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (C) Siemens AG, 2020-2023
+# Copyright (C) Siemens AG, 2020-2024
 #
 # SPDX-License-Identifier: MIT
 
@@ -49,6 +49,8 @@ copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
 copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
+copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
 
 copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 6c6d22e..ea267ac 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -43,10 +43,10 @@ modprobe xts
 # this needs to be probed particularly for re-encryption
 modprobe loop
 
-# fixed tpm device or do we need to find it
-tpm_device=/dev/tpmrm0
 partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
+pcr_bank_hash_type="$HASH_TYPE"
+tpm_key_algorithm="$KEY_ALGORITHM"
 if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
@@ -71,6 +71,7 @@ enroll_tpm2_token() {
 		systemd_version=$(systemd-cryptenroll --version | \
 			  awk -F " " 'NR==1{print $2 }')
 		# check systemd version and export password if necessary
+		# systemd version 251 does not suport hash_types
 		if [ "$systemd_version" -ge "251" ]; then
 			PASSWORD=$(cat "$2" )
 			export PASSWORD
@@ -112,6 +113,16 @@ mount_partition() {
 	fi
 }
 
+for candidate in /dev/tpm*; do
+	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
+		continue
+	fi
+	if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet 2>/dev/null; then
+		continue
+	fi
+	tpm_device=$candidate
+done
+
 if [ ! -e "$tpm_device" ]; then
 	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 317ea12..7f732cf 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -11,7 +11,7 @@
 inherit dpkg-raw
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
     awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
-    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs"
+    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs, tpm2-tools"
 
 CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
@@ -49,10 +49,11 @@ CRYPT_SETUP_TIMEOUT ??= "600"
 INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??= "sha256"
-
+CRYPT_KEY_ALGORITHM ??= "ecc"
 
 TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
+    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 
 do_install[cleandirs] += " \
-- 
2.43.0


