Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D3C433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 11:17:12 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.7277.1641467830112949625
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=l+lu5LWc;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.54,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pj1-f54.google.com with SMTP id
 rj2-20020a17090b3e8200b001b1944bad25so2806183pjb.5
        for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=l+lu5LWcLmz/WRngnbaqA/KiH9MEcQn6kraP6ATiBUQFaJCthRmYY0OSwB2XnI7BDz
         xPplcRvjWssEmBxcdRO4CX9Nu7bR3u4BooqWZkcV9s7P98j44THUkH5veAqILTJi8//I
         rencS7MOLyk4d39ALrnF3eZzbfC9407wQNytyjZmeDBZf+8tt9QcEsikybSgZYA1R8p2
         mkEy3lXXJm7YH4UIiSUIOgVXFdpAXzhiatfnPIfLKtkGEypgLryQn2cPI4kkq8om7Oep
         Z9CEn0XSaaUI+z3jEEkq4R7XIFOtGoEnatSSxM9dvfsiEhpWQzQ8UWei7wlGwMQWRwPh
         bvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=hEXOG/ocQPs4HhqSQG8r4ufk/rtli20CZZX0ZyGLgkRahmusuG+FNgbdwMk2KYg1N8
         Ttik07wahWEpE26Y8PPIi7/gfz4fhxqxGLMjDIng3WCqhplZc9cUBMwP0hoqWneb1mJd
         likGVXRYQGinpBwKxCRqNJs/CkvSRetOJgcN6aLW7cLPMvZREuiXtZdaWlb2KyrL+60R
         Hqtp9E7E2HzcnQNNGATcWX39dz1AlA685nYsc+oXXeSwhhF1Xz1PO0o4Fg4nai9ozukf
         S1WapsEe+Wf+KCVvuL0DekLiEiHiX+LMYQewNNxI4/aHqk3YwW13aBIaXdUq6iBjFwZ+
         qThw==
X-Gm-Message-State: AOAM5307XSDvIpjF/NSKG8wr0lV9ID1Du2krB9vZFas0RLgcWdEwrsrt
	CQVoiiDxlQEb5t3960DUXom728fzzUcd
X-Google-Smtp-Source: 
 ABdhPJxywu9u/c2thL7Pfh44YoktDOofhrsS1vzxkwUjEGYQ7hoZCpODjE4lEKqJCCS3PFxg8D2/mw==
X-Received: by 2002:a17:90a:bd01:: with SMTP id
 y1mr9474328pjr.33.1641467829568;
        Thu, 06 Jan 2022 03:17:09 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 x6sm1766325pge.50.2022.01.06.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:17:08 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 1/4] Add cip-core-image-kernelci
Date: Thu,  6 Jan 2022 20:16:11 +0900
Message-Id: <20220106111614.218823-2-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 11:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7327

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


