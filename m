Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D714E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 11:45:20 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.35073.1733485519036161888
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 03:45:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=kaWYzDCK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1326448-202412061145167c47e84420df6c3cd5-oxnsbk@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202412061145167c47e84420df6c3cd5
        for <cip-dev@lists.cip-project.org>;
        Fri, 06 Dec 2024 12:45:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=v2XN4ohKSB38flon8F0G6hA5OMvmn3YI717fLZ5tZSQ=;
 b=kaWYzDCK+FWeJMsyiQbGdJiXufoLnTaHQI9YseBvnkJHNv+bRS9FcUiFartrRk3T3SW06q
 Qp6mrBQKISY6jE1/r1BnaxwCCYQkDXrVCaMR03yJSZqjjczZg4v5Kj8jLU16raW35IboUFEl
 7DwsJLdjExRnBVPtViJZR6k1TGMYq00/pi4SidQl3cUUV1tFBgbFI8xTpSF41lqu5bzzkFnY
 Vx1IuXYn1xmRkS0isb7eqHsnZ2ckXdTADZlGRLE9JcmtjIfP0HeWBxzrTCm9GABf1HpZcfAG
 9pKaUxFDt5glHH8J2cky6XA0XiW48QwpTJkY7KUuQA98b9fVfMXnWNZg==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com
Cc: fabian.blaese@siemens-healthineers.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] Seal tpm key for disk encryption using PCR11.
Date: Fri,  6 Dec 2024 12:44:43 +0100
Message-ID: <20241206114443.64042-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 11:45:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17364

From: Alexander Heinisch <alexander.heinisch@siemens.com>

The recently introduced sealing of the tpm key for disk encryption
was bound to PCR7 only. Since PCR[0-7] are exclusively for use in
platform firmware I switched to seal the key after cryptsetup by
modifying PCR11. PCR11 was chosen because of a similar approach
in systemd where the actual state of the initramfs is reflected.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../files/encrypt_partition.clevis.script           | 12 +++++++++++-
 .../files/encrypt_partition.systemd.script          | 13 ++++++++++++-
 .../initramfs-crypt-hook/files/local-top-complete   |  8 ++++----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index ceeacd1..b63dd94 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -27,7 +27,7 @@ enroll_tpm2_token() {
 	tpm_key_algorithm="$4"
 	pcr_bank_hash_type="$5"
 	if [ -x /usr/bin/clevis ]; then
-		TPM2TOOLS_TCTI="device:$tpm_device" clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
+		TPM2TOOLS_TCTI="device:$tpm_device" clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7,11"}' < "$passphrase"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
@@ -44,3 +44,13 @@ finalize_tpm2_encryption() {
 	partition_device="$1"
 	cryptsetup -v luksKillSlot -q  "$partition_device" 0
 }
+
+# invalidate PCR11 to lock access to the disk keys
+invalidate_pcr11() {
+    pcr_bank_hash_type="$1"
+
+    # generate a hash digest based on desired pcr_bank_hash_type
+    hash_digest_extend=$(echo "leaving-initramfs-crypt-hook" | eval "openssl dgst -$pcr_bank_hash_type" | sed "s/.*= //")
+    # invalidate PCR11 to lock access to the disk keys
+    tpm2_pcrextend 11:"$pcr_bank_hash_type"="$hash_digest_extend"
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 1b7c83b..24b4d69 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -36,7 +36,7 @@ enroll_tpm2_token() {
 			PASSWORD=$(cat "$passphrase" )
 			export PASSWORD
 			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
-				 --tpm2-pcrs=7 "$partition_device"
+				 --tpm2-pcrs=7+11 "$partition_device"
 			PASSWORD=
 		else
 			panic "Unknown systemd version: '$systemd_version'!"
@@ -55,3 +55,14 @@ finalize_tpm2_encryption() {
 	/usr/bin/systemd-cryptenroll --wipe-slot=0 "$partition_device"
 }
 
+# invalidate PCR11 to lock access to the disk keys
+invalidate_pcr11() {
+    #pcr_bank_hash_type="$1"
+
+    # systemd-cryptenroll in version 252 always uses
+    # sha256 as preferred pcr bank hash type
+    # and sha1 as a fallback if nothing else exists
+
+    # generate a hash digest for sha1 and sha256 (input was "leaving-initramfs-crypt-hook")
+    tpm2_pcrextend 11:sha1=d57309e7907cb50d96b8436eaea074e4204eca86,sha256=12e47e8ce6b0bf565fe88691356de4be41d834c5eb620879d086b9fd9a5b2d6e
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 4bcb427..4f71b92 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -155,12 +155,12 @@ expand_partition() {
 
 for candidate in /dev/tpm*; do
 	if [ -x /usr/bin/tpm2_pcrread ]; then
-		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
+		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7,11 --quiet ; then
 			continue
 		fi
 	elif [ -x /usr/bin/tpm2_pcrlist ]; then
 		export TPM2TOOLS_DEVICE_FILE="$candidate"
-		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7 > /dev/null; then
+		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7,11 > /dev/null; then
 			continue
 		fi
 	fi
@@ -258,8 +258,8 @@ for partition_set in $partition_sets; do
 	finalize_tpm2_encryption "$part_device"
 done
 
-# invalidate PCR7 to lock access to the disk keys
-tpm2_pcrextend 7:sha1=1111111111111111111111111111111111111111,sha256=1111111111111111111111111111111111111111111111111111111111111111
+# invalidate PCR11 to lock access to the disk keys
+invalidate_pcr11 "$pcr_bank_hash_type"
 
 if [ -n "$watchdog_pid" ]; then
 	kill "$watchdog_pid"
-- 
2.43.0


