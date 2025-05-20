Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724DFC3ABDD
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 12:43:52 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.19825.1747745027409433866
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=fkSSPaGi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20250520124344fd9626a6156570eea3-cyhayq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250520124344fd9626a6156570eea3
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NONHeukLg8lkxaotqG2DCXZZ/8Ku4n7RD6zqUDnB4/g=;
 b=fkSSPaGiVn1GvHCYJFP7jUGQ9iyhgo6kAJ8Qib0L3Ynrqy1dd8oRhX4kp7cJtTLY/ku2aX
 USJePg7+nOYsrfdm622CFLvaSRT1JwsfJUqjAnXP03q2ckS02CCQQ1E7bxiuBv7Evpk1bHHE
 fMEKyMWXolGq7yPSBx7V4MFLOpQRhPcU413sfIdZNZlZW4wHhw7oiMov24GtsWqRqfyqfLxN
 2vQQzn9hvSqLivO3ar3T8DNp+vy0ysD4EsFTGmAlHxiLS2vfFbzJdNYsTYOV/AhFJX5o+Km6
 BWDDlIJ4Oxnqk4ooW1VY60qNCa3GPU7Kwc92l8rFwhnTcG8Du5BIfqAQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/4] Add support for CIP kernel 6.12
Date: Tue, 20 May 2025 14:43:41 +0200
Message-ID: <39db6eaae60ba88a961e5a793db1f1bc77fd32a7.1747745022.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1747745022.git.jan.kiszka@siemens.com>
References: <cover.1747745022.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 12:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18928

From: Jan Kiszka <jan.kiszka@siemens.com>

One difference with 6.12 is that there are no longer two different code
bases for vanilla and RT. Therefore, simply establish a link from the RT
recipe to the regular one so that we can continue to control the
activation of RT kernel config by setting the KERNEL_NAME to "cip-rt".

As trixie upstream is heading for 6.12, lift our default for CIP images
built for it accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       |  4 +++
 conf/distro/cip-core-trixie.conf              |  6 ++--
 kas/opt/6.12.yml                              | 18 +++++++++++
 .../linux/linux-cip-rt_6.12.29-cip1.bb        |  1 +
 .../linux/linux-cip_6.12.29-cip1.bb           | 10 +++++++
 scripts/update-linux-cip.sh                   | 30 +++++++++++--------
 6 files changed, 54 insertions(+), 15 deletions(-)
 create mode 100644 kas/opt/6.12.yml
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.12.29-cip1.bb

diff --git a/Kconfig b/Kconfig
index a726d262..f809f014 100644
--- a/Kconfig
+++ b/Kconfig
@@ -100,6 +100,9 @@ config KERNEL_5_10
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
 
+config KERNEL_6_12
+	bool "Kernel 6.12.x-cip"
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -108,6 +111,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/4.19.yml" if KERNEL_4_19
 	default "kas/opt/5.10.yml" if KERNEL_5_10
 	default "kas/opt/6.1.yml" if KERNEL_6_1
+	default "kas/opt/6.12.yml" if KERNEL_6_12
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index 723a3d70..e8eff746 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Cedric Hombourger <cedric.hombourger@siemens.com>
@@ -12,8 +12,8 @@
 require conf/distro/debian-trixie.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_linux-cip ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
+PREFERRED_VERSION_linux-cip ?= "6.12.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
 
 # cross build currently broken, use working snapshot
 ISAR_USE_APT_SNAPSHOT = "1"
diff --git a/kas/opt/6.12.yml b/kas/opt/6.12.yml
new file mode 100644
index 00000000..052b59cc
--- /dev/null
+++ b/kas/opt/6.12.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  kernel-version: |
+    PREFERRED_VERSION_linux-cip = "6.12.%"
+    PREFERRED_VERSION_linux-cip-rt = "6.12.%"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
new file mode 120000
index 00000000..4986a547
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
@@ -0,0 +1 @@
+linux-cip_6.12.29-cip1.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
new file mode 100644
index 00000000..5b8fbdbc
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-common.inc
+
+SRC_URI[sha256sum] = "27bf5750e3ac4ed50b3cca0eb910e330eb3b24ec3d078af3d7d626123ba7b819"
diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index e4e170f4..62af344b 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -2,7 +2,7 @@
 REPO_ROOT=$(git rev-parse --show-toplevel)
 pushd ${REPO_ROOT}/recipes-kernel/linux >/dev/null
 
-for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
+for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	rm -f sha256sums.asc
 	wget -q https://cdn.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
 	if ! gpg2 --verify sha256sums.asc 2>/dev/null; then
@@ -14,7 +14,7 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
 	VERSION=${LAST_ENTRY/*linux-cip-/}
 	VERSION=${VERSION/.tar.xz/}
 	RECIPE_FILE=linux-cip_${VERSION}.bb
-	if [ ! -f ${RECIPE_FILE} ]; then
+	if [ ! -f "${RECIPE_FILE}" ]; then
 		echo "Updating recipe to ${VERSION}"
 		git mv linux-cip_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
 		SHASUM=${LAST_ENTRY/ */}
@@ -22,16 +22,22 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
 		git add ${RECIPE_FILE}
 	fi
 
-	LAST_ENTRY=$(grep "rt[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
-	VERSION=${LAST_ENTRY/*linux-cip-/}
-	VERSION=${VERSION/.tar.xz/}
-	RECIPE_FILE=linux-cip-rt_${VERSION}.bb
-	if [ ! -f ${RECIPE_FILE} ]; then
-		echo "Updating recipe to ${VERSION}"
-		git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
-		SHASUM=${LAST_ENTRY/ */}
-		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
-		git add ${RECIPE_FILE}
+	if [ "${MAJOR_VERSION}" == "6.12" ]; then
+		git rm linux-cip-rt_${MAJOR_VERSION}*.bb
+		ln -s ${RECIPE_FILE} linux-cip-rt_${VERSION}.bb
+		git add linux-cip-rt_${VERSION}.bb
+	else
+		LAST_ENTRY=$(grep "rt[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
+		VERSION=${LAST_ENTRY/*linux-cip-/}
+		VERSION=${VERSION/.tar.xz/}
+		RECIPE_FILE=linux-cip-rt_${VERSION}.bb
+		if [ ! -f "${RECIPE_FILE}" ]; then
+			echo "Updating recipe to ${VERSION}"
+			git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+			SHASUM=${LAST_ENTRY/ */}
+			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
+			git add ${RECIPE_FILE}
+		fi
 	fi
 done
 
-- 
2.43.0


