Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBAC83F0A
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.55696.1751879784132700555
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=jbl8Hc69;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2025070709162112922b42d7cfa23503-mf_k25@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025070709162112922b42d7cfa23503
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=S+32MKoAq4v2qQCz19K1a370dpcFvpjLPUpaRZG66xg=;
 b=jbl8Hc69k9Znzj4nXoEdBR2BWQ2O/cFqhlI/D3V/4kgRak0JlIol6NPAkduwwiXWT4upCi
 +VfKB5vg2nWlkRGk1uwAw8zt2vtfJxtMd6XiZYzbeCXrnNsJ4qzQDHLw6L3XPRS+CnAVBwhe
 p63Rt08Du0Jx5OXc/z0+R8vkpq4Wbq2W1nwHbT137ouSpPU7buchG6zTY4w3JB44pnxAVqmP
 ze/0Jzp+XLP+K7b53GePWaYf5ZrCiQWcd3Kx+kv3jYRa1+kFThmitJknf+pUYYmSf6NH6s5c
 +ImUAeoAZV59eCnmuLMQosKZLLwTBSnTtgS+S8xDGbWVzi9Cv4lqFFFw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 5/8] initramfs-crypt-hook: store initial encryption key in TPM2
Date: Mon,  7 Jul 2025 11:16:17 +0200
Message-ID: <70b0bec21021bb0ba93b039fe4487e08c4fd244e.1751879779.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19371

From: Claudius Heine <ch@denx.de>

cryptsetup and systemd-cryptenroll do not currently support encrypting
partitions directly with keys stored in the TPM. For that reason a
temporary random password is used for the initial encryption, which will
get removed once the TPM2 token is added to the partition.

However this process does not allow continuing with the encryption
process in case of power failure.

For that reason store the initial encryption password in the TPM,
protected via measured boot based on the TPM2-PCR:7 register, which is
the default for `systemd-cryptenroll` and load it if it exists.

We only provide this for bullseye and newer because tpm2-tools version
3.x as provided with buster makes it impractical to support this
feature.

Signed-off-by: Claudius Heine <ch@denx.de>
[Jan: rebased, added buster stubs]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/local-top-complete                  |  8 +--
 .../initramfs-crypt-hook/files/tpm2_functions | 51 +++++++++++++++++++
 .../files/tpm2_functions.buster               |  9 ++++
 .../initramfs-crypt-hook_0.9.bb               |  7 ++-
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index f6d08467..6d5feda8 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -247,16 +247,17 @@ for partition_set in $partition_sets; do
 		watchdog_pid=$!
 	fi
 
-	# create random password for initial encryption
-	# this will be dropped after reboot
+	# Create random password, store it in the tpm2, sealed via PCR:7,
+	# to allow continuing reencryption in case of power-failure.
 	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
-	pwgen -s -1 32 > "$tmp_key"
+	tpm2_key_get "$tmp_key"
 
 	case "${partition_format}" in
 		"reencrypt")
 			log_begin_msg "Encryption of ${part_device}"
 			reencrypt_existing_partition "$part_device" "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+			tpm2_key_del
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			log_end_msg
 		;;
@@ -265,6 +266,7 @@ for partition_set in $partition_sets; do
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$part_device" < "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+			tpm2_key_del
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 			log_end_msg
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
index cd941e04..01a4003c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -5,6 +5,7 @@
 # Copyright (c) Siemens AG, 2025
 #
 # Authors:
+#  Claudius Heine <ch@denx.de>
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
@@ -13,3 +14,53 @@ tpm2_check_device() {
 	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet &&
 		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet
 }
+
+TPM2_HANDLE="0x81080001"
+
+tpm2_key_get() {
+	key_file="$1"
+	TPM2_WORKDIR="/tmp/tpm2"
+
+	export TPM2TOOLS_TCTI="device:${tpm_device}"
+
+	if ! tpm2_getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
+		mkdir -p "${TPM2_WORKDIR}"
+		# Open session:
+		tpm2_startauthsession -S "${TPM2_WORKDIR}/session.ctx"
+		tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
+			-l "${pcr_bank_hash_type}:7" \
+			-L "${TPM2_WORKDIR}/pcr7.${pcr_bank_hash_type}.policy"
+		tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+
+		# Add new key to tpm:
+		tpm2_createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
+		pwgen -s -1 32 | tpm2_create -Q -g sha256 \
+			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
+			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
+			-i - \
+			-C "${TPM2_WORKDIR}/prim.ctx" \
+			-L "${TPM2_WORKDIR}/pcr7.${pcr_bank_hash_type}.policy"
+		tpm2_load -Q \
+			-C "${TPM2_WORKDIR}/prim.ctx" \
+			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
+			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
+			-c "${TPM2_WORKDIR}/pcr_seal_key.ctx"
+		tpm2_evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
+			"$TPM2_HANDLE" -C o
+
+		rm -rf "${TPM2_WORKDIR}"
+	fi
+
+	mkdir -p "${TPM2_WORKDIR}"
+	tpm2_startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx"
+	tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
+		-l "${pcr_bank_hash_type}:7"
+	tpm2_unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE" \
+		-o "$key_file"
+	tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+	rm -rf "${TPM2_WORKDIR}"
+}
+
+tpm2_key_del() {
+	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
index 31bb1620..453ba977 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
@@ -13,3 +13,12 @@ tpm2_check_device() {
 	export TPM2TOOLS_DEVICE_FILE="$1"
 	tpm2_pcrlist -L "${pcr_bank_hash_type}:7" > /dev/null
 }
+
+tpm2_key_get() {
+	# key persistence not supported with buster
+	key_file="$1"
+	pwgen -s -1 32 > $key_file
+}
+
+tpm2_key_del() {
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index 91b9aeb4..f85d3ec6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -44,15 +44,17 @@ HOOK_ADD_MODULES = " \
 
 HOOK_COPY_EXECS = " \
     pwgen mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
-    e2fsck resize2fs cryptsetup \
+    e2fsck resize2fs cryptsetup rm \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
+    tpm2_startauthsession tpm2_policypcr tpm2_createprimary tpm2_create \
+    tpm2_load tpm2_evictcontrol tpm2_unseal tpm2_getcap \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
     clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
     clevis-luks-bind clevis-luks-unlock \
     clevis-luks-list clevis-luks-common-functions \
-    tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpolicy \
+    tpm2_createpolicy \
     bash luksmeta jose sed tail sort rm mktemp pwmake file"
 HOOK_COPY_EXECS:append:systemd = " \
     systemd-cryptenroll /usr/lib/systemd/systemd-cryptsetup \
@@ -61,6 +63,7 @@ HOOK_COPY_EXECS:append:systemd = " \
 HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
 HOOK_COPY_EXECS:remove:buster = " \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
+    tpm2_startauthsession tpm2_policypcr tpm2_evictcontrol tpm2_getcap \
     clevis-luks-list clevis-luks-common-functions"
 HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
 
-- 
2.43.0


