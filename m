Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D66AC36002
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 07:43:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2369.1742456600861965255
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 00:43:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TbIn6Qf9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F17DE101E90E2;
	Thu, 20 Mar 2025 08:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742456599; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MSeL0XQp5SDliXMCLkr6D0ZYViPoiJgR5HA5ZuJHgRA=;
	b=TbIn6Qf9FEB+WQE6d72BqdXZyv9yruVedN3/RXaOuLqy2lunrcEPimYiccC/5cfSLCawRI
	mCdIfXj8qmSQxOF/Gp50PI6shnIR7ddcAAEoKrkaFfyLlY/tMcJ+z0wmTsFvE8FGuBl/Uc
	a9+E2pw97AqIhkq7Bl06+NfNCOsk9FbPNAahkxwpvw4TyunK6/1c6bktFyQUNt8XrRApp+
	r/pU/xlCgXyvzM284fUR56Ig9L59oL2IOO5KcCSHbSEHCFlNmqMJVRjKKfJkjbNKVJs2b/
	PR5AhNyk1cdnWObUvgmRIy/NFSLvXyn0E0Intf8JgyTDryTXencsE3qxn49CwQ==
From: Claudius Heine <ch@denx.de>
Date: Thu, 20 Mar 2025 08:43:05 +0100
Subject: [PATCH v6 1/4] initramfs-crypt-hook: store initial encryption key
 in TPM2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-initramfs-crypt-hook-patches-2-v6-1-ef10c11cad94@denx.de>
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
In-Reply-To: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Alexander <alexander.heinisch@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 07:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18284

cryptsetup and systemd-cryptenroll do not currently support encrypting
partitions directly with keys stored in the TPM. For that reason a
temporary random password is used for the initial encryption, which will
get removed once the TPM2 token is added to the partition.

However this process does not allow continuing with the encryption
process in case of power failure.

For that reason store the initial encryption password in the TPM,
protected via measured boot based on the TPM2-PCR:7 register, which is
the default for `systemd-cryptenroll` and load it if it exists.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 .../initramfs-crypt-hook/files/local-top-complete  | 56 ++++++++++++++++++++--
 .../initramfs-crypt-hook_0.7.bb                    | 12 ++---
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index ae0dcef4cb62a135beb6d4229237144b6d4edf8b..e511e8ef2d0bd4f4c8fd2fca248312dee173d224 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
 	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
 fi
 
+export TPM2TOOLS_TCTI="device:${tpm_device}"
+TPM2_HANDLE="0x81080001"
+tpm2_key_get() {
+	key_file="$1"
+	TPM2_WORKDIR="/tmp/tpm2"
+
+	if ! tpm2_getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
+		mkdir -p "${TPM2_WORKDIR}"
+		# Open session:
+		tpm2_startauthsession -S "${TPM2_WORKDIR}/session.ctx"
+		tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
+			-l "${HASH_TYPE}:7" \
+			-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
+		tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+
+		# Add new key to tpm:
+		tpm2_createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
+		echo "$(tr -dc 'A-Za-z0-9_' </dev/urandom | head -c 32)" | \
+			tpm2_create -Q -g "sha256" \
+				-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
+				-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
+				-i- \
+				-C "${TPM2_WORKDIR}/prim.ctx" \
+				-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
+		tpm2_load -Q \
+			-C "${TPM2_WORKDIR}/prim.ctx" \
+			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
+			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
+			-n "${TPM2_WORKDIR}/pcr_seal_key.name" \
+			-c "${TPM2_WORKDIR}/pcr_seal_key.ctx"
+		tpm2_evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
+			"$TPM2_HANDLE" -C o
+
+		rm -rf "${TPM2_WORKDIR}"
+	fi
+
+	mkdir -p "${TPM2_WORKDIR}"
+	tpm2_startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx"
+	tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" -l "${HASH_TYPE}:7"
+	tpm2_unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE" >"$key_file"
+	tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
+	rm -rf "${TPM2_WORKDIR}"
+}
+
+tpm2_key_del() {
+	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
+}
+
 prepare_for_encryption
 
 for partition_set in $partition_sets; do
@@ -259,16 +307,17 @@ for partition_set in $partition_sets; do
 		watchdog_pid=$!
 	fi
 
-	# create random password for initial encryption
-	# this will be dropped after reboot
+	# create random password, store it in the tpm2 encrypted and protected with
+	# PCR:7 registers to allow continuing reencryption in case of power-failure.
 	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
+	tpm2_key_get "${tmp_key}"
 
 	case "${partition_format}" in
 		"reencrypt")
 			log_begin_msg "Encryption of ${part_device}"
 			reencrypt_existing_partition "$part_device" "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+			tpm2_key_del
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			log_end_msg
 		;;
@@ -277,6 +326,7 @@ for partition_set in $partition_sets; do
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$part_device" < "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+			tpm2_key_del
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 			log_end_msg
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
index 80a4755e4e0acfc96bb2d0f8e175e2787473e384..cde6582fe07981c78d646fe592e0c53ef46a2fb4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
@@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
 DEBIAN_DEPENDS .= ", \
     cryptsetup, \
     awk, \
-    openssl, \
     e2fsprogs, \
     tpm2-tools, \
     coreutils, \
@@ -40,19 +39,20 @@ HOOK_ADD_MODULES = " \
     ecb aes_generic xts"
 
 HOOK_COPY_EXECS = " \
-    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
-    e2fsck resize2fs cryptsetup \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
+    e2fsck resize2fs cryptsetup head tr rm \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession \
+    tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictcontrol \
+    tpm2_unseal tpm2_getcap \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
     clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
     clevis-luks-bind clevis-luks-unlock \
     clevis-luks-list clevis-luks-common-functions \
-    tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpolicy \
     bash luksmeta jose sed tail sort rm mktemp pwmake file"
 HOOK_COPY_EXECS:append:systemd = " \
-    systemd-cryptenroll tpm2_pcrread tpm2_testparms \
+    systemd-cryptenroll \
     /usr/lib/systemd/systemd-cryptsetup \
     /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
 

-- 
2.49.0


