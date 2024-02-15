Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FAC48BEC
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 12:17:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.12405.1707999423017711577
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 04:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=iVM0DyLY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202402151217006e201990b27f543e56-fs2pi3@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202402151217006e201990b27f543e56
        for <cip-dev@lists.cip-project.org>;
        Thu, 15 Feb 2024 13:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wc0VpXcjVE9Ixf7wnTDXdbZ7aMNLzUaewwbzvnp3SGo=;
 b=iVM0DyLYT2lsz4VkzKvFPmGmBjfKJyZtXa3Bi3QtglH2SPak4nR7OpI9WzcRXCuK44NPum
 phdkyc5G3rvDxroNKkD5G5b3ukTy+Pt3aRJOBcNvsX0wWxcTjKl03+S2thp5jx8qxSGpuHWv
 wY9HNcj3FdnonposeD38LgzYGC4+A=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/3] add SWUpdate 2022.12
Date: Thu, 15 Feb 2024 13:14:06 +0100
Message-ID: <20240215121659.315309-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
References: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 12:17:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14992

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

SWUpdate changes the Suricatta lua api in 2023.05 to support
released legacy applications add version with the old api.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate-2022.12.yaml                 | 22 +++++
 ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
 .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 kas/opt/swupdate-2022.12.yaml
 create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
 create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb

diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
new file mode 100644
index 0000000..5dfe97a
--- /dev/null
+++ b/kas/opt/swupdate-2022.12.yaml
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
+# from the first wic partition
+
+header:
+  version: 14
+  includes:
+   - kas/opt/swupdate.yml
+
+local_conf_header:
+  swupdate-2022.12: |
+    PREFERRED_VERSION_swupdate = "2022.12%"
+    IMAGE_PREINSTALL += "cowsay"
diff --git a/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
new file mode 100644
index 0000000..dafbf6d
--- /dev/null
+++ b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
@@ -0,0 +1,27 @@
+From 451a80e1a98d7f6abd287215e7cac3929eebe025 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 15 Feb 2024 11:06:52 +0100
+Subject: [PATCH 1/2] Add option to enable surricatta-lua
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/rules | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/debian/rules b/debian/rules
+index 57da4ca7..a78d9ca8 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -56,6 +56,9 @@ endif
+ ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
+ endif
++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
++	echo CONFIG_SURICATTA_LUA=y              >> configs/debian_defconfig
++endif
+ ifneq (,$(LUA_VERSION))
+ 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
+ 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
new file mode 100644
index 0000000..4ff7419
--- /dev/null
+++ b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -0,0 +1,94 @@
+From 356ed7987a489f0259c0878117a4cac8e22ba8d5 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 16 Jun 2023 19:43:38 +0200
+Subject: [PATCH 2/2] d/patches: Add patch to add the build version to swupdate
+
+The build version is only set if build in a git repository
+this patch allows to use the version information stored in
+the Makefile.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
+ debian/patches/series                         |  1 +
+ debian/rules                                  |  2 +
+ 3 files changed, 49 insertions(+)
+ create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
+
+diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
+new file mode 100644
+index 00000000..480b67f5
+--- /dev/null
++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
+@@ -0,0 +1,46 @@
++From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
++Date: Sat, 17 Jun 2023 17:56:18 +0200
++Subject: [PATCH] Makefile.flags: Set version if git returns no information
++
++This set the swupdate version if build in a non git environment.
++E.g. pristine-tar build or from a release tarball.
++
++Also allows to set the EXTRAVERSION from the command line.
++
++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
++---
++ Makefile       | 2 +-
++ Makefile.flags | 3 +++
++ 2 files changed, 4 insertions(+), 1 deletion(-)
++
++diff --git a/Makefile b/Makefile
++index 9f6a33a6..56189688 100644
++--- a/Makefile
+++++ b/Makefile
++@@ -5,7 +5,7 @@
++ VERSION = 2022
++ PATCHLEVEL = 12
++ SUBLEVEL = 0
++-EXTRAVERSION =
+++EXTRAVERSION ?=
++ NAME =
++ 
++ IPCLIB_VERSION = 0.1
++diff --git a/Makefile.flags b/Makefile.flags
++index 2bec8468..f69ab5e8 100644
++--- a/Makefile.flags
+++++ b/Makefile.flags
++@@ -7,6 +7,9 @@
++ # ==========================================================================
++ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
++ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
+++ifeq (,$(SWU_VER))
+++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+++endif
++ export SWU_VER
++ SKIP_STRIP ?= n
++ 
++-- 
++2.39.2
++
+diff --git a/debian/patches/series b/debian/patches/series
+index 5638bbf5..12324569 100644
+--- a/debian/patches/series
++++ b/debian/patches/series
+@@ -1,3 +1,4 @@
+ Link-config-to-swupdate-www-path.diff
+ Replace-Font-Awesome-5-with-Fork-Awesome.diff
+ use-gcc-compiler.diff
++Makefile.flags-Set-version-if-git-returns-no-informa.diff
+diff --git a/debian/rules b/debian/rules
+index a78d9ca8..1bc70f84 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -17,6 +17,8 @@ export DH_WITH=--with lua
+ export HAVE_LUA=y
+ endif
+ 
++DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
++export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
+ BU_SWU=
+ ifeq (linux,$(DEB_HOST_ARCH_OS))
+ 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
new file mode 100644
index 0000000..fcccc2c
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
@@ -0,0 +1,41 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
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
+
+DEB_BUILD_PROFILES += "nodoc"
+DEB_BUILD_OPTIONS += "nodoc"
+
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2022.12:"
+
+SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
+
+SRCREV = "aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRC_URI += "file://0001-Add-option-to-enable-surricatta-lua.patch"
+SRC_URI += "file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
+
+ISAR_CROSS_COMPILE:bullseye = "0"
+
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
+
+# use backport build profile for bullseye
+DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
+CHANGELOG_V ?= "${PV}-${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.43.0


