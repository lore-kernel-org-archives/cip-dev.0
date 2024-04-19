Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA1C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:49 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.15329.1713514840325071654
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=A3qgsZzB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2024041908203866a0a2681b56b3bc9e-qsnngi@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024041908203866a0a2681b56b3bc9e
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5zqUFGjfP/UY6eD/GxL8mn5lg+GPrDsbD+doLNjTEIY=;
 b=A3qgsZzBvvhCInh7gyVIPLg0Cv2VMcCytzFqrU3yhT9qFxtUTTLpn7TxcHCSsIKWL2W4Vk
 SbagbvXT2xAV2y71kHAl8CHCtoZiMtnfzC82C/t5JFmhujbWkRn8piV9jtZZmPD0OkIk0mrY
 ZHEkCI3w/OAI0nZ8nZEMD4WKOs9jw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 6/7] Kconfig: Add option to encrypt the rootfs
Date: Fri, 19 Apr 2024 10:20:16 +0200
Message-ID: <20240419082036.2389583-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15644

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                    | 20 ++++++++++++++++++--
 kas/opt/encrypt-rootfs.yml | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 kas/opt/encrypt-rootfs.yml

diff --git a/Kconfig b/Kconfig
index 7c19640..e657a22 100644
--- a/Kconfig
+++ b/Kconfig
@@ -202,15 +202,31 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
 	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
+
+menuconfig DISK_ENCRYPTION
+	bool
+	prompt "disk encryption"
+	select IMAGE_SECURE_BOOT
+
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
-	select IMAGE_SECURE_BOOT
+	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
 
+config IMAGE_FULL_ENCRYPTION
+	bool "Encrypt rootfs and data partitions"
+	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
+	select IMAGE_DATA_ENCRYPTION
+	help
+	  This enables LUKS encryption for all partitions.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
 
+config KAS_INCLUDE_ROOTFS_ENCRYPTION
+	string
+	default "kas/opt/encrypt-rootfs.yml" if IMAGE_FULL_ENCRYPTION
+
 endif
diff --git a/kas/opt/encrypt-rootfs.yml b/kas/opt/encrypt-rootfs.yml
new file mode 100644
index 0000000..f273b65
--- /dev/null
+++ b/kas/opt/encrypt-rootfs.yml
@@ -0,0 +1,22 @@
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
+    - kas/opt/encrypt-partitions.yml
+local_conf_header:
+  encrypted_root: |
+    # Do not set mount points for systema and systemb as they are mounted by the
+    # abrootfs/verity initramfs
+    # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
+    # to set all partitions
+    CRYPT_PARTITIONS:append = "systema::reencrypt systemb::reencrypt home:/home:reencrypt var:/var:rueencrypt"
-- 
2.43.0


