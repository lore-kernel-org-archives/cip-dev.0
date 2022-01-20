Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C0C4332F
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 12:55:54 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.11209.1642683352386932127
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=nkpzBAMo;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.170,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f170.google.com with SMTP id p125so5323589pga.2
        for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=nkpzBAMouAVJcYFuzbTL2rDjKrNwJBxiRdNEoeAJ6wZifWTZnXkcjbeE+6JlrEO6HA
         TUnjkTJj8sZQ4AL/9wFsCwy8FhXzyLozpFiWsGv5aSHjUDaE5cVKwNaO/UGHr6GbbYBa
         BR4hHbYRZWFKpz8tMnG/Ghq00xT5mu1skLLdYs+M9c+cmIiLvZEnGnsvnKO5hqmQwpOV
         ZIcpdgRokrumgtEmvftw0FvzaWX8DlVK+Q4NqjmurfKVqFh+HWbL7cu1tCW6Gq0u+wM9
         YMCrNh2Iku5ZCWXH4D5ih7qQlqm+fkv1jdEKFrdKtTjuhacEOEJix8F913ujMOU+9fUI
         rhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9gqQIo7Fw8BVR6llbOlE9b1kL17o3XFR9HX6wYAXIg=;
        b=1SRyrMs14yfcYXuaeNAZ26+I3512u9geibKn2aD6SFtQgdB8C3AY7AIgkYe83NMVpY
         KZFe7KZKBAdM4xJlTVpHMJKXysKhYw5cz4P7hXNxID8/SNpsOH42GllQtD/kJtExB5Nr
         mo8+SfcN7JtWDAyhK8R6mQSCI9+d2lHgRnRBiNZysX1WUmUIhYVSdLCOdYVoIhdYARJ0
         ChO98WIhrY7XpS1liZVlmpK1+hrRJoY8tbsqoV13UvqlpVBBZ+1AV7GvIEG2ynu/3ebE
         W1WTTW1V3HAKt2NmObRK9951lIj6t/ngqs7Fxzv8XL69hynA/NUeXzrvvHUI+CkDnsao
         YSSA==
X-Gm-Message-State: AOAM533A0p8qjvwx4T83OubjgGvzwftczf0eBCqmf98qUp4/K9PGhay5
	x0wXB3OwiZEf//5Ia4YlWkfKC7kiJ8W/
X-Google-Smtp-Source: 
 ABdhPJzlwpHm7735iM1aA0b5Qj/2BjecEUfiib1qw3djseo2RCfHN9LMOnqPP6KR/TTSZWIvyMe/aA==
X-Received: by 2002:a63:1c1d:: with SMTP id c29mr31812421pgc.89.1642683351821;
        Thu, 20 Jan 2022 04:55:51 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 n11sm9975634pjf.29.2022.01.20.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:55:50 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v2 1/4] Add cip-core-image-kernelci
Date: Thu, 20 Jan 2022 21:54:15 +0900
Message-Id: <20220120125418.236990-2-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 12:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7473

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


