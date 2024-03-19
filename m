Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2643CD11DF
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:41 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.23429.1710872431756278895
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Z58nE/dw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024031918202922be0774f1a14ef5b6-hdu1ur@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024031918202922be0774f1a14ef5b6
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Mar 2024 19:20:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GAeKVjVSXCIG30rWMZpQSRyWEj0Fct1L3P4UF4E3vrk=;
 b=Z58nE/dwtRkybmsma0sUBLVEmLhG0pMKOhwNea3qrEwb+vITXZbu2kNHezfHrkDNZH2C9B
 rnZQLSAmEKF0XeSUNw3j+S+2uFJTTdebQWj9LUJXDkQbmwyJJJNdlRcj12f+SwWAFlyLDCKP
 OpDqpd1jeOhMnqVjSp2BcRlnxENSY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][RFC 8/8] Add example to encrypt the rootfs
Date: Tue, 19 Mar 2024 19:18:32 +0100
Message-ID: <20240319182026.1571362-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15367

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
This is a rough example to show that rootfs encryption is possible.

 kas/opt/encrypt_rootfs.yml   | 24 ++++++++++++++++++++++++
 wic/x86_64-encryption.wks.in | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 kas/opt/encrypt_rootfs.yml
 create mode 100644 wic/x86_64-encryption.wks.in

diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
new file mode 100644
index 0000000..4001c75
--- /dev/null
+++ b/kas/opt/encrypt_rootfs.yml
@@ -0,0 +1,24 @@
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
+    INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+    do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.in
new file mode 100644
index 0000000..c143500
--- /dev/null
+++ b/wic/x86_64-encryption.wks.in
@@ -0,0 +1,18 @@
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
+# Not nice use the source param label to supress the root commandline
+part / --source rootfs --fstype ext4 --sourceparams "label=BOOT" --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
+# home and var are extra partitions
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+
+# This works as we know how that the luks device will be named encrypted_<label of the root device>
+bootloader --ptable gpt --timeout 2 --append "root=/dev/mapper/encrypted_platform console=ttyS0,115200"
-- 
2.43.0


