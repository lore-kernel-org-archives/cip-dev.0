Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB43C83F14
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.56253.1751879784292613939
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UXNGci6E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202507070916217b9febfba2ef639830-bitm22@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202507070916217b9febfba2ef639830
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nOdm4atpODEpcTKQowO+NnAVZKLgLDpgf7dmG+bALZ0=;
 b=UXNGci6EMH1oHwGu4ooE4Tu9oEVT3q7vd8QwsavCUx5udAPXSPexB8L7zh4J3z6QwzuAmr
 9kKJrUG5yxLWVKe8IJH4dMnKn0V2c/qzXdsN7UwcyBqaQj6Snh0031+0MRCi66gFZLnuuL3d
 IBukWU5m7M4uBwuA/UP8ovrKVqKWE3UTuzlO3WkfBi/TiIP77DcC7xpHF8wBc/yyhQQZvrOl
 CycGrdcGEQyVzqqhHyGqEoxZ7wDzUqhlJnHcSiNQUyJeSiyI6PSr3+bIf5e11eMGWTrS/V+j
 ZkdWJK+nfWAmUaS2HwekD++pY5dTwmB+3jtrOIo6J668yzAxstPqVkfA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 4/8] initramfs-crypt-hook: Factor out tpm2_functions script
Date: Mon,  7 Jul 2025 11:16:16 +0200
Message-ID: <3d61a646d85b0a23bbfd17e6641510a18efd84a8.1751879779.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19372

From: Jan Kiszka <jan.kiszka@siemens.com>

This is supposed to handle differences of tpm2-tools version 3 as found
in buster. We start with the tpm discovery. Later on, persistence of the
initial passphrase will be added.

Note that we intentionally do not stop the search after the first hit in
order to remain backward-compatible with older versions of the hook.
This means we will continue to pick the last working tpm device in case
there are more than one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/hook           |  3 ++-
 .../files/local-top-complete                  | 20 ++++---------------
 .../initramfs-crypt-hook/files/tpm2_functions | 15 ++++++++++++++
 .../files/tpm2_functions.buster               | 15 ++++++++++++++
 .../initramfs-crypt-hook_0.9.bb               |  6 ++++++
 5 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/hook b/recipes-initramfs/initramfs-crypt-hook/files/hook
index 1e64f624..dacaa235 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/hook
@@ -1,4 +1,4 @@
-# Copyright (C) Siemens AG, 2020-2024
+# Copyright (C) Siemens AG, 2020-2025
 #
 # SPDX-License-Identifier: MIT
 
@@ -8,4 +8,5 @@ done
 
 copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
 copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
+copy_file library /usr/share/encrypt_partition/tpm2_functions /usr/share/encrypt_partition/tpm2_functions
 copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index c5d5b85a..f6d08467 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -38,6 +38,8 @@ esac
 
 # get the implementation
 . /usr/share/encrypt_partition/encrypt_partition_tpm2
+. /usr/share/encrypt_partition/tpm2_functions
+
 # load necessary kernel modules:
 modprobe tpm_tis
 modprobe tpm_crb
@@ -189,23 +191,9 @@ expand_partition() {
 }
 
 for candidate in /dev/tpmrm*; do
-	if [ -x /usr/bin/tpm2_pcrread ]; then
-		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
-			continue
-		fi
-	elif [ -x /usr/bin/tpm2_pcrlist ]; then
-		export TPM2TOOLS_DEVICE_FILE="$candidate"
-		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7 > /dev/null; then
-			continue
-		fi
-	fi
-	# Debian buster does not have tpm_testparms
-	if [ -x /usr/bin/tpm2_testparms ]; then
-		if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet; then
-			continue
-		fi
+	if tpm2_check_device "$candidate"; then
+		tpm_device=$candidate
 	fi
-	tpm_device=$candidate
 done
 
 if [ ! -e "$tpm_device" ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
new file mode 100644
index 00000000..cd941e04
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -0,0 +1,15 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+tpm2_check_device() {
+	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet &&
+		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
new file mode 100644
index 00000000..31bb1620
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
@@ -0,0 +1,15 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+tpm2_check_device() {
+	export TPM2TOOLS_DEVICE_FILE="$1"
+	tpm2_pcrlist -L "${pcr_bank_hash_type}:7" > /dev/null
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index 5073af47..91b9aeb4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -24,6 +24,9 @@ CRYPT_BACKEND:buster = "clevis"
 CRYPT_BACKEND:bullseye = "clevis"
 CRYPT_BACKEND ?= "systemd"
 
+TPM2_FUNCTIONS = "tpm2_functions"
+TPM2_FUNCTIONS:buster = "tpm2_functions.buster"
+
 OVERRIDES .= ":${CRYPT_BACKEND}"
 
 DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
@@ -64,6 +67,7 @@ HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
 SRC_URI += "file://encrypt_partition.env.tmpl \
             file://local-top-complete \
             file://encrypt_partition.${CRYPT_BACKEND}.script \
+            file://${TPM2_FUNCTIONS} \
             file://local-bottom-complete \
             file://hook \
             file://pwquality.conf"
@@ -103,4 +107,6 @@ do_install:prepend() {
     install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
         "${D}/usr/share/encrypt_partition/encrypt_partition_tpm2"
+    install -m 0755 "${WORKDIR}/${TPM2_FUNCTIONS}" \
+        "${D}/usr/share/encrypt_partition/tpm2_functions"
 }
-- 
2.43.0


