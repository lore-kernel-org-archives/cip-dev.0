Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E0C54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:51:54 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.43025.1710766308663408370
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=l84DsxID;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240318125145537299b997ee204d11-88eytb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240318125145537299b997ee204d11
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 Mar 2024 13:51:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=14s/DfQn9u9IWLoBYXtO0SdbuC0IfP7IYrPmCQjCNM4=;
 b=l84DsxIDvH72nTKkmDbROAgucf2KB5XKtw3WckmvqNVXgg7qWMvAdsQEt6uMbP3+toiLHS
 AIMIKz0MQsI4NpaUmPrISguwNbrTS5/WTJP8VilAA5zLsnhIga2GKx+S9aA//JthM1cPDtab
 Xx+FCAWkKjxLUXkwfQm3sVvDm1eRU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/3] swupdate: Add recipe for 2023.12.1
Date: Mon, 18 Mar 2024 13:51:28 +0100
Message-ID: <20240318125144.634700-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
References: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15357

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an error with postinstall and also enables wfx by default

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...rate-build_profile-option-for-delta-.patch | 45 ++++++++++++++++
 ...install-Fix-path-for-debian-bullseye.patch | 24 +++++++++
 recipes-core/swupdate/swupdate_2023.12.bb     | 53 +++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
 create mode 100644 recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
 create mode 100644 recipes-core/swupdate/swupdate_2023.12.bb

diff --git a/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
new file mode 100644
index 0000000..ddb700b
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.12/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
@@ -0,0 +1,45 @@
+From 616b1d8f28da86a4897d13b16cd182eea55f7d83 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 15 Jun 2023 18:48:25 +0200
+Subject: [PATCH 1/2] d/rules: Add seperate build_profile option for delta
+ update
+
+Delta update need zchunk 1.3 to work on memory restricted
+devices. zchunk 1.3 is is not available in bullseye-backports
+and Debian bookworm(12).
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/control | 2 +-
+ debian/rules   | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/debian/control b/debian/control
+index 4f1b81a1..c5246aa6 100644
+--- a/debian/control
++++ b/debian/control
+@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
+                uuid-dev,
+                zlib1g-dev,
+                libzstd-dev,
+-               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
++               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
+                libp11-kit-dev <pkg.swupdate.p11>,
+                libwolfssl-dev (>= 5),
+                libmtd-dev [linux-any],
+diff --git a/debian/rules b/debian/rules
+index 4140257e..4e81bcae 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
+ else
+ 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
+ endif
+-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_DELTA=y >> configs/debian_defconfig
+ endif
+ ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch b/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
new file mode 100644
index 0000000..5f31827
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
@@ -0,0 +1,24 @@
+From 2b1f4d9344f4855cd646f87df5fba57f52cf6535 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 16 Nov 2023 16:40:19 +0100
+Subject: [PATCH 2/2] d/swupdate-www.install: Fix path for debian-bullseye
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/swupdate-www.install | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/debian/swupdate-www.install b/debian/swupdate-www.install
+index 7e3d95c6..9c6113cc 100644
+--- a/debian/swupdate-www.install
++++ b/debian/swupdate-www.install
+@@ -1,5 +1,5 @@
+ web-app/css          /usr/share/swupdate/www
+ web-app/images       /usr/share/swupdate/www
+-index.html           /usr/share/swupdate/www
++web-app/index.html   /usr/share/swupdate/www
+ web-app/js           /usr/share/swupdate/www
+ web-app/node_modules /usr/share/swupdate/www
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
new file mode 100644
index 0000000..1c140b0
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -0,0 +1,53 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+require swupdate.inc
+
+DEPENDS += "libebgenv-dev"
+DEPENDS += "libubootenv-dev"
+
+DEB_BUILD_PROFILES += "nodoc"
+DEB_BUILD_OPTIONS += "nodoc"
+
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
+
+SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
+
+SRCREV = "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
+
+# patches
+SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
+SRC_URI += "file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
+
+# suricatta wfx requires suricatta lua and the dependency
+# is not set automatically
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
+# add suricatta wfx
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
+
+# Disable cross for arm and arm64 on bullseye
+# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
+ISAR_CROSS_COMPILE:bullseye = "0"
+
+# add cross build and deactivate testing for arm based builds
+DEB_BUILD_PROFILES += "cross nocheck"
+
+# use backport build profile for bullseye
+DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
+
+CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.43.0


