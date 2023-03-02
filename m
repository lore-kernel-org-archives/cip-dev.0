Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55251C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:31:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.18911.1677770883930396785
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:28:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=AltUa5E7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-202303021528026bc37a7078039a74b4-paxrgy@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202303021528026bc37a7078039a74b4
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:28:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1GlxZyhiuBNqjIVsD4yPjK8Incrr20EFNyC6X/BT2e0=;
 b=AltUa5E79U4FuZ8uHUsmd1qBjTQ+ipGdUJwjfDW+cCd5gt6kyEsHq9HIMc4n5mF4rXlSFX
 kQWRtfZXFaDRlZfabQscwFtrtUOJuVdN/blrxSJuAgTipYd7pRNSwu3s6LhHNopsYmMNHo/R
 acPSRh9GERQCurhzUrd3d4vF4FL2I=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 7/9] add linux 6.1 mainline kernel
Date: Thu,  2 Mar 2023 15:26:57 +0000
Message-Id: <20230302152659.2096307-8-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10882

This patch adds the vanilla 6.1 linux kernel for testing and for boards
which need a more recent kernel than what CIP can offer.
The kernel can be selected from the menu, similar to the other kernels.
As defconfig, we always use the kernels internal configuration, because
there is no cip-kernel-config for that version yet. In addition, the
squashfs knob is selected to support the swupdate pattern without any
modifications.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 Kconfig                                    |  4 ++++
 kas/opt/6.1-mainline.yml                   | 18 ++++++++++++++++++
 recipes-kernel/linux/files/squashfs.cfg    |  1 +
 recipes-kernel/linux/linux-mainline_6.1.bb | 18 ++++++++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 kas/opt/6.1-mainline.yml
 create mode 100644 recipes-kernel/linux/files/squashfs.cfg
 create mode 100644 recipes-kernel/linux/linux-mainline_6.1.bb

diff --git a/Kconfig b/Kconfig
index cd24ce2..a932bbe 100644
--- a/Kconfig
+++ b/Kconfig
@@ -97,6 +97,9 @@ config KERNEL_4_19
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
 
+config KERNEL_6_1_MAINLINE
+	bool "Kernel 6.1.x-mainline"
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -104,6 +107,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/4.4.yml" if KERNEL_4_4
 	default "kas/opt/4.19.yml" if KERNEL_4_19
 	default "kas/opt/5.10.yml" if KERNEL_5_10
+	default "kas/opt/6.1-mainline.yml" if KERNEL_6_1_MAINLINE
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
new file mode 100644
index 0000000..84d12b0
--- /dev/null
+++ b/kas/opt/6.1-mainline.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+local_conf_header:
+  kernel-version: |
+    KERNEL_DEFCONFIG = ""
+    KERNEL_NAME = "mainline"
diff --git a/recipes-kernel/linux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg
new file mode 100644
index 0000000..7a89d00
--- /dev/null
+++ b/recipes-kernel/linux/files/squashfs.cfg
@@ -0,0 +1 @@
+CONFIG_SQUASHFS=y
diff --git a/recipes-kernel/linux/linux-mainline_6.1.bb b/recipes-kernel/linux/linux-mainline_6.1.bb
new file mode 100644
index 0000000..8a879a0
--- /dev/null
+++ b/recipes-kernel/linux/linux-mainline_6.1.bb
@@ -0,0 +1,18 @@
+# Example recipe for building the mainline kernel
+#
+# This software is a part of ISAR.
+# Copyright (c) Siemens AG, 2018-2020
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-kernel/linux/linux-custom.inc
+
+ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else d.getVar('PV') }"
+
+SRC_URI += " \
+    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
+    file://squashfs.cfg"
+
+SRC_URI[sha256sum] = "2ca1f17051a430f6fed1196e4952717507171acfd97d96577212502703b25deb"
+
+S = "${WORKDIR}/linux-${ARCHIVE_VERSION}"
-- 
2.34.1


