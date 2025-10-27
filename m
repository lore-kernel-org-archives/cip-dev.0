Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057CCCF9FF
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.26595.1761549713172996527
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=GylTYknw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202510270721510afa1617720002074e-kh3fgn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202510270721510afa1617720002074e
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=f9xy7ZLHFSj7lN+6OQfJUVDSht184ziVWdbqgC6l1dE=;
 b=GylTYknwB3GrP7FcJOD/Z8Uq5gP7InLOc1lJu7I+i1nH/yPH2y/VlWgcu/M6neSJFfKqVK
 Z4e5Z4abVUjq5BcwO8JuqvA+AfyZEs5GqInhFX7W2kqSdlUA4e03IIVz2ctirnJYe8b8vrVB
 K1eUTZ1TQob2aqESZeYM7+Ki5fOKPAPMozK1xoURccRhVjlV21UU5rTbNe0wkDBGyUv/Y4Sh
 9GSqVcC70a30qaKvW6Irj7sMsd4cdjxHrKtZtRB8b2jPT3nj2Z1vsIkJUDUUMzL8c/rwZc3W
 cv1CJRTBzd/hhwnTcPZOERXq4OSLJuPOzWYGrBfwgI2zo9mOe9uyq7CA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 16/19] start-qemu: Indention fixes
Date: Mon, 27 Oct 2025 08:21:45 +0100
Message-ID: <b8fd9dda37a900963151eb1c595d5e02a54e9d1d.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20226

From: Jan Kiszka <jan.kiszka@siemens.com>

No functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index e8f1cfc3..745c7f56 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -89,11 +89,11 @@ case "${arch}" in
 			-device virtio-net-pci,netdev=net"
 		if [ -n "${SECURE_BOOT}" ]; then
 			# set bootindex=0 to boot disk instead of EFI-shell
-			QEMU_EXTRA_ARGS=" \
-			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk,bootindex=0"
+			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS}  \
+				-device ide-hd,drive=disk,bootindex=0"
 		else
-			QEMU_EXTRA_ARGS=" \
-			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk"
+			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS}  \
+				-device ide-hd,drive=disk"
 		fi
 		KERNEL_CMDLINE=" \
 			root=/dev/sda rw"
@@ -174,9 +174,9 @@ if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
 				;;
 		esac
 		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
-			 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock \
-			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
-			 -device ${TPM_DEVICE},tpmdev=tpm0"
+			-chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock \
+			-tpmdev emulator,id=tpm0,chardev=chrtpm \
+			-device ${TPM2_DEVICE},tpmdev=tpm0"
 	fi
 fi
 
-- 
2.51.0


