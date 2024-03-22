Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D344ACD1281
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.9306.1711101969112874513
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ObW+R2ky;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024032210060718b142d306b8e7546e-xe0s2e@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024032210060718b142d306b8e7546e
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MiUaZV9PYjaEbSBNv/R1ZRB6xdJrJYtGkBVB4cwwb9c=;
 b=ObW+R2kyx/h6l3hTBY3nCoIvMq97eHZJMHRyXt4G8iTD+H+H339CxHe05XTXc3eBcL4RDs
 Bmz4CQKb/C+ZJSkwHA7Pqlbko0Lu5eWlA0oRi5k882nY1r0cR5UzGRsfFtLeERfyFfVh5jpo
 M5pVWN0Bl17Hr17cU4i8RdvzKqU9I=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 05/13] initramfs-crypt-hook: add flag to make encryption optional
Date: Fri, 22 Mar 2024 11:05:15 +0100
Message-ID: <20240322100605.4129226-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15403

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to use same image on devices with and without TPM.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.script     | 20 ++++++++++++++++++-
 .../files/encrypt_partition.env.tmpl          |  1 +
 .../files/encrypt_partition.systemd.script    | 20 ++++++++++++++++++-
 .../initramfs-crypt-hook_0.1.bb               |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 8de8015..e0fcbf4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -47,6 +47,7 @@ partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
 pcr_bank_hash_type="$HASH_TYPE"
 tpm_key_algorithm="$KEY_ALGORITHM"
+tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
 if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
@@ -121,7 +122,24 @@ for candidate in /dev/tpm*; do
 done
 
 if [ ! -e "$tpm_device" ]; then
-	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
+	if [ "$tpm_encryption_optional" = "true" ]; then
+		echo "No tpm_device exists abort optional encryption"
+		for partition_set in $partition_sets; do
+			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
+			partition=/dev/disk/by-partlabel/"$partition_label"
+			case "${partition_format}" in
+			"reencrypt")
+				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
+				;;
+			*)
+				echo "cannot mount partition '$partition' as it is marked for formatting."
+			esac
+		done
+		exit 0
+	fi
+	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
 fi
 
 # clevis needs /dev/fd create it in the initramfs
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index 5d28dc5..bb93361 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -4,3 +4,4 @@ SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
 WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE="${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
+ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index ea267ac..48ce999 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -47,6 +47,7 @@ partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
 pcr_bank_hash_type="$HASH_TYPE"
 tpm_key_algorithm="$KEY_ALGORITHM"
+tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
 if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
@@ -124,7 +125,24 @@ for candidate in /dev/tpm*; do
 done
 
 if [ ! -e "$tpm_device" ]; then
-	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
+	if [ "$tpm_encryption_optional" = "true" ]; then
+		echo "No tpm_device exists abort optional encryption"
+		for partition_set in $partition_sets; do
+			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
+			partition=/dev/disk/by-partlabel/"$partition_label"
+			case "${partition_format}" in
+			"reencrypt")
+				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
+				;;
+			*)
+				echo "cannot mount partition '$partition' as it is marked for formatting."
+			esac
+		done
+		exit 0
+	fi
+	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
 fi
 
 for partition_set in $partition_sets; do
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 7f732cf..54c91fd 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -50,6 +50,7 @@ INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??= "sha256"
 CRYPT_KEY_ALGORITHM ??= "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??= "false"
 
 TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
-- 
2.43.0


