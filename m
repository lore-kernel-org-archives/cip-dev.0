Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14119CA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 13:40:53 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.58656.1790602846935336741
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 06:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=sari.sercan@siemens.com header.s=fm1 header.b=DpzoEMNH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1334722-2026092813404286bee44ee60002078b-sgpkuz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026092813404286bee44ee60002078b
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Sep 2026 15:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=sari.sercan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=EnBgEY2wV0XAKLNDKpNXXHAc71ZXdNIgCHH5cY99O+0=;
 b=DpzoEMNHlq/DNJO0c6jGq3HC1tJvoX2EMn+Vs0ADrE9OnAnrj2Azxp1/Hh7tnTB4cy/w9U
 OOwZQg/Q4b+LVgxSpYFS3pdUHunUy1si5kA06/tkqRvQmNvGUHwKskfuWmBNhuXm+YCW9R13
 T8lxTs6ZolMjsrM4SUKuywmRqazPlSmyqlJiRgj9k1DTKgkxnhW58MFNdQSyEh3+D4BS2J1Y
 2eqsNnYVu/HABwEC4Qmv+hFFsKk71Wc91WurhYzYTq7ZyXZeGJjJMY5zEiYnmhCxxMxyz2NS
 QD56ck/GPpPpE2j9X0CWI5//uK8AUJi6Pjyxor+lLuUPlPp3FVPCoazg==;
From: Sercan Sari <sari.sercan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Sercan Sari <sari.sercan@siemens.com>
Subject: [PATCH] initramfs-crypt-hook: emit TPM DA lockout metric
Date: Mon, 28 Sep 2026 15:39:51 +0200
Message-Id: <20260928133951.3500729-1-sari.sercan@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334722:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Sep 2026 13:40:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24367

The TPM dictionary-attack (DA) lockout counter increments on unclean
shutdowns and failed unlock attempts, and eventually locks the TPM.
Its trajectory cannot be observed from the running system without
querying the TPM again.

Emit the DA counters (lockoutCounter, maxAuthFail, lockoutInterval,
inLockout) as a single 'tpm-da:' key=value line to /dev/kmsg after each
unlock attempt, so a rootfs service can track them via journald without
touching the TPM. The metric is emitted on both the success and the
failure path, so a lockout is still reported before the hook panics. A
multi-partition device emits the line once per unlocked partition; the
values are identical, as the DA state is global.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../files/encrypt_partition.clevis.script     |  2 ++
 .../files/encrypt_partition.systemd.script    |  2 ++
 .../initramfs-crypt-hook/files/tpm2_functions | 23 +++++++++++++++++++
 .../files/tpm2_functions.buster               |  5 ++++
 4 files changed, 32 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index ceeacd1..e473dfb 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -16,8 +16,10 @@ open_tpm2_partition() {
 	tpm_device="$3"
 	if ! TPM2TOOLS_TCTI="device:$tpm_device" usr/bin/clevis luks unlock -n "$crypt_mount_name" \
 		 -d "$partition_device"; then
+		tpm2_report_da_metric
 		panic "Can't decrypt '$partition_device' !"
 	fi
+	tpm2_report_da_metric
 }
 
 enroll_tpm2_token() {
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 94346a8..40eeb4d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -15,8 +15,10 @@ open_tpm2_partition() {
 	tpm_device="$3"
 	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
 		 "$partition_device" - tpm2-device="$tpm_device"; then
+		tpm2_report_da_metric
 		panic "Can't decrypt '$partition_device' !"
 	fi
+	tpm2_report_da_metric
 }
 
 enroll_tpm2_token() {
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
index 1c6bbff..20ece43 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -65,3 +65,26 @@ tpm2_key_get() {
 tpm2_key_del() {
 	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
 }
+
+# Extract a TPM2_PT_<name> property value from "$da"
+tpm2_da_prop() {
+	echo "$da" | awk -v k="TPM2_PT_$1:" '
+		$1 == k { if (NF > 1) { print $NF; exit } f = 1; next }
+		f && /0x/ { print $NF; exit }'
+}
+
+# Read the dictionary-attack counters into globals.
+tpm2_read_da() {
+	da="$(tpm2_getcap -T "device:${tpm_device}" properties-variable 2>/dev/null)"
+	da_counter="$(tpm2_da_prop LOCKOUT_COUNTER)"
+	da_maxfail="$(tpm2_da_prop MAX_AUTH_FAIL)"
+	da_interval="$(tpm2_da_prop LOCKOUT_INTERVAL)"
+	da_inlockout="$(echo "$da" | sed -n 's/.*inLockout:[[:space:]]*\([0-9]\).*/\1/p')"
+}
+
+# Emit the DA counters to the kernel log so a rootfs service can track them.
+tpm2_report_da_metric() {
+	tpm2_read_da
+	echo "tpm-da: counter=${da_counter:-?} maxfail=${da_maxfail:-?} interval=${da_interval:-?} inlockout=${da_inlockout:-?}" \
+		> /dev/kmsg 2>/dev/null || true
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
index 453ba97..09338ef 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
@@ -22,3 +22,8 @@ tpm2_key_get() {
 
 tpm2_key_del() {
 }
+
+# tpm2_getcap is not in the buster initramfs, so no DA metric is emitted.
+tpm2_report_da_metric() {
+	:
+}
-- 
2.39.5


