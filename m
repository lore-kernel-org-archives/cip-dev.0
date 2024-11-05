Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4025D31775
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:43 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.26677.1730829277381153731
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=berUyGEk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20241105175434c51c527c81c24e7ee9-tuskj4@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241105175434c51c527c81c24e7ee9
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vBYcazKv1rot7s1PkcKNQ7wnLUdoeBObFtZTwQ7MZEY=;
 b=berUyGEkKsy1fYjM/NJdrquSDB1nJohnfuGvfALOY0QCKL1sLaxngLyvAu9IFd96X28geB
 47gYYY7h5YN703dNCa+Bua3KhMgc3JEmv5GdRuBkq5j++PN4dFBPYA+Fx6Bk2H2To5rT0Gqx
 6ZIwYKx1R+eU+rkP5bPaV+JefPUP7sc3RzmR8zuZiIldJRX6Nbh9jjmvGxYAFcOE4a4B8vDJ
 xiIaavPPPBwMKUl6aNlk4OonH3vM1MUGcFse1J0bQ/Yhi4YS2SkyJCx8v4vPOHrsfyx2GPbm
 7mCn3k1uden6lLGWw21HK42xu21TaJk5Mn6PLPsRhBx/zXv4LheSuN6g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 6/6] kas: Add option for selecting read-only rootfs type
Date: Tue,  5 Nov 2024 18:54:33 +0100
Message-ID: <12bc32044317b4afd31a97d5eb14c38b997a89be.1730829273.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730829273.git.jan.kiszka@siemens.com>
References: <cover.1730829273.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 17:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17180

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to select EROFS as alternative to squashfs. The option is
limited to 6.1 kernels, older ones will no longer be enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig           | 16 ++++++++++++++++
 kas/opt/erofs.yml | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 kas/opt/erofs.yml

diff --git a/Kconfig b/Kconfig
index 8062cdb7..83f2c2f6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -198,6 +198,22 @@ config IMAGE_DELTA_SWUPDATE
 
 endchoice
 
+choice
+	prompt "Read-only rootfs type"
+
+config IMAGE_RO_ROOTFS_SQUASHFS
+	bool "Squashfs"
+
+config IMAGE_RO_ROOTFS_EROFS
+	bool "EROFS"
+	depends on KERNEL_6_1
+
+endchoice
+
+config KAS_INCLUDE_EROFS
+	string
+	default "kas/opt/erofs.yml" if IMAGE_RO_ROOTFS_EROFS
+
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
diff --git a/kas/opt/erofs.yml b/kas/opt/erofs.yml
new file mode 100644
index 00000000..7c44f5b8
--- /dev/null
+++ b/kas/opt/erofs.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+header:
+  version: 14
+
+local_conf_header:
+  erofs: |
+    RO_ROOTFS_TYPE = "erofs"
-- 
2.43.0


