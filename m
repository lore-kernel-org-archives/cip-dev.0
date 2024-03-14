Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F40AC54E6E
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 12:37:46 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.11365.1710419860745058019
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 05:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FYaLIfSJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202403141237380cfb4273b093565ba9-nb7tti@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202403141237380cfb4273b093565ba9
        for <cip-dev@lists.cip-project.org>;
        Thu, 14 Mar 2024 13:37:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cijXY6omqsz2IugJVBEZTpeTTJATPJtxZNpCnmy9pEQ=;
 b=FYaLIfSJN8TS7G29JXUwn7OqUWiTMz5T/PnQI5ZLqd22lhA2fQ4p75HhndaELRzhEFUqod
 cRsEOdxbrVy6flaj+vVi2vzhsQB5TuOjQ3jqNH2OU0tLQwf5ikfFgKgxb5iYtbs2FgdH/nml
 lzmx0d2FP08T4+ZfWewVInaGgQ6zk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 3/3] remove SWUpdate recipe 2023.05
Date: Thu, 14 Mar 2024 13:36:38 +0100
Message-ID: <20240314123736.1100948-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 12:37:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15305

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

replaced with SWUpdate 2023.12.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...rate-build_profile-option-for-delta-.patch | 45 ---------
 ...tch-to-add-the-build-version-to-swup.patch | 94 -------------------
 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ------
 ...install-Fix-path-for-debian-bullseye.patch | 24 -----
 recipes-core/swupdate/swupdate_2023.05.bb     | 53 -----------
 5 files changed, 246 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
 delete mode 100644 recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 delete mode 100644 recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
 delete mode 100644 recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
 delete mode 100644 recipes-core/swupdate/swupdate_2023.05.bb

diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
deleted file mode 100644
index 0d0fc0a..0000000
--- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
+++ /dev/null
@@ -1,45 +0,0 @@
-From 03d455be74d439c7e2eb849e5acdfb494afb3d7c Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Thu, 15 Jun 2023 18:48:25 +0200
-Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for delta
- update
-
-Delta update need zchunk 1.3 to work on memory restricted
-devices. zchunk 1.3 is is not available in bullseye-backports
-and Debian bookworm(12).
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/control | 2 +-
- debian/rules   | 2 +-
- 2 files changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/debian/control b/debian/control
-index a389b2a9..2f0c0053 100644
---- a/debian/control
-+++ b/debian/control
-@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
-                uuid-dev,
-                zlib1g-dev,
-                libzstd-dev,
--               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
-+               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
-                libp11-kit-dev <pkg.swupdate.p11>,
-                libwolfssl-dev (>= 5),
-                libmtd-dev [linux-any],
-diff --git a/debian/rules b/debian/rules
-index 3b1cc0f6..2c91677c 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
- else
- 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
- endif
--ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
-+ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_DELTA=y >> configs/debian_defconfig
- endif
- ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
--- 
-2.42.0
-
diff --git a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
deleted file mode 100644
index 8056818..0000000
--- a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
+++ /dev/null
@@ -1,94 +0,0 @@
-From ad714bc12b03c148aadb3523f87cc14d42a477b0 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 16 Jun 2023 19:43:38 +0200
-Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
-
-The build version is only set if build in a git repository
-this patch allows to use the version information stored in
-the Makefile.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
- debian/patches/series                         |  1 +
- debian/rules                                  |  2 +
- 3 files changed, 49 insertions(+)
- create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-
-diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-new file mode 100644
-index 00000000..7f964fb7
---- /dev/null
-+++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-@@ -0,0 +1,46 @@
-+From bc50744125e8686ec2eb7e5676522da98e51601f Mon Sep 17 00:00:00 2001
-+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-+Date: Sat, 17 Jun 2023 17:56:18 +0200
-+Subject: [PATCH] Makefile.flags: Set version if git returns no information
-+
-+This set the swupdate version if build in a non git environment.
-+E.g. pristine-tar build or from a release tarball.
-+
-+Also allows to set the EXTRAVERSION from the command line.
-+
-+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-+---
-+ Makefile       | 2 +-
-+ Makefile.flags | 3 +++
-+ 2 files changed, 4 insertions(+), 1 deletion(-)
-+
-+diff --git a/Makefile b/Makefile
-+index 09d03a34..1004945c 100644
-+--- a/Makefile
-++++ b/Makefile
-+@@ -5,7 +5,7 @@
-+ VERSION = 2023
-+ PATCHLEVEL = 05
-+ SUBLEVEL = 0
-+-EXTRAVERSION =
-++EXTRAVERSION ?=
-+ NAME =
-+ 
-+ IPCLIB_VERSION = 0.1
-+diff --git a/Makefile.flags b/Makefile.flags
-+index 2a021c89..8eada8fc 100644
-+--- a/Makefile.flags
-++++ b/Makefile.flags
-+@@ -7,6 +7,9 @@
-+ # ==========================================================================
-+ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
-+ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
-++ifeq (,$(SWU_VER))
-++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
-++endif
-+ export SWU_VER
-+ SKIP_STRIP ?= n
-+ 
-+-- 
-+2.39.2
-+
-diff --git a/debian/patches/series b/debian/patches/series
-index 5638bbf5..12324569 100644
---- a/debian/patches/series
-+++ b/debian/patches/series
-@@ -1,3 +1,4 @@
- Link-config-to-swupdate-www-path.diff
- Replace-Font-Awesome-5-with-Fork-Awesome.diff
- use-gcc-compiler.diff
-+Makefile.flags-Set-version-if-git-returns-no-informa.diff
-diff --git a/debian/rules b/debian/rules
-index 2c91677c..5d72987c 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -17,6 +17,8 @@ export DH_WITH=,lua
- export HAVE_LUA=y
- endif
- 
-+DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
-+export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
- BU_SWU=
- ifeq (linux,$(DEB_HOST_ARCH_OS))
- 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
--- 
-2.42.0
-
diff --git a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
deleted file mode 100644
index 87c60d7..0000000
--- a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From fae97f0e23f945c1ab6e767451cda1d2798aa348 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 16 Jun 2023 20:32:38 +0200
-Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
-
-Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
-suricattawfx lua module.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/debian/rules b/debian/rules
-index 5d72987c..d7ff5510 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -58,6 +58,9 @@ endif
- ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
- endif
-+ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
-+endif
- ifneq (,$(LUA_VERSION))
- 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
- 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
--- 
-2.42.0
-
diff --git a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
deleted file mode 100644
index b2d831d..0000000
--- a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
+++ /dev/null
@@ -1,24 +0,0 @@
-From f2184e7573e705bad408cf1422599b967773d48e Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Thu, 16 Nov 2023 16:40:19 +0100
-Subject: [PATCH 4/4] d/swupdate-www.install: Fix path for debian-bullseye
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/swupdate-www.install | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/debian/swupdate-www.install b/debian/swupdate-www.install
-index 7e3d95c6..9c6113cc 100644
---- a/debian/swupdate-www.install
-+++ b/debian/swupdate-www.install
-@@ -1,5 +1,5 @@
- web-app/css          /usr/share/swupdate/www
- web-app/images       /usr/share/swupdate/www
--index.html           /usr/share/swupdate/www
-+web-app/index.html   /usr/share/swupdate/www
- web-app/js           /usr/share/swupdate/www
- web-app/node_modules /usr/share/swupdate/www
--- 
-2.42.0
-
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
deleted file mode 100644
index d1fe1fa..0000000
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ /dev/null
@@ -1,53 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2023
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-inherit dpkg
-
-require swupdate.inc
-
-DEPENDS += "libebgenv-dev"
-
-DEB_BUILD_PROFILES += "nodoc"
-DEB_BUILD_OPTIONS += "nodoc"
-
-FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
-
-SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
-SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
-
-SRCREV_debian = "78cb6f20319d2b911e170eea5305f2cf0bd33030"
-SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
-
-# patches
-SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
-            file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
-            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
-SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
-
-# suricatta wfx requires suricatta lua and the dependency
-# is not set automatically
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
-# add suricatta wfx
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
-
-# Disable cross for arm and arm64 on bullseye
-# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
-ISAR_CROSS_COMPILE:bullseye = "0"
-
-# use backport build profile for bullseye
-DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
-
-CHANGELOG_V ?= "${PV}+cip-${SRCREV_upstream}"
-
-do_prepare_build() {
-    deb_add_changelog
-    cd ${WORKDIR}
-    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
-}
-- 
2.43.0


