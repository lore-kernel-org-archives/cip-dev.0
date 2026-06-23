Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF1CDB479
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 11:05:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18583.1782212744517591454
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 04:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65NB5gDR165411; Tue, 23 Jun 2026 20:05:42 +0900
X-Iguazu-Qid: 2yAbopOycMYQimsIID
X-Iguazu-QSIG: v=2; s=0; t=1782212742; q=2yAbopOycMYQimsIID; m=kBVryPe9fCkVMVTw8t2e8EoMnC5r70Ln52Gyp3L7pew=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gl2Ky38tFzyPQ; Tue, 23 Jun 2026 20:05:42 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 2/3] Enable Debian Sid support
Date: Tue, 23 Jun 2026 16:22:33 +0530
X-TSB-HOP2: ON
Message-Id: <20260623105234.972121-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 11:05:38.0959 (UTC) FILETIME=[397141F0:01DD0300]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 11:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23266

This patch enables to build the images based on the Debian sid version.
It helps to fix the issues in advance for the newer version.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig                                           |  4 ++++
 conf/distro/cip-core-sid.conf                     | 13 +++++++++++++
 kas/opt/sid.yml                                   | 15 +++++++++++++++
 .../initramfs-crypt-hook_0.11.bb                  |  2 ++
 start-qemu.sh                                     |  2 ++
 5 files changed, 36 insertions(+)
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
index 0000000..2f6eb69
--- /dev/null
+++ b/conf/distro/cip-core-sid.conf
@@ -0,0 +1,13 @@
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
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 3cb0520..9132ad3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
 DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
+DEBIAN_DEPENDS:append:sid   = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 
 DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
 DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
+DEBIAN_DEPENDS:append:systemd:sid   = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
 
 HOOK_ADD_MODULES = " \
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



