Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E3C25B79
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:45 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.21763.1715005117832761127
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=nf6ioPZI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202405061418366366fae671effd22ed-pb8w0l@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202405061418366366fae671effd22ed
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZvAzp5y8U9Ed9hS3bWdMCTksPqG7pH/6Huv2kTDEWMg=;
 b=nf6ioPZIOfJEYPXIkOVZG4nSFYkHo9qFB6QyJ35SjUHgBcwnPVCPYqNjVVFHkxmJWKDSwk
 /Dwmqoq5MX6uTTxoBgqRw50W8DDfd2ARzLaWzbX4ebSt4fRCndgSoPAJ3ESibxZUzI3bAi4z
 SD+2MxRz9FcrF/caC/iab/LtBxjhM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 06/11] Kconfig: Add option to encrypt the rootfs
Date: Mon,  6 May 2024 16:17:27 +0200
Message-ID: <20240506141833.3622989-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15831

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to setup a system with all non-boot partitions encrypted.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                 | 14 +++++++++++++-
 kas/opt/encrypt-all.yml | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/encrypt-all.yml

diff --git a/Kconfig b/Kconfig
index 9478a06..dd41a2d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -205,12 +205,24 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
-	select IMAGE_SECURE_BOOT
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
 
+config IMAGE_FULL_ENCRYPTION
+	bool "Encrypt rootfs and data partitions"
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	select IMAGE_DATA_ENCRYPTION
+	help
+	  This enables LUKS encryption for all non-boot partitions on first boot.
+	  If the partitions contain secrets the first boot must occur in a secure
+	  location.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
 
+config KAS_INCLUDE_FULL_ENCRYPTION
+	string
+	default "kas/opt/encrypt-all.yml" if IMAGE_FULL_ENCRYPTION
+
 endif
diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
new file mode 100644
index 0000000..b6d4041
--- /dev/null
+++ b/kas/opt/encrypt-all.yml
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+  includes:
+    - kas/opt/encrypt-data.yml
+local_conf_header:
+  encrypted_root: |
+    # Do not set mount points for systema and systemb as they are mounted by the
+    # abrootfs/verity initramfs
+    # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
+    # to set all partitions
+    CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
+                         home:/home:reencrypt var:/var:reencrypt"
-- 
2.43.0


