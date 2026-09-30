Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F30CA5FC5
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 14:01:03 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14146.1790776854824905719
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 07:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=sari.sercan@siemens.com header.s=fm1 header.b=AAQN7bV1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1334722-2026093014004489e44805e0000207d5-6hbgy4@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026093014004489e44805e0000207d5
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Sep 2026 16:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=sari.sercan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UD8wq44k3AizZ+fy4WoqpO8Rgur5DeeJtI8AfrKeopc=;
 b=AAQN7bV1euImCND60zjMLZejBexX2Ibz34yMTaOC4LR3TEdZgeDkH8qi8lnq/9Iw1Z4MLx
 wU1UQiNfyKYmUEB/4KWW0jpnowURDkRNfbn6JNS9Yv/DDS5H1dJx+5l7K6ToB2LYOPf6Pk0w
 mz14riF6Kqlx/R/GiY7CX307AYnmGOTubpUeKHs5F5Z2ZYSEru23oLgije5q/rXOgDIZ+aQG
 jk9oOBVIKNCSCLT2GHRzeEsLx5KSTgzS18ho94npa3XBnktwlS0mSCr21MoIvq73Id6pRxaj
 +zU0t3tTelclj/RFzfflo6+p2nQQbwPCAWaucefg7bbuSRqfFzu0noGg==;
From: Sercan Sari <sari.sercan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sercan Sari <sari.sercan@siemens.com>
Subject: [PATCH v2] initramfs-crypt-hook: emit TPM DA lockout metric
Date: Wed, 30 Sep 2026 16:00:29 +0200
Message-Id: <20260930140029.3767397-1-sari.sercan@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334722:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 14:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24379

The TPM dictionary-attack (DA) lockout counter increments on unclean
shutdowns and failed unlock attempts, and eventually locks the TPM.
Its trajectory cannot be observed from the running system without
querying the TPM again.

After each unlock attempt, when the lockout counter is non-zero, emit
the DA counters (lockoutCounter, maxAuthFail, lockoutInterval,
inLockout) as a single 'tpm-da:' key=value line to /dev/kmsg, so a
rootfs service can track them via journald without touching the TPM.
The metric is emitted on both the success and the failure path, so a
lockout is still reported before the hook panics.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
Changes since v1:
- Emit only when the lockout counter is non-zero, to keep the healthy
  case silent.
- Emit at most once per TPM device instead of once per unlocked
  partition.
- Pass the capability dump to tpm2_da_prop as an argument instead of a
  global, and fold the former tpm2_read_da helper into the caller.

 .../files/encrypt_partition.clevis.script     |  2 ++
 .../files/encrypt_partition.systemd.script    |  2 ++
 .../initramfs-crypt-hook/files/tpm2_functions | 21 +++++++++++++++++++
 .../files/tpm2_functions.buster               |  5 +++++
 4 files changed, 30 insertions(+)

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
index 1c6bbff..d88da5b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -65,3 +65,24 @@ tpm2_key_get() {
 tpm2_key_del() {
 	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
 }
+
+# Extract a TPM2_PT_<name> property value from the capability dump in $2
+tpm2_da_prop() {
+	echo "$2" | awk -v k="TPM2_PT_$1:" '
+		$1 == k { if (NF > 1) { print $NF; exit } f = 1; next }
+		f && /0x/ { print $NF; exit }'
+}
+
+# Emit the DA counters to the kernel log when the lockout counter is non-zero, once per TPM device.
+tpm2_report_da_metric() {
+	case " $tpm2_da_reported " in *" $tpm_device "*) return ;; esac
+	da="$(tpm2_getcap -T "device:${tpm_device}" properties-variable 2>/dev/null)"
+	da_counter="$(tpm2_da_prop LOCKOUT_COUNTER "$da")"
+	case "$da_counter" in ""|0x0|0) return ;; esac
+	tpm2_da_reported="$tpm2_da_reported $tpm_device"
+	da_maxfail="$(tpm2_da_prop MAX_AUTH_FAIL "$da")"
+	da_interval="$(tpm2_da_prop LOCKOUT_INTERVAL "$da")"
+	da_inlockout="$(echo "$da" | sed -n 's/.*inLockout:[[:space:]]*\([0-9]\).*/\1/p')"
+	echo "tpm-da: counter=${da_counter} maxfail=${da_maxfail:-?} interval=${da_interval:-?} inlockout=${da_inlockout:-?}" \
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


