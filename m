Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4541FD4334B
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.69033.1730977083816661210
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SotyqUEt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202411071058049944e65d1da4fffc29-redlhq@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202411071058049944e65d1da4fffc29
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=quip0bhfAbLImM4O05s0oNdIorG3GsZ58e0pO7sBgVw=;
 b=SotyqUEtI6lNIcKvNHyziLxTx3AiD5kVZJ/lkilc6TGz0cfudH7MUuqjaLsXgwxV9z2s/v
 5qP4nFI/+nmrUQ5gxZ58gDLCRELIfLmF7LtUzb2geMTqB0Z4hJZNx8lG77tGg6Ivjhh/0H6G
 +Ld+sE4YcKCXGQ1C6U45Dcqj+Xk08JQr1sIL/l71YobWYhx2dbXHVRt4pEfPET07yybyl8kD
 cHeFH0yh9UE46JTsxU5ac7vE/YyFVCIamXqjgCJUAg51DUHaJ3Ce5eZf8cibUOcNLS7W2dV3
 IZ2NL+Axqju3/DatxVVySgoAeVytjSo6B8zvQFZzbQwWv8ZTm67ujYJQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 8/9] Add Debian trixie
Date: Thu,  7 Nov 2024 11:57:56 +0100
Message-ID: <9f7d4bfb8372fd290187302c94c455ddf5aafa4c.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17210

From: Jan Kiszka <jan.kiszka@siemens.com>

Comes with an isar revision bump to stop using a self-built
crossbuild-essential-riscv64 package.

Based on similar changes by Cedric Hombourger and Quirin Gylstorff.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                          |  4 ++++
 conf/distro/cip-core-trixie.conf                 | 16 ++++++++++++++++
 kas-cip.yml                                      |  2 +-
 kas/opt/trixie.yml                               | 15 +++++++++++++++
 recipes-devtools/secure-boot-secrets/files/sid   |  1 +
 .../files/{sid => trixie}/PkKek-1-snakeoil.key   |  0
 .../files/{sid => trixie}/PkKek-1-snakeoil.pem   |  0
 .../swupdate-certificates/files/trixie           |  1 +
 start-qemu.sh                                    |  2 ++
 9 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 conf/distro/cip-core-trixie.conf
 create mode 100644 kas/opt/trixie.yml
 create mode 120000 recipes-devtools/secure-boot-secrets/files/sid
 rename recipes-devtools/secure-boot-secrets/files/{sid => trixie}/PkKek-1-snakeoil.key (100%)
 rename recipes-devtools/secure-boot-secrets/files/{sid => trixie}/PkKek-1-snakeoil.pem (100%)
 create mode 120000 recipes-devtools/swupdate-certificates/files/trixie

diff --git a/Kconfig b/Kconfig
index d10ae917..09bb7699 100644
--- a/Kconfig
+++ b/Kconfig
@@ -136,6 +136,9 @@ config DEBIAN_BOOKWORM
 	bool "bookworm (12)"
 	depends on !ARCH_RISCV64
 
+config DEBIAN_TRIXIE
+	bool "trixie (testing)"
+
 config DEBIAN_SID
 	bool "sid (unstable)"
 	depends on ARCH_RISCV64
@@ -147,6 +150,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
+	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
 	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
new file mode 100644
index 00000000..58999d1b
--- /dev/null
+++ b/conf/distro/cip-core-trixie.conf
@@ -0,0 +1,16 @@
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
+require conf/distro/debian-trixie.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/kas-cip.yml b/kas-cip.yml
index 73c467ed..fcdb10c4 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 8c9bdd3cb0ac93aa46552d4554bafaea5d1d7d13
+    commit: 57f6b70d91711075fbeb07dd2bdf5c9e5b3c6ee6
     layers:
       meta:
 
diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
new file mode 100644
index 00000000..e9a76ef5
--- /dev/null
+++ b/kas/opt/trixie.yml
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
+distro: cip-core-trixie
diff --git a/recipes-devtools/secure-boot-secrets/files/sid b/recipes-devtools/secure-boot-secrets/files/sid
new file mode 120000
index 00000000..f0b7e328
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/sid
@@ -0,0 +1 @@
+trixie
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/trixie/PkKek-1-snakeoil.key
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
rename to recipes-devtools/secure-boot-secrets/files/trixie/PkKek-1-snakeoil.key
diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/trixie/PkKek-1-snakeoil.pem
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
rename to recipes-devtools/secure-boot-secrets/files/trixie/PkKek-1-snakeoil.pem
diff --git a/recipes-devtools/swupdate-certificates/files/trixie b/recipes-devtools/swupdate-certificates/files/trixie
new file mode 120000
index 00000000..3d633aef
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/trixie
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/trixie
\ No newline at end of file
diff --git a/start-qemu.sh b/start-qemu.sh
index 9ec0f1c2..0e425ea7 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -46,6 +46,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 		DISTRO_RELEASE="buster"
 	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
 		DISTRO_RELEASE="bookworm"
+	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
+		DISTRO_RELEASE="trixie"
 	else
 		DISTRO_RELEASE="bullseye"
 	fi
-- 
2.43.0


