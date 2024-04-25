Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DEC10F15
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.14925.1714045884381141412
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ldxkxfPQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024042511512263a7708e98d72c32ba-44runw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024042511512263a7708e98d72c32ba
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wSGIM9utpXQc+BOSSntk+zCS4ugkEp/ywBgOjEElb64=;
 b=ldxkxfPQRrpm92OQEMeNzo4JKM64r/01rnUpBAtfzhoDnHrHPvaFRW4/nRKnud8KOPRJfg
 d9W/R8Pq8T5ewupb8e3ZQRyubDhBpuNmL3v0ilrMs3KxSXZ3ESxi45HzgW67Q5pdpHhUsy/v
 xuF+sDe2PBd/kgL/qfIzb2gq+/y8c=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 6/9] Kconfig: Add option to encrypt the rootfs
Date: Thu, 25 Apr 2024 13:50:34 +0200
Message-ID: <20240425115119.813384-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15758

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to setup a full encrypted system.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                 | 20 ++++++++++++++++++--
 kas/opt/encrypt-all.yml | 23 +++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 kas/opt/encrypt-all.yml

diff --git a/Kconfig b/Kconfig
index 9478a06..42e6b67 100644
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


