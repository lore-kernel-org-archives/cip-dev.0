Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB5C433FE
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:32 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web10.24557.1636993231879669177
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=04obOsQE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.195,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f195.google.com with SMTP id m14so15454194pfc.9
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbqCdjKY9hrEGcHuob56VfMTMmdVTfPzLW8j0XbiGqM=;
        b=04obOsQE7ABU9J4O2snlHBJAEWthzP53ELqVRMGuHlVRVjYInbZJ/0jxS08vAr56w/
         JydmFMLGuSYR0kExXf7JNOrF/PYPwyCSqKpNQH5i88aLlj35S5Z4i08Qw8Nh6sJP0Jcw
         3a6bi3f0sWcdslarjwFU1FLkNPcU1doSej65nd1IHxMs0c/fvoSVgY+CciYlfe6EXuZY
         7dMRcLJJToh6LYbbxeFlqSu3er4/ofX55CGaX1z8dcEn4toAg6iNQQn+A6b+K3l5TztJ
         3lv/FKgRM3ikO9PFukc1lw4TEKk19xU5qgtvLQTOthY6b2KVzTS/ClbMigvNNzggQxj7
         fPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbqCdjKY9hrEGcHuob56VfMTMmdVTfPzLW8j0XbiGqM=;
        b=HQouAbYw7uneaxMZX+2c005NcvV5Lpt9Yq/wQaFTbxJxyia3svhnRTiQ6FshTPFXlq
         9pUa2TH0r4ale+D5hO/1uHM6TzNeusl3geVPP63QFljX7KUWlAH6FgQ3BTuO9dny7F1Z
         aAdpxdyr+riXVUT6Q8L5SidPS0BFoa9w8sV6Fn/vYS738qd/5CnHSlQP6CyG4e/psd6I
         mNuME7Q29xNWGxA8kUfI7CtLX/msKWuiGFqRXFK7tcoKd4jLm97GCkVjn1Il2HvypAiW
         kr+W2fHLzB5dsB4ePgRnztNKifjD1GAIfqpzngZihAO3Z21zEbBuppwg+zL55ptxq7b3
         rntA==
X-Gm-Message-State: AOAM531z+lKAqyM2CzujdmXDcSTYFRfHwH3nYiVzUwZElVUH8pEbdNXj
	OUXzDddI3FzsJD8DON1r53boof0389IV6nU=
X-Google-Smtp-Source: 
 ABdhPJzyuWoeobAE3bvediAYvSz5EQjpIyur9k9vQkQn1JCWQo0IvQr12T68JHhNIKNxgSWtXTCDOw==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr24903469pgj.355.1636993231348;
        Mon, 15 Nov 2021 08:20:31 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:30 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 07/11] Create cip-core-image-kernelci
Date: Tue, 16 Nov 2021 01:17:20 +0900
Message-Id: <20211115161724.19516-8-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6910

Initialization of the cip-core-image-kernelci

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml                                |  3 ++
 kas/opt/kernelci.yml                          | 16 +++++++++
 .../images/cip-core-image-kernelci.bb         | 16 +++++++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
 .../kernelci-customizations/files/postinst    | 22 ++++++++++++
 .../kernelci-customizations.bb                | 34 +++++++++++++++++++
 scripts/deploy-kernelci.py                    | 13 +++----
 8 files changed, 122 insertions(+), 6 deletions(-)
 create mode 100644 kas/opt/kernelci.yml
 create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ethernet
 create mode 100644 recipes-core/kernelci-customizations/files/postinst
 create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9776754..7e9b31c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -84,6 +84,7 @@ build:qemu-amd64-base-kernelci:
     - .build_base
   variables:
     target: qemu-amd64
+    extention: kernelci
     use_rt: disable
     wic_targz: disable
     targz: enable
@@ -105,6 +106,7 @@ build:qemu-arm64-base-kernelci:
     - .build_base
   variables:
     target: qemu-arm64
+    extention: kernelci
     use_rt: disable
     wic_targz: disable
     targz: enable
@@ -126,6 +128,7 @@ build:qemu-arm-base-kernelci:
     - .build_base
   variables:
     target: qemu-arm
+    extention: kernelci
     use_rt: disable
     wic_targz: disable
     targz: enable
diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
new file mode 100644
index 0000000..9c67864
--- /dev/null
+++ b/kas/opt/kernelci.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+header:
+  version: 10
+
+target: cip-core-image-kernelci
diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
new file mode 100644
index 0000000..479c14c
--- /dev/null
+++ b/recipes-core/images/cip-core-image-kernelci.bb
@@ -0,0 +1,16 @@
+#
+# A reference image for KernelCI
+#
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit image
+
+DESCRIPTION = "CIP Core image for KernelCI"
+
+IMAGE_INSTALL += "kernelci-customizations"
diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.conf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
new file mode 100644
index 0000000..ad24d3a
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
@@ -0,0 +1 @@
+kernel.printk = 3 4 1 3
diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-core/kernelci-customizations/files/ethernet
new file mode 100644
index 0000000..fa47d1a
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/ethernet
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+allow-hotplug eth0
+allow-hotplug enp0s2
+allow-hotplug enp2s0
+
+# used on BBB
+iface eth0 inet dhcp
+
+# used on qemu-amd64
+iface enp0s2 inet dhcp
+
+# used on simatic-ipc227e
+iface enp2s0 inet dhcp
diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
new file mode 100644
index 0000000..33faaeb
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+echo "CIP Core Demo & Test Image" > /etc/issue
+
+echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
+echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
+
+HOSTNAME=demo
+echo "$HOSTNAME" > /etc/hostname
+echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
new file mode 100644
index 0000000..15788a0
--- /dev/null
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) Cybertrust Japan Co., Ltd., 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "CIP Core image demo & customizations"
+
+SRC_URI = " \
+    file://postinst \
+    file://ethernet \
+    file://99-silent-printk.conf"
+
+DEPENDS += "sshd-regen-keys"
+
+DEBIAN_DEPENDS = " \
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
+
+do_install() {
+	install -v -d ${D}/etc/network/interfaces.d
+	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
+
+	install -v -d ${D}/etc/sysctl.d
+	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+}
diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index c234113..1df4e72 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -19,14 +19,15 @@ extension=sys.argv[3]
 if extension == "security":
     rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
     initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
-elif extension == "base":
+    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
+elif extension == "kernelci":
+    rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
+    initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
+    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
+else:
+    # base extension is not adding extension name in the filename
     rootfs_filename="cip-core-image-cip-core-"+release+"-"+target+".tar.gz"
     initrd_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img"
-
-# initrd is actually gz compressed
-if extension == "security":
-    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
-elif extension == "base":
     initrd_gz_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img.gz"
 
 input_dir="build/tmp/deploy/images/"+target
-- 
2.33.1


