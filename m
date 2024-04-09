Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37725CD12A0
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.136246.1712668004002445160
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=U2iQhwio;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-2024040913064129eb205e007bbe35ee-ljz5p3@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024040913064129eb205e007bbe35ee
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mQOtiWxET8I9g/YPFf7X1Ze077cmG0qlkWB9eFHbhtE=;
 b=U2iQhwio0pfXHdSc7cixN7POjLqaV4ukkpxRTLibmXF1p+SrX3kADtFA7+RquZNPZCYcbr
 B6IN8TkCbGQoVEZYhdUXINTI09ZoFRcEZ5X9ueCOzpgmjkiCyUQsRAV4MrFpvZPw1Jb6W3WR
 XpvuyMUwZLIM3yvfbitGhf5Nierx8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 13/15] Add example to encrypt the rootfs
Date: Tue,  9 Apr 2024 15:05:30 +0200
Message-ID: <20240409130638.559398-14-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15525

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt_rootfs.yml   | 25 +++++++++++++++++++++++++
 wic/x86_64-encryption.wks.in | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 kas/opt/encrypt_rootfs.yml
 create mode 100644 wic/x86_64-encryption.wks.in

diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
new file mode 100644
index 0000000..9e284b4
--- /dev/null
+++ b/kas/opt/encrypt_rootfs.yml
@@ -0,0 +1,25 @@
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
+
+local_conf_header:
+  encrypted_root: |
+    WKS_FILE = "x86_64-encryption.wks.in"
+    CRYPT_PARTITIONS = "platform:/:reencrypt home:/home:reencrypt var:/var:reencrypt"
+    IMAGE_FSTYPES = "wic"
+    IMAGER_INSTALL:wic += "systemd-boot"
+    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
+    INITRAMFS_RECIPE ?= "cip-core-initramfs"
+    INITRAMFS_INSTALL:append = " initramfs-crypt-hook"
+    INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+    do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.in
new file mode 100644
index 0000000..800b56d
--- /dev/null
+++ b/wic/x86_64-encryption.wks.in
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# SPDX-License-Identifier: MIT
+#
+
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,initrd=${INITRD_IMAGE}" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
+
+part / --source rootfs --fstype ext4  --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
+# home and var are extra partitions
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+
+bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.43.0


