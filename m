Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75191C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:36:40 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.10615.1639661796675434522
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 AfMd9Y9QPkuz1BjzbUGQ+VUWKHk2p/wA9oFGOY8GpjTg9aEHcWZroeP1K9cSHk5Q8wNdkOE+F1
 znZNWh7uKxpkmhwyKV6yVUyR4YKo5F0CtTbYAIWzetJzNEBakPvG7dG5HKvVhA8QVOXV+NPHog
 cqRLxU3rufEYzkiCKFMyJFkVrFEPeEZxUjTDKA9mxFeqs2VJSEHP+qZW3r43btUyOgPp/2QL/1
 HEpsaXiPgHVQRjahaOYuP6gS2vKLnJ804ZWskkIdn5YZcqpP9BQWWYFm0p57FnnzKTJnr5zdoM
 CqQsFS29zIxJfvrb3knS08WL
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69632702"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:36:38 -0800
IronPort-SDR: 
 7bHEuD3Dnl5hpXe6Zuo6inH9gB12ci1YbXqi52PHeASUc5gBKn7Gu0TVIHiZD5BJS30fpVtGS1
 DjpPpE88dUPnE0FP6QsVv8BmwiWFdzw72IRZeFRt6HuKh73pFiWpKVIzwmjBn7o3aYNGXgO899
 S8s0vmUmTfblZwA/otwuOwsNiJEMVvn/DEYwmy+AMX5QzI7TIVGRhsaVHUsinmri754FUDza4t
 2zACyw1wYriZrEiZmPujQ81xKqHlZrUTywzG3d0TznUgPVJdw9CWtjsoMCxzFur+4T+fOtuSzd
 p7A=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH v2 1/2] Drop stretch support
Date: Thu, 16 Dec 2021 19:06:16 +0530
Message-ID: <20211216133617.3403412-2-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:36:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7156

The generic profile of CIP Core started its work with buster,
stretch was only experimental for this layer.

Remove the support now.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 Kconfig                           |  4 ----
 conf/distro/cip-core-stretch.conf | 16 ----------------
 conf/machine/bbb.conf             |  4 ----
 kas/opt/stretch.yml               | 15 ---------------
 start-qemu.sh                     |  2 --
 5 files changed, 41 deletions(-)
 delete mode 100644 conf/distro/cip-core-stretch.conf
 delete mode 100644 kas/opt/stretch.yml

diff --git a/Kconfig b/Kconfig
index e69293f..8032ede 100644
--- a/Kconfig
+++ b/Kconfig
@@ -82,9 +82,6 @@ choice
 	prompt "Debian Release"
 	default DEBIAN_BUSTER
 
-config DEBIAN_STRETCH
-	bool "stretch (9)"
-
 config DEBIAN_BUSTER
 	bool "buster (10)"
 
@@ -95,7 +92,6 @@ endchoice
 
 config KAS_INCLUDE_DEBIAN
 	string
-	default "kas/opt/stretch.yml" if DEBIAN_STRETCH
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 
 comment "Image features"
diff --git a/conf/distro/cip-core-stretch.conf b/conf/distro/cip-core-stretch.conf
deleted file mode 100644
index 31900fa..0000000
--- a/conf/distro/cip-core-stretch.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require conf/distro/debian-stretch.conf
-require cip-core-common.inc
-
-PREFERRED_VERSION_linux-cip ?= "4.19.%"
-PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index a9b460e..6d8facb 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -11,8 +11,4 @@ DISTRO_ARCH = "armhf"
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "u-boot-omap"
 
-# On stretch, select U-Boot from buster which comes with distro-boot support
-DISTRO_APT_SOURCES_append_cip-core-stretch = " conf/distro/debian-buster.list"
-DISTRO_APT_PREFERENCES_cip-core-stretch += "conf/machine/preferences.bbb.conf"
-
 IMAGE_INSTALL += "u-boot-script"
diff --git a/kas/opt/stretch.yml b/kas/opt/stretch.yml
deleted file mode 100644
index 8e854c2..0000000
--- a/kas/opt/stretch.yml
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 10
-
-distro: cip-core-stretch
diff --git a/start-qemu.sh b/start-qemu.sh
index 4ab3861..489e0e0 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -33,8 +33,6 @@ fi
 if [ -z "${DISTRO_RELEASE}" ]; then
 	if grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
 		DISTRO_RELEASE="bullseye"
-	elif grep -s -q "DEBIAN_STRETCH: true" .config.yaml; then
-		DISTRO_RELEASE="stretch"
 	else
 		DISTRO_RELEASE="buster"
 	fi
-- 
2.25.1


