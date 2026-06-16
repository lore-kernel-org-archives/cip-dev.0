Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14031CD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:19:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.147713.1781587170591909428
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 22:19:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65G5JRD4231709; Tue, 16 Jun 2026 14:19:27 +0900
X-Iguazu-Qid: 2rWhvgZcO1lov8XqvH
X-Iguazu-QSIG: v=2; s=0; t=1781587167; q=2rWhvgZcO1lov8XqvH; m=Xc4iDxTqtFNndeH9O0BNzaxIMysdwCZv+pYZzHO8dzQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfZzg2j6Nz4vys; Tue, 16 Jun 2026 14:19:27 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 1/2] Enable Debian Sid support
Date: Tue, 16 Jun 2026 10:36:26 +0530
X-TSB-HOP2: ON
Message-Id: <20260616050628.3560536-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2026 05:19:23.0132 (UTC) FILETIME=[B13163C0:01DCFD4F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 05:19:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23150

This patch enables to build the images based on the Debian sid version.
It helps to fix the issues in advance for the newer version.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig                       |  4 ++++
 conf/distro/cip-core-sid.conf | 16 ++++++++++++++++
 kas/opt/sid.yml               | 15 +++++++++++++++
 start-qemu.sh                 |  2 ++
 4 files changed, 37 insertions(+)
 create mode 100644 conf/distro/cip-core-sid.conf
 create mode 100644 kas/opt/sid.yml

diff --git a/Kconfig b/Kconfig
index bd2b7ce..44f2337 100644
--- a/Kconfig
+++ b/Kconfig
@@ -239,6 +239,9 @@ config DEBIAN_BOOKWORM
 config DEBIAN_TRIXIE
 	bool "trixie (13)"
 
+config DEBIAN_SID
+	bool "Sid (Unstable)"
+
 endchoice
 
 config KAS_INCLUDE_DEBIAN
@@ -247,6 +250,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
 	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
+	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
 
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
new file mode 100644
index 0000000..0a2a2da
--- /dev/null
+++ b/conf/distro/cip-core-sid.conf
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024-2025
+#
+# Authors:
+#  Cedric Hombourger <cedric.hombourger@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-sid.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_linux-cip ?= "6.12.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
diff --git a/kas/opt/sid.yml b/kas/opt/sid.yml
new file mode 100644
index 0000000..d5dce00
--- /dev/null
+++ b/kas/opt/sid.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Cedric Hombourger <cedric.hombourger@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+distro: cip-core-sid
diff --git a/start-qemu.sh b/start-qemu.sh
index 7ccbefe..d12fa23 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -45,6 +45,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 		DISTRO_RELEASE="bookworm"
 	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
 		DISTRO_RELEASE="trixie"
+	elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
+		DISTRO_RELEASE="sid"
 	else
 		echo "No supported Debian release configured"
 		exit 1
-- 
2.39.5



