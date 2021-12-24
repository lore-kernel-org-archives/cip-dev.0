Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE25C433F5
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 07:33:18 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.43149.1640331195859306086
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ovWTl5ZX;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.54,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f54.google.com with SMTP id
 z9-20020a17090a7b8900b001b13558eadaso10876764pjc.4
        for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=ovWTl5ZX1Yft3Mh8uWO9v65hVpaQoxjVmksUK3N+MSYjWI0RuT7UN1+irSF0Qd63Pg
         xXQig+nahVFZQwIcIWhyiU36VFskzLHOzHXuB68tEot/e9zEcz++RLdbUcS/vDrGKi8y
         MqYXowOOXQCxLFR/h5iKfAzj2ThsVwnK72lexJYW+AvAwkJNepIdgZ6I981/IDPVyCQw
         a2F2nJTxBqIcpMzIL6U1YdLTTiKBghhXvqsLdAzcVK6JIzFZv9K8dCdYbiD+NIpPQm1+
         3hL+ZEGzivvWO4qUKabDjMmBadPjT3mK8CMkkqD722iVsMQ08JbdjOb1hwoqt46K0B9g
         xrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=gaqoe+ZxlEM/GM5M9m1KgSUBWxhEsTFi2KCsOOa0CDXvCYBlAKVh2naJwBU6IgD2S/
         hNTyGBj1J5zN1dGrf2hDDYcHG1slKtnvQtt/XBTS8oDoErVEtS3u8e/VU04pf07TjAnn
         vP01bazgTIug0PJWiMLNV8SgwtVMa/52yq6vyk0B+PnKmIfb8as2RmkhwaaWiqMq1PRO
         8aecCtlkfMHE1BuK371GOlf6XX8GI7nJGbZJVqMYJay91VuIiznGwmKFPhuxuGTCgIyk
         gZx/5FCdhK1weLuUmSQG7i25Fyxw8081fNKeJm9qmv7LvgEVbaUDRD8votAcJvwN0Af/
         //qA==
X-Gm-Message-State: AOAM532ZHWHNMG60st6DJ4ZH2gx65oRG+iXZiN37iO1gQKfVguLfxD5k
	QIeTybGMaLAFV/hJFXWr/gVMRxUrrIvn
X-Google-Smtp-Source: 
 ABdhPJzK5h+lFsRCuYShPtTLIu5bXUfLzmR4PSvkdGxHaTzbFejya8A8kfmR2vrOjNuCn1gfnDO64w==
X-Received: by 2002:a17:903:41c1:b0:149:3895:48a1 with SMTP id
 u1-20020a17090341c100b00149389548a1mr5518626ple.159.1640331195403;
        Thu, 23 Dec 2021 23:33:15 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 u18sm8763175pfi.158.2021.12.23.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 23:33:14 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH 1/4] Add cip-core-image-kernelci
Date: Fri, 24 Dec 2021 16:32:39 +0900
Message-Id: <20211224073242.69676-2-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
References: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 07:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7265

This image is currently used by KernelCI production for testing purpose.
The purpose of this image is that KernelCI need to be able to autologin
without password and to detect the login shell using special characters.
Currently added are the default settings used by KernelCI images.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 kas/opt/kernelci.yml                          | 16 +++++++++
 .../images/cip-core-image-kernelci.bb         | 16 +++++++++
 .../files/99-silent-printk.conf               |  1 +
 .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
 .../kernelci-customizations/files/postinst    | 34 +++++++++++++++++++
 .../kernelci-customizations.bb                | 34 +++++++++++++++++++
 6 files changed, 124 insertions(+)
 create mode 100644 kas/opt/kernelci.yml
 create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ethernet
 create mode 100644 recipes-core/kernelci-customizations/files/postinst
 create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb

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
index 0000000..7ae30e8
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/postinst
@@ -0,0 +1,34 @@
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
+# permit root login without password
+echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
+echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
+passwd root -d
+
+# serial getty service for autologin
+mkdir -p /etc/systemd/system/serial-getty@.service.d/
+echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
+echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
+echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
+
+# set the profile for KernelCI
+echo "PS1='\$(pwd) # '" > /root/.profile
+echo "cd /" >> /root/.profile
+
+HOSTNAME=demo
+echo "$HOSTNAME" > /etc/hostname
+echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
new file mode 100644
index 0000000..dca0891
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
+  install -v -d ${D}/etc/network/interfaces.d
+  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
+
+  install -v -d ${D}/etc/sysctl.d
+  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+}
-- 
2.33.1


