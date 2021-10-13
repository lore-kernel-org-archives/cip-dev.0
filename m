Return-Path: <SRS0=5Q3z=PB=lists.cip-project.org=bounce+64572+6817+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A7C433F5
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B73360698
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B73360698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KBHRYY4521723xaAl2S53Jqx; Wed, 13 Oct 2021 06:40:59 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.8309.1634132458332717688
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:40:58 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 19DDes0f024982
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:40:54 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDerfM007799;
	Wed, 13 Oct 2021 15:40:54 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] swupdate: remove version 2021.04+isar-git
Date: Wed, 13 Oct 2021 15:40:53 +0200
Message-ID: <20211013134053.1400723-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Amr40v3Kjteo2po3k2Zihyqzx4520388AA=
Content-Type: multipart/mixed; boundary="XdFQc5kgV6EduRlsnsxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634132459;
 bh=TMH2SKgiBxCeFzAkbZVGXe9P/1Nj5EgX76Yknksdf+k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KcQxnsa+3P1nUOdVfV29j5Uo+DcbyfHhafjm+EOrBVD14UrO48ETbWVUwt0jaJYXgGM
 LvExaWK+ucscxXo1tcmNPdmXvuBP3zKUB/H3M5DXpojXoYP/YVOv1xf/YOUN6eK8ahZPs
 Wujb7wqGwMiH4F200lJ7yXznL6oTxZonM8c=
Message-ID: <20211013134053.jgmnvp2pZs4oX6c-EGQzWGEgFKEbKyTzqwO5rJHo88A@z>

--XdFQc5kgV6EduRlsnsxL
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This version is replace by 2021.04-1+debian-gbp.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/kconfig-snippets.bbclass              | 90 -------------------
 classes/swupdate-config.bbclass               | 81 -----------------
 conf/distro/cip-core-bullseye.conf            |  1 -
 conf/distro/cip-core-buster.conf              |  1 -
 .../swupdate/files/debian/changelog.tmpl      |  6 --
 recipes-core/swupdate/files/debian/compat     |  1 -
 .../swupdate/files/debian/control.tmpl        | 15 ----
 recipes-core/swupdate/files/debian/copyright  | 36 --------
 recipes-core/swupdate/files/debian/rules.tmpl | 31 -------
 .../swupdate/files/debian/swupdate.examples   |  2 -
 .../swupdate/files/debian/swupdate.install    |  2 -
 .../swupdate/files/debian/swupdate.manpages   |  5 --
 .../swupdate/files/debian/swupdate.tmpfile    |  2 -
 recipes-core/swupdate/files/debian/watch      | 12 ---
 recipes-core/swupdate/files/postinst          |  2 -
 recipes-core/swupdate/files/swupdate.cfg      |  6 --
 .../swupdate/files/swupdate.service.example   | 11 ---
 .../swupdate/files/swupdate.socket.example    | 11 ---
 .../swupdate/files/swupdate.socket.tmpl       | 13 ---
 .../swupdate/files/swupdate_defconfig         | 83 -----------------
 .../swupdate_defconfig_efibootguard.snippet   |  3 -
 .../files/swupdate_defconfig_lua.snippet      |  2 -
 .../swupdate_defconfig_luahandler.snippet     |  4 -
 .../files/swupdate_defconfig_mtd.snippet      |  1 -
 .../files/swupdate_defconfig_u-boot.snippet   |  3 -
 .../files/swupdate_defconfig_ubi.snippet      |  6 --
 recipes-core/swupdate/swupdate.bb             | 48 ----------
 27 files changed, 478 deletions(-)
 delete mode 100644 classes/kconfig-snippets.bbclass
 delete mode 100644 classes/swupdate-config.bbclass
 delete mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/compat
 delete mode 100644 recipes-core/swupdate/files/debian/control.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/copyright
 delete mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.install
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
 delete mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
 delete mode 100644 recipes-core/swupdate/files/debian/watch
 delete mode 100644 recipes-core/swupdate/files/postinst
 delete mode 100644 recipes-core/swupdate/files/swupdate.cfg
 delete mode 100644 recipes-core/swupdate/files/swupdate.service.example
 delete mode 100644 recipes-core/swupdate/files/swupdate.socket.example
 delete mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
 delete mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
 delete mode 100644 recipes-core/swupdate/swupdate.bb

diff --git a/classes/kconfig-snippets.bbclass b/classes/kconfig-snippets.bbclass
deleted file mode 100644
index d754654..0000000
--- a/classes/kconfig-snippets.bbclass
+++ /dev/null
@@ -1,90 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Christian Storm <christian.storm@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-KCONFIG_SNIPPETS = ""
-
-# The following function defines the kconfig snippet system
-# with automatich debian dependency injection
-#
-# To define a feature set, the user has to define the following
-# variable to an empty string:
-#
-# KFEATURE_featurename = ""
-#
-# Then, required additions to the variables can be defined:
-#
-# KFEATURE_featurename[KCONFIG_SNIPPETS] = "file://snippet-file-name.snippet"
-# KFEATURE_featurename[SRC_URI] = "file://required-file.txt"
-# KFEATURE_featurename[DEPENDS] = "deb-pkg1 deb-pkg2 deb-pkg3"
-# KFEATURE_featurename[DEBIAN_DEPENDS] = "deb-pkg1"
-# KFEATURE_featurename[BUILD_DEB_DEPENDS] = "deb-pkg1,deb-pkg2,deb-pkg3"
-
-# The 'KCONFIG_SNIPPETS' flag gives a list of URI entries, where only
-# file:// is supported. These snippets are appended to the DEFCONFIG file.
-#
-# Features can depend on other features via the following mechanism:
-#
-# KFEATURE_DEPS[feature1] = "feature2"
-
-python () {
-    requested_features = d.getVar("KFEATURES", True) or ""
-
-    features = set(requested_features.split())
-    old_features = set()
-    feature_deps = d.getVarFlags("KFEATURE_DEPS") or {}
-    while old_features != features:
-        diff_features = old_features.symmetric_difference(features)
-        old_features = features.copy()
-        for i in diff_features:
-            features.update(feature_deps.get(i, "").split())
-
-    for f in sorted(features):
-        bb.debug(2, "Feature: " + f)
-        varname = "KFEATURE_" + f
-        dummyvar = d.getVar(varname, False)
-        if dummyvar == None:
-            bb.error("Feature var " + f + " must be defined with needed flags.")
-        else:
-            feature_flags = d.getVarFlags(varname)
-            for feature_varname in sorted(feature_flags):
-                if feature_flags.get(feature_varname, "") != "":
-                    sep = " "
-
-                    # Required to add KCONFIG_SNIPPETS to SRC_URI here,
-                    # because 'SRC_URI += "${KCONFIG_SNIPPETS}"' would
-                    # conflict with SRC_APT feature.
-                    if feature_varname == "KCONFIG_SNIPPETS":
-                        d.appendVar('SRC_URI',
-                            " " + feature_flags[feature_varname].strip())
-
-                    # BUILD_DEP_DEPENDS and DEBIAN_DEPENDS is ',' separated
-                    # Only add ',' if there is already something there
-                    if feature_varname in ["BUILD_DEB_DEPENDS",
-                                           "DEBIAN_DEPENDS"]:
-                        sep = "," if d.getVar(feature_varname) else ""
-
-                    d.appendVar(feature_varname,
-                        sep + feature_flags[feature_varname].strip())
-}
-
-# DEFCONFIG must be a predefined bitbake variable and the corresponding file
-# must exist in the WORKDIR.
-# The resulting generated config is the same file suffixed with ".gen"
-
-do_prepare_build_prepend() {
-        sh -x
-        GENCONFIG="${WORKDIR}/${DEFCONFIG}".gen
-        rm -f "$GENCONFIG"
-        cp "${WORKDIR}/${DEFCONFIG}" "$GENCONFIG"
-        for CONFIG_SNIPPET in $(echo "${KCONFIG_SNIPPETS}" | sed 's#file://##g')
-        do
-                cat ${WORKDIR}/$CONFIG_SNIPPET >> "$GENCONFIG"
-        done
-}
diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
deleted file mode 100644
index 1d57ce1..0000000
--- a/classes/swupdate-config.bbclass
+++ /dev/null
@@ -1,81 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Christian Storm <christian.storm@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-# This class manages the config snippets together with their dependencies
-# to build SWUpdate
-
-inherit kconfig-snippets
-
-BUILD_DEB_DEPENDS = " \
-    zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
-    python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev, pkg-config"
-
-KFEATURE_lua = ""
-KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
-KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
-
-KFEATURE_luahandler = ""
-KFEATURE_luahandler[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_luahandler.snippet"
-KFEATURE_luahandler[SRC_URI] = "${@ 'file://${SWUPDATE_LUASCRIPT}' \
-                                  if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '0' else '' }"
-KFEATURE_DEPS = ""
-KFEATURE_DEPS[luahandler] = "lua"
-
-KFEATURE_efibootguard = ""
-KFEATURE_efibootguard[BUILD_DEB_DEPENDS] = "efibootguard-dev"
-KFEATURE_efibootguard[DEBIAN_DEPENDS] = ""
-KFEATURE_efibootguard[DEPENDS] = "efibootguard-dev"
-KFEATURE_efibootguard[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_efibootguard.snippet"
-
-KFEATURE_mtd = ""
-KFEATURE_mtd[BUILD_DEB_DEPENDS] = "libmtd-dev"
-KFEATURE_mtd[DEPENDS] = "mtd-utils"
-KFEATURE_mtd[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_mtd.snippet"
-
-KFEATURE_ubi = ""
-KFEATURE_ubi[BUILD_DEB_DEPENDS] = "libubi-dev"
-KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
-
-KFEATURE_DEPS[ubi] = "mtd"
-
-KFEATURE_u-boot = ""
-KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
-# we need u-boot-${MACHINE}-config for fw_env.config
-# only custom build u-boot provides this package
-# for u-boot provided by debian u-boot-tools provides
-# example configurations at /usr/share/doc/u-boot-tools/examples
-KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
-                                          if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1" \
-                                          else 'libubootenv0.1'}"
-KFEATURE_u-boot[DEPENDS] = "${@ 'libubootenv u-boot-${MACHINE}-config' \
-                                          if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1" \
-                                          else 'libubootenv'}"
-KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
-
-def get_bootloader_featureset(d):
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
-    if bootloader == "efibootguard":
-        return "efibootguard"
-    if bootloader == "u-boot":
-        return "u-boot"
-    return ""
-
-SWUPDATE_KFEATURES ??= ""
-KFEATURES = "${SWUPDATE_KFEATURES}"
-KFEATURES += "${@get_bootloader_featureset(d)}"
-
-# Astonishingly, as an anonymous python function, SWUPDATE_BOOTLOADER is always None
-# one time before it gets set. So the following must be a task.
-python do_check_bootloader () {
-    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
-    if not bootloader in ["efibootguard", "u-boot"]:
-        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
-}
-addtask check_bootloader before do_fetch
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 9357b6c..38014b4 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -14,4 +14,3 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
-PREFERRED_VERSION_swupdate ?= "2021.04-1+debian-gbp"
diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index 61fcb41..c5cb39c 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -14,4 +14,3 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
-PREFERRED_VERSION_swupdate ?= "2021.4-git+isar"
diff --git a/recipes-core/swupdate/files/debian/changelog.tmpl b/recipes-core/swupdate/files/debian/changelog.tmpl
deleted file mode 100644
index 81087d3..0000000
--- a/recipes-core/swupdate/files/debian/changelog.tmpl
+++ /dev/null
@@ -1,6 +0,0 @@
-swupdate (${PV}) unstable; urgency=medium
-
-  * SWUpdate
-
- --  Christian Storm <christian.storm@siemens.com>  Thu, 31 Jan 2019 15:23:56 +0100
-
diff --git a/recipes-core/swupdate/files/debian/compat b/recipes-core/swupdate/files/debian/compat
deleted file mode 100644
index b4de394..0000000
--- a/recipes-core/swupdate/files/debian/compat
+++ /dev/null
@@ -1 +0,0 @@
-11
diff --git a/recipes-core/swupdate/files/debian/control.tmpl b/recipes-core/swupdate/files/debian/control.tmpl
deleted file mode 100644
index 2b92850..0000000
--- a/recipes-core/swupdate/files/debian/control.tmpl
+++ /dev/null
@@ -1,15 +0,0 @@
-Source: swupdate
-Section: embedded
-Priority: optional
-Maintainer: Stefano Babic <sbabic@denx.de>
-Build-Depends: ${BUILD_DEB_DEPENDS}
-Standards-Version: 4.2.1
-Homepage: http://sbabic.github.io/swupdate
-
-Package: swupdate
-Architecture: any
-Depends: ${DEBIAN_DEPENDS}
-Description: reliable way to update an embedded system
- This project is thought to help to update an embedded system from a storage media or from network.
- However, it should be mainly considered as a framework, where further protocols or installers
- (in SWUpdate they are called handlers) can be easily added to the application.
diff --git a/recipes-core/swupdate/files/debian/copyright b/recipes-core/swupdate/files/debian/copyright
deleted file mode 100644
index f920942..0000000
--- a/recipes-core/swupdate/files/debian/copyright
+++ /dev/null
@@ -1,36 +0,0 @@
-Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
-Upstream-Name: swupdate
-Maintainer: Stefano Babic <sbabic@denx.de>
-Source: http://github.com/sbabic/swupdate
-
-Files: *
-Copyright: 2014-2017 Stefano Babic <sbabic@denx.de>
-
-License: GPL-2 with OpenSSL exception
- This package is free software; you can redistribute it and/or modify
- it under the terms of the GNU General Public License as published by
- the Free Software Foundation; either version 2 of the License, or
- (at your option) any later version.
- .
- In addition, as a special exception, the author of this
- program gives permission to link the code of its
- release with the OpenSSL project's "OpenSSL" library (or
- with modified versions of it that use the same license as
- the "OpenSSL" library), and distribute the linked
- executables. You must obey the GNU General Public
- License in all respects for all of the code used other
- than "OpenSSL".  If you modify this file, you may extend
- this exception to your version of the file, but you are
- not obligated to do so.  If you do not wish to do so,
- delete this exception statement from your version.
- .
- This package is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
- .
- You should have received a copy of the GNU General Public License
- along with this program. If not, see <https://www.gnu.org/licenses/>
- .
- On Debian systems, the complete text of the GNU General
- Public License version 2 can be found in "/usr/share/common-licenses/GPL-2".
diff --git a/recipes-core/swupdate/files/debian/rules.tmpl b/recipes-core/swupdate/files/debian/rules.tmpl
deleted file mode 100755
index ec83a88..0000000
--- a/recipes-core/swupdate/files/debian/rules.tmpl
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/usr/bin/make -f
-
-ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
-export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
-export PKG_CONFIG_PATH=/usr/lib/$(DEB_HOST_GNU_TYPE)/pkgconfig
-export CC=$(DEB_HOST_GNU_TYPE)-gcc
-export LD=$(DEB_HOST_GNU_TYPE)-gcc
-endif
-
-export DH_VERBOSE = 1
-
-export DEB_BUILD_MAINT_OPTIONS = hardening=+bindnow
-
-documentation: configure
-	make man
-
-configure:
-	make ${DEFCONFIG}
-
-build: documentation configure
-	dh $@
-
-%:
-	echo $@
-	dh $@
-
-override_dh_installchangelogs:
-	true
-
-override_dh_installdocs:
-	true
diff --git a/recipes-core/swupdate/files/debian/swupdate.examples b/recipes-core/swupdate/files/debian/swupdate.examples
deleted file mode 100644
index c257b75..0000000
--- a/recipes-core/swupdate/files/debian/swupdate.examples
+++ /dev/null
@@ -1,2 +0,0 @@
-examples/configuration
-examples/description
diff --git a/recipes-core/swupdate/files/debian/swupdate.install b/recipes-core/swupdate/files/debian/swupdate.install
deleted file mode 100644
index 8957cc6..0000000
--- a/recipes-core/swupdate/files/debian/swupdate.install
+++ /dev/null
@@ -1,2 +0,0 @@
-swupdate usr/bin
-swupdate.cfg /etc
diff --git a/recipes-core/swupdate/files/debian/swupdate.manpages b/recipes-core/swupdate/files/debian/swupdate.manpages
deleted file mode 100644
index c3438e0..0000000
--- a/recipes-core/swupdate/files/debian/swupdate.manpages
+++ /dev/null
@@ -1,5 +0,0 @@
-doc/build/man/swupdate.1
-doc/build/man/client.1
-doc/build/man/sendtohawkbit.1
-doc/build/man/hawkbitcfg.1
-doc/build/man/progress.1
diff --git a/recipes-core/swupdate/files/debian/swupdate.tmpfile b/recipes-core/swupdate/files/debian/swupdate.tmpfile
deleted file mode 100644
index 4743672..0000000
--- a/recipes-core/swupdate/files/debian/swupdate.tmpfile
+++ /dev/null
@@ -1,2 +0,0 @@
-X /tmp/datadst
-X /tmp/scripts
diff --git a/recipes-core/swupdate/files/debian/watch b/recipes-core/swupdate/files/debian/watch
deleted file mode 100644
index bc4c53e..0000000
--- a/recipes-core/swupdate/files/debian/watch
+++ /dev/null
@@ -1,12 +0,0 @@
-# Example watch control file for uscan
-# Rename this file to "watch" and then you can run the "uscan" command
-# to check for upstream updates and more.
-# See uscan(1) for format
-
-# Compulsory line, this is a version 4 file
-version=4
-
-# GitHub hosted projects
-opts="filenamemangle="s%(?:.*?)?v?(\d[\d.]*)\.tar\.gz%<project>-$1.tar.gz%" \
-   https://github.com/<user>/swupdate/tags \
-   (?:.*?/)?v?(\d[\d.]*)\.tar\.gz debian uupdate
diff --git a/recipes-core/swupdate/files/postinst b/recipes-core/swupdate/files/postinst
deleted file mode 100644
index f15ac10..0000000
--- a/recipes-core/swupdate/files/postinst
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-deb-systemd-helper enable swupdate.socket || true
diff --git a/recipes-core/swupdate/files/swupdate.cfg b/recipes-core/swupdate/files/swupdate.cfg
deleted file mode 100644
index e0222f1..0000000
--- a/recipes-core/swupdate/files/swupdate.cfg
+++ /dev/null
@@ -1,6 +0,0 @@
-globals :
-{
-    verbose = true;
-    loglevel = 10;
-    syslog = false;
-};
diff --git a/recipes-core/swupdate/files/swupdate.service.example b/recipes-core/swupdate/files/swupdate.service.example
deleted file mode 100644
index d0b821e..0000000
--- a/recipes-core/swupdate/files/swupdate.service.example
+++ /dev/null
@@ -1,11 +0,0 @@
-[Unit]
-Description=SWUpdate daemon
-Documentation=https://github.com/sbabic/swupdate
-
-[Service]
-Type=simple
-ExecStart=/usr/bin/swupdate -f /etc/swupdate.cfg
-KillMode=mixed
-
-[Install]
-WantedBy=multi-user.target
diff --git a/recipes-core/swupdate/files/swupdate.socket.example b/recipes-core/swupdate/files/swupdate.socket.example
deleted file mode 100644
index 2b75671..0000000
--- a/recipes-core/swupdate/files/swupdate.socket.example
+++ /dev/null
@@ -1,11 +0,0 @@
-[Unit]
-Description=SWUpdate socket listener
-Documentation=https://github.com/sbabic/swupdate
-Documentation=https://sbabic.github.io/swupdate
-
-[Socket]
-ListenStream=/tmp/sockinstctrl
-ListenStream=/tmp/swupdateprog
-
-[Install]
-WantedBy=sockets.target
diff --git a/recipes-core/swupdate/files/swupdate.socket.tmpl b/recipes-core/swupdate/files/swupdate.socket.tmpl
deleted file mode 100644
index 8e7fc1d..0000000
--- a/recipes-core/swupdate/files/swupdate.socket.tmpl
+++ /dev/null
@@ -1,13 +0,0 @@
-[Unit]
-Description=SWUpdate socket listener
-Documentation=https://github.com/sbabic/swupdate
-Documentation=https://sbabic.github.io/swupdate
-
-[Socket]
-SocketUser=${SWUPDATE_SOCKET_OWNER}
-SocketGroup=root
-ListenStream=/tmp/sockinstctrl
-ListenStream=/tmp/swupdateprog
-
-[Install]
-WantedBy=sockets.target
diff --git a/recipes-core/swupdate/files/swupdate_defconfig b/recipes-core/swupdate/files/swupdate_defconfig
deleted file mode 100644
index 9ae7cb5..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig
+++ /dev/null
@@ -1,83 +0,0 @@
-#
-# Automatically generated file; DO NOT EDIT.
-# Swupdate Configuration
-#
-CONFIG_HAVE_DOT_CONFIG=y
-
-#
-# Swupdate Settings
-#
-
-#
-# General Configuration
-#
-# CONFIG_CURL is not set
-# CONFIG_CURL_SSL is not set
-CONFIG_SYSTEMD=y
-CONFIG_SCRIPTS=y
-# CONFIG_HW_COMPATIBILITY is not set
-CONFIG_SW_VERSIONS_FILE="/etc/sw-versions"
-
-#
-# Socket Paths
-#
-CONFIG_SOCKET_CTRL_PATH="/tmp/sockinstctrl"
-CONFIG_SOCKET_PROGRESS_PATH="/tmp/swupdateprog"
-CONFIG_SOCKET_REMOTE_HANDLER_DIRECTORY="/tmp/"
-# CONFIG_MTD is not set
-# CONFIG_LUA is not set
-# CONFIG_LUAPKG is not set
-# CONFIG_FEATURE_SYSLOG is not set
-
-#
-# Build Options
-#
-CONFIG_CROSS_COMPILE=""
-CONFIG_SYSROOT=""
-CONFIG_EXTRA_CFLAGS=""
-CONFIG_EXTRA_LDFLAGS=""
-CONFIG_EXTRA_LDLIBS=""
-
-#
-# Debugging Options
-#
-# CONFIG_DEBUG is not set
-# CONFIG_WERROR is not set
-# CONFIG_NOCLEANUP is not set
-# CONFIG_BOOTLOADER_EBG is not set
-# CONFIG_UBOOT is not set
-# CONFIG_BOOTLOADER_NONE is not set
-# CONFIG_BOOTLOADER_GRUB is not set
-# CONFIG_DOWNLOAD is not set
-# CONFIG_DOWNLOAD_SSL is not set
-# CONFIG_CHANNEL_CURL is not set
-# CONFIG_HASH_VERIFY=y
-# CONFIG_SIGNED_IMAGES is not set
-# CONFIG_ENCRYPTED_IMAGES is not set
-# CONFIG_SURICATTA is not set
-# CONFIG_WEBSERVER is not set
-CONFIG_GUNZIP=y
-
-#
-# Parser Features
-#
-CONFIG_LIBCONFIG=y
-CONFIG_PARSERROOT=""
-# CONFIG_JSON is not set
-# CONFIG_LUAEXTERNAL is not set
-# CONFIG_SETEXTPARSERNAME is not set
-# CONFIG_SETSWDESCRIPTION is not set
-
-#
-# Image Handlers
-#
-CONFIG_RAW=y
-# CONFIG_LUASCRIPTHANDLER is not set
-# CONFIG_SHELLSCRIPTHANDLER is not set
-# CONFIG_HANDLER_IN_LUA is not set
-# CONFIG_EMBEDDED_LUA_HANDLER is not set
-# CONFIG_EMBEDDED_LUA_HANDLER_SOURCE is not set
-CONFIG_ARCHIVE=y
-# CONFIG_REMOTE_HANDLER is not set
-# CONFIG_SWUFORWARDER_HANDLER is not set
-# CONFIG_BOOTLOADERHANDLER is not set
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet b/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
deleted file mode 100644
index 8e3688c..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_BOOTLOADER_NONE=n
-CONFIG_BOOTLOADER_EBG=y
-CONFIG_BOOTLOADERHANDLER=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet b/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
deleted file mode 100644
index b39f9df..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_LUA=y
-CONFIG_LUAPKG="lua53"
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet b/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
deleted file mode 100644
index b4a2de8..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
+++ /dev/null
@@ -1,4 +0,0 @@
-CONFIG_LUASCRIPTHANDLER=y
-CONFIG_HANDLER_IN_LUA=y
-CONFIG_EMBEDDED_LUA_HANDLER=y
-CONFIG_EMBEDDED_LUA_HANDLER_SOURCE="swupdate_handlers.lua"
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet b/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
deleted file mode 100644
index eab98dd..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_MTD=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet b/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
deleted file mode 100644
index 6b5832a..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_UBOOT=y
-CONFIG_UBOOT_FWENV="/etc/fw_env.config"
-CONFIG_BOOTLOADERHANDLER=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet b/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
deleted file mode 100644
index d1c7732..0000000
--- a/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
+++ /dev/null
@@ -1,6 +0,0 @@
-CONFIG_UBIVOL=y
-CONFIG_UBIATTACH=y
-CONFIG_UBIBLACKLIST=""
-CONFIG_UBIWHITELIST=""
-CONFIG_UBIVIDOFFSET=0
-CONFIG_CFI=y
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
deleted file mode 100644
index a29a797..0000000
--- a/recipes-core/swupdate/swupdate.bb
+++ /dev/null
@@ -1,48 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-DESCRIPTION = "swupdate utility for software updates"
-HOMEPAGE= "https://github.com/sbabic/swupdate"
-LICENSE = "GPL-2.0"
-LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
-
-SRC_URI = "git://github.com/sbabic/swupdate.git;branch=master;protocol=https"
-
-SRCREV = "47a1246435fdb78fba15cc969596994130412956"
-PV = "2021.4-git+isar"
-
-DEFCONFIG := "swupdate_defconfig"
-
-SRC_URI += "file://debian \
-            file://${DEFCONFIG} \
-            file://${PN}.cfg"
-
-DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
-
-inherit dpkg
-inherit swupdate-config
-
-KFEATURES += "luahandler"
-
-S = "${WORKDIR}/git"
-
-TEMPLATE_FILES = "debian/changelog.tmpl debian/control.tmpl debian/rules.tmpl"
-TEMPLATE_VARS += "BUILD_DEB_DEPENDS DEFCONFIG DEBIAN_DEPENDS"
-
-do_prepare_build() {
-    cp -R ${WORKDIR}/debian ${S}
-
-    install -m 0644 ${WORKDIR}/${PN}.cfg ${S}/swupdate.cfg
-    install -m 0644 ${WORKDIR}/${DEFCONFIG}.gen ${S}/configs/${DEFCONFIG}
-
-    if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore; then
-        echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
-    fi
-}
-- 
2.30.2


--XdFQc5kgV6EduRlsnsxL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6817): https://lists.cip-project.org/g/cip-dev/message/=
6817
Mute This Topic: https://lists.cip-project.org/mt/86287953/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XdFQc5kgV6EduRlsnsxL--
