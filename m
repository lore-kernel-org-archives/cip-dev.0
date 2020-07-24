Return-Path: <SRS0=nDDe=BD=lists.cip-project.org=bounce+64572+5002+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA5C433E8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A62D20737
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Jj6eNCQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A62D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5002+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id smL9YY4521723xVC65X1Ibvn; Fri, 24 Jul 2020 07:52:32 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.7794.1595602349472871470
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 07:52:30 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 06OEqR3O020752
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 16:52:27 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06OEqPii031602;
	Fri, 24 Jul 2020 16:52:26 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 3/5] recipes-core: add swupdate
Date: Fri, 24 Jul 2020 16:52:23 +0200
Message-Id: <20200724145225.7895-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200724145225.7895-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200724145225.7895-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EwduKVJiCBuJ7XMjGWTZs76Wx4520388AA=
Content-Type: multipart/mixed; boundary="xl52Xrh0MCOZaS9dmh8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602352;
 bh=D5Nu7HsXfUZ90/6N9EH1a0srw+yT2CQpc0YMR89RcKs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Jj6eNCQdc8rltqkn0ZWgxrcP1bhpaeiDzugLsN6aeUk/fLLHg/Gbn+J/PnPOlGNduuo
 VHBrbJoHydNd09L4OZBxvMsd1CNxUO0NA2YLBvE5VbRKAQr7H0z6BXHmmLc/MZ4G88jHv
 7zub4BRXaJWA/8qYMwvhU7xWEKEv7KdJ7O0=

--xl52Xrh0MCOZaS9dmh8i
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add swupdate for A/B software updates. Currently the Round Robin
handler in lua supports efibootguard as bootloader. The u-boot
implementation is outstanding.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/kconfig-snippets.bbclass              |  90 ++++
 classes/swupdate-config.bbclass               |  76 +++
 classes/swupdate-img.bbclass                  |  75 +++
 .../swupdate/files/debian/changelog.tmpl      |   6 +
 recipes-core/swupdate/files/debian/compat     |   1 +
 .../swupdate/files/debian/control.tmpl        |  15 +
 recipes-core/swupdate/files/debian/copyright  |  36 ++
 recipes-core/swupdate/files/debian/rules.tmpl |  30 ++
 .../swupdate/files/debian/swupdate.examples   |   2 +
 .../swupdate/files/debian/swupdate.install    |   2 +
 .../swupdate/files/debian/swupdate.manpages   |   5 +
 .../swupdate/files/debian/swupdate.tmpfile    |   2 +
 recipes-core/swupdate/files/debian/watch      |  12 +
 recipes-core/swupdate/files/postinst          |   2 +
 recipes-core/swupdate/files/swupdate.cfg      |   6 +
 .../swupdate/files/swupdate.service.example   |  11 +
 .../swupdate/files/swupdate.socket.example    |  11 +
 .../swupdate/files/swupdate.socket.tmpl       |  13 +
 .../swupdate/files/swupdate_defconfig         |  83 ++++
 .../swupdate_defconfig_efibootguard.snippet   |   3 +
 .../files/swupdate_defconfig_lua.snippet      |   2 +
 .../swupdate_defconfig_luahandler.snippet     |   4 +
 .../files/swupdate_defconfig_mtd.snippet      |   1 +
 .../files/swupdate_defconfig_u-boot.snippet   |   3 +
 .../files/swupdate_defconfig_ubi.snippet      |   6 +
 .../swupdate/files/swupdate_handlers.lua      | 453 ++++++++++++++++++
 recipes-core/swupdate/swupdate.bb             |  54 +++
 27 files changed, 1004 insertions(+)
 create mode 100644 classes/kconfig-snippets.bbclass
 create mode 100644 classes/swupdate-config.bbclass
 create mode 100644 classes/swupdate-img.bbclass
 create mode 100644 recipes-core/swupdate/files/debian/changelog.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/compat
 create mode 100644 recipes-core/swupdate/files/debian/control.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/copyright
 create mode 100755 recipes-core/swupdate/files/debian/rules.tmpl
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.examples
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.install
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.manpages
 create mode 100644 recipes-core/swupdate/files/debian/swupdate.tmpfile
 create mode 100644 recipes-core/swupdate/files/debian/watch
 create mode 100644 recipes-core/swupdate/files/postinst
 create mode 100644 recipes-core/swupdate/files/swupdate.cfg
 create mode 100644 recipes-core/swupdate/files/swupdate.service.example
 create mode 100644 recipes-core/swupdate/files/swupdate.socket.example
 create mode 100644 recipes-core/swupdate/files/swupdate.socket.tmpl
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
 create mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua
 create mode 100644 recipes-core/swupdate/swupdate.bb

diff --git a/classes/kconfig-snippets.bbclass b/classes/kconfig-snippets.bbclass
new file mode 100644
index 0000000..d754654
--- /dev/null
+++ b/classes/kconfig-snippets.bbclass
@@ -0,0 +1,90 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Christian Storm <christian.storm@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+KCONFIG_SNIPPETS = ""
+
+# The following function defines the kconfig snippet system
+# with automatich debian dependency injection
+#
+# To define a feature set, the user has to define the following
+# variable to an empty string:
+#
+# KFEATURE_featurename = ""
+#
+# Then, required additions to the variables can be defined:
+#
+# KFEATURE_featurename[KCONFIG_SNIPPETS] = "file://snippet-file-name.snippet"
+# KFEATURE_featurename[SRC_URI] = "file://required-file.txt"
+# KFEATURE_featurename[DEPENDS] = "deb-pkg1 deb-pkg2 deb-pkg3"
+# KFEATURE_featurename[DEBIAN_DEPENDS] = "deb-pkg1"
+# KFEATURE_featurename[BUILD_DEB_DEPENDS] = "deb-pkg1,deb-pkg2,deb-pkg3"
+
+# The 'KCONFIG_SNIPPETS' flag gives a list of URI entries, where only
+# file:// is supported. These snippets are appended to the DEFCONFIG file.
+#
+# Features can depend on other features via the following mechanism:
+#
+# KFEATURE_DEPS[feature1] = "feature2"
+
+python () {
+    requested_features = d.getVar("KFEATURES", True) or ""
+
+    features = set(requested_features.split())
+    old_features = set()
+    feature_deps = d.getVarFlags("KFEATURE_DEPS") or {}
+    while old_features != features:
+        diff_features = old_features.symmetric_difference(features)
+        old_features = features.copy()
+        for i in diff_features:
+            features.update(feature_deps.get(i, "").split())
+
+    for f in sorted(features):
+        bb.debug(2, "Feature: " + f)
+        varname = "KFEATURE_" + f
+        dummyvar = d.getVar(varname, False)
+        if dummyvar == None:
+            bb.error("Feature var " + f + " must be defined with needed flags.")
+        else:
+            feature_flags = d.getVarFlags(varname)
+            for feature_varname in sorted(feature_flags):
+                if feature_flags.get(feature_varname, "") != "":
+                    sep = " "
+
+                    # Required to add KCONFIG_SNIPPETS to SRC_URI here,
+                    # because 'SRC_URI += "${KCONFIG_SNIPPETS}"' would
+                    # conflict with SRC_APT feature.
+                    if feature_varname == "KCONFIG_SNIPPETS":
+                        d.appendVar('SRC_URI',
+                            " " + feature_flags[feature_varname].strip())
+
+                    # BUILD_DEP_DEPENDS and DEBIAN_DEPENDS is ',' separated
+                    # Only add ',' if there is already something there
+                    if feature_varname in ["BUILD_DEB_DEPENDS",
+                                           "DEBIAN_DEPENDS"]:
+                        sep = "," if d.getVar(feature_varname) else ""
+
+                    d.appendVar(feature_varname,
+                        sep + feature_flags[feature_varname].strip())
+}
+
+# DEFCONFIG must be a predefined bitbake variable and the corresponding file
+# must exist in the WORKDIR.
+# The resulting generated config is the same file suffixed with ".gen"
+
+do_prepare_build_prepend() {
+        sh -x
+        GENCONFIG="${WORKDIR}/${DEFCONFIG}".gen
+        rm -f "$GENCONFIG"
+        cp "${WORKDIR}/${DEFCONFIG}" "$GENCONFIG"
+        for CONFIG_SNIPPET in $(echo "${KCONFIG_SNIPPETS}" | sed 's#file://##g')
+        do
+                cat ${WORKDIR}/$CONFIG_SNIPPET >> "$GENCONFIG"
+        done
+}
diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
new file mode 100644
index 0000000..7ce51c5
--- /dev/null
+++ b/classes/swupdate-config.bbclass
@@ -0,0 +1,76 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Christian Storm <christian.storm@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# This class manages the config snippets together with their dependencies
+# to build SWUpdate
+
+inherit kconfig-snippets
+
+BUILD_DEB_DEPENDS = " \
+    zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
+    python-sphinx:native, dh-systemd, libsystemd-dev"
+
+KFEATURE_lua = ""
+KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
+KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
+
+KFEATURE_luahandler = ""
+KFEATURE_luahandler[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_luahandler.snippet"
+KFEATURE_luahandler[SRC_URI] = "file://${SWUPDATE_LUASCRIPT}"
+
+KFEATURE_DEPS = ""
+KFEATURE_DEPS[luahandler] = "lua"
+
+KFEATURE_efibootguard = ""
+KFEATURE_efibootguard[BUILD_DEB_DEPENDS] = "efibootguard-dev"
+KFEATURE_efibootguard[DEBIAN_DEPENDS] = "efibootguard-dev"
+KFEATURE_efibootguard[DEPENDS] = "efibootguard-dev"
+KFEATURE_efibootguard[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_efibootguard.snippet"
+
+KFEATURE_mtd = ""
+KFEATURE_mtd[BUILD_DEB_DEPENDS] = "libmtd-dev"
+KFEATURE_mtd[DEPENDS] = "mtd-utils"
+KFEATURE_mtd[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_mtd.snippet"
+
+KFEATURE_ubi = ""
+KFEATURE_ubi[BUILD_DEB_DEPENDS] = "libubi-dev"
+KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
+
+KFEATURE_DEPS[ubi] = "mtd"
+
+KFEATURE_u-boot = ""
+KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "u-boot-${MACHINE}-dev"
+KFEATURE_u-boot[DEBIAN_DEPENDS] = "u-boot-tools"
+KFEATURE_u-boot[DEPENDS] = "${U_BOOT}"
+KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
+
+SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
+
+def get_bootloader_featureset(d):
+    bootloader = d.getVar("BOOTLOADER", True) or ""
+    if bootloader == "efibootguard":
+        return "efibootguard"
+    if bootloader == "u-boot":
+        return "u-boot"
+    return ""
+
+SWUPDATE_KFEATURES ??= ""
+KFEATURES = "${SWUPDATE_KFEATURES}"
+KFEATURES += "${@get_bootloader_featureset(d)}"
+
+# Astonishingly, as an anonymous python function, BOOTLOADER is always None
+# one time before it gets set. So the following must be a task.
+python do_check_bootloader () {
+    bootloader = d.getVar("BOOTLOADER", True) or "None"
+    if not bootloader in ["efibootguard", "u-boot"]:
+        bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
+}
+addtask check_bootloader before do_fetch
+
diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
new file mode 100644
index 0000000..a21d6ec
--- /dev/null
+++ b/classes/swupdate-img.bbclass
@@ -0,0 +1,75 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Christian Storm <christian.storm@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+SWU_IMAGE_FILE ?= "${PN}-${DISTRO}-${MACHINE}.swu"
+SWU_DESCRIPTION_FILE ?= "sw-description"
+SWU_ADDITIONAL_FILES ?= ""
+SWU_SIGNED ?= ""
+SWU_SIGNATURE_EXT ?= "sig"
+SWU_SIGNATURE_TYPE ?= "rsa"
+
+IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+
+do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
+do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
+do_swupdate_image() {
+    rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
+    cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
+
+    # Create symlinks for files used in the update image
+    for file in ${SWU_ADDITIONAL_FILES}; do
+        if [ -e "${WORKDIR}/$file" ]; then
+            ln -s "${WORKDIR}/$file" "${WORKDIR}/swu/$file"
+        else
+            ln -s "${DEPLOY_DIR_IMAGE}/$file" "${WORKDIR}/swu/$file"
+        fi
+    done
+
+    # Prepare for signing
+    sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
+    if [ -n "$sign" ]; then
+        image_do_mounts
+        cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
+        test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
+
+        # Fill in file check sums
+        for file in ${SWU_ADDITIONAL_FILES}; do
+            sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
+                '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
+        done
+    fi
+
+    cd "${WORKDIR}/swu"
+    for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES}; do
+        echo "$file"
+        if [ -n "$sign" -a \
+             '${SWU_DESCRIPTION_FILE}' = "$file" ]; then
+            if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
+                sudo chroot ${BUILDCHROOT_DIR} /usr/bin/openssl dgst \
+                    -sha256 -sign '${PP_WORK}/dev.key' \
+                    '${PP_WORK}/swu/'"$file" \
+                        > '${WORKDIR}/swu/'"$file".'${SWU_SIGNATURE_EXT}'
+            elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
+                sudo chroot ${BUILDCHROOT_DIR} /usr/bin/openssl cms \
+                    -sign -in '${PP_WORK}/swu/'"$file" \
+                    -out '${WORKDIR}/swu/'"$file".'${SWU_SIGNATURE_EXT}' \
+                    -signer '${PP_WORK}/dev.crt' \
+                    -inkey '${PP_WORK}/dev.key' \
+                    -outform DER -nosmimecap -binary
+            fi
+            echo "$file".'${SWU_SIGNATURE_EXT}'
+        fi
+    done | cpio -ovL -H crc \
+        > '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'
+    cd -
+}
+
+addtask swupdate_image before do_build after do_copy_boot_files do_install_imager_deps do_transform_template
diff --git a/recipes-core/swupdate/files/debian/changelog.tmpl b/recipes-core/swupdate/files/debian/changelog.tmpl
new file mode 100644
index 0000000..81087d3
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/changelog.tmpl
@@ -0,0 +1,6 @@
+swupdate (${PV}) unstable; urgency=medium
+
+  * SWUpdate
+
+ --  Christian Storm <christian.storm@siemens.com>  Thu, 31 Jan 2019 15:23:56 +0100
+
diff --git a/recipes-core/swupdate/files/debian/compat b/recipes-core/swupdate/files/debian/compat
new file mode 100644
index 0000000..b4de394
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/compat
@@ -0,0 +1 @@
+11
diff --git a/recipes-core/swupdate/files/debian/control.tmpl b/recipes-core/swupdate/files/debian/control.tmpl
new file mode 100644
index 0000000..2b92850
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/control.tmpl
@@ -0,0 +1,15 @@
+Source: swupdate
+Section: embedded
+Priority: optional
+Maintainer: Stefano Babic <sbabic@denx.de>
+Build-Depends: ${BUILD_DEB_DEPENDS}
+Standards-Version: 4.2.1
+Homepage: http://sbabic.github.io/swupdate
+
+Package: swupdate
+Architecture: any
+Depends: ${DEBIAN_DEPENDS}
+Description: reliable way to update an embedded system
+ This project is thought to help to update an embedded system from a storage media or from network.
+ However, it should be mainly considered as a framework, where further protocols or installers
+ (in SWUpdate they are called handlers) can be easily added to the application.
diff --git a/recipes-core/swupdate/files/debian/copyright b/recipes-core/swupdate/files/debian/copyright
new file mode 100644
index 0000000..f920942
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/copyright
@@ -0,0 +1,36 @@
+Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
+Upstream-Name: swupdate
+Maintainer: Stefano Babic <sbabic@denx.de>
+Source: http://github.com/sbabic/swupdate
+
+Files: *
+Copyright: 2014-2017 Stefano Babic <sbabic@denx.de>
+
+License: GPL-2 with OpenSSL exception
+ This package is free software; you can redistribute it and/or modify
+ it under the terms of the GNU General Public License as published by
+ the Free Software Foundation; either version 2 of the License, or
+ (at your option) any later version.
+ .
+ In addition, as a special exception, the author of this
+ program gives permission to link the code of its
+ release with the OpenSSL project's "OpenSSL" library (or
+ with modified versions of it that use the same license as
+ the "OpenSSL" library), and distribute the linked
+ executables. You must obey the GNU General Public
+ License in all respects for all of the code used other
+ than "OpenSSL".  If you modify this file, you may extend
+ this exception to your version of the file, but you are
+ not obligated to do so.  If you do not wish to do so,
+ delete this exception statement from your version.
+ .
+ This package is distributed in the hope that it will be useful,
+ but WITHOUT ANY WARRANTY; without even the implied warranty of
+ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ GNU General Public License for more details.
+ .
+ You should have received a copy of the GNU General Public License
+ along with this program. If not, see <https://www.gnu.org/licenses/>
+ .
+ On Debian systems, the complete text of the GNU General
+ Public License version 2 can be found in "/usr/share/common-licenses/GPL-2".
diff --git a/recipes-core/swupdate/files/debian/rules.tmpl b/recipes-core/swupdate/files/debian/rules.tmpl
new file mode 100755
index 0000000..54cca57
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/rules.tmpl
@@ -0,0 +1,30 @@
+#!/usr/bin/make -f
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+export CC=$(DEB_HOST_GNU_TYPE)-gcc
+export LD=$(DEB_HOST_GNU_TYPE)-gcc
+endif
+
+export DH_VERBOSE = 1
+
+export DEB_BUILD_MAINT_OPTIONS = hardening=+bindnow
+
+documentation: configure
+	make man
+
+configure:
+	make ${DEFCONFIG}
+
+build: documentation configure
+	dh $@
+
+%:
+	echo $@
+	dh $@
+
+override_dh_installchangelogs:
+	true
+
+override_dh_installdocs:
+	true
diff --git a/recipes-core/swupdate/files/debian/swupdate.examples b/recipes-core/swupdate/files/debian/swupdate.examples
new file mode 100644
index 0000000..c257b75
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/swupdate.examples
@@ -0,0 +1,2 @@
+examples/configuration
+examples/description
diff --git a/recipes-core/swupdate/files/debian/swupdate.install b/recipes-core/swupdate/files/debian/swupdate.install
new file mode 100644
index 0000000..8957cc6
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/swupdate.install
@@ -0,0 +1,2 @@
+swupdate usr/bin
+swupdate.cfg /etc
diff --git a/recipes-core/swupdate/files/debian/swupdate.manpages b/recipes-core/swupdate/files/debian/swupdate.manpages
new file mode 100644
index 0000000..c3438e0
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/swupdate.manpages
@@ -0,0 +1,5 @@
+doc/build/man/swupdate.1
+doc/build/man/client.1
+doc/build/man/sendtohawkbit.1
+doc/build/man/hawkbitcfg.1
+doc/build/man/progress.1
diff --git a/recipes-core/swupdate/files/debian/swupdate.tmpfile b/recipes-core/swupdate/files/debian/swupdate.tmpfile
new file mode 100644
index 0000000..4743672
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/swupdate.tmpfile
@@ -0,0 +1,2 @@
+X /tmp/datadst
+X /tmp/scripts
diff --git a/recipes-core/swupdate/files/debian/watch b/recipes-core/swupdate/files/debian/watch
new file mode 100644
index 0000000..bc4c53e
--- /dev/null
+++ b/recipes-core/swupdate/files/debian/watch
@@ -0,0 +1,12 @@
+# Example watch control file for uscan
+# Rename this file to "watch" and then you can run the "uscan" command
+# to check for upstream updates and more.
+# See uscan(1) for format
+
+# Compulsory line, this is a version 4 file
+version=4
+
+# GitHub hosted projects
+opts="filenamemangle="s%(?:.*?)?v?(\d[\d.]*)\.tar\.gz%<project>-$1.tar.gz%" \
+   https://github.com/<user>/swupdate/tags \
+   (?:.*?/)?v?(\d[\d.]*)\.tar\.gz debian uupdate
diff --git a/recipes-core/swupdate/files/postinst b/recipes-core/swupdate/files/postinst
new file mode 100644
index 0000000..f15ac10
--- /dev/null
+++ b/recipes-core/swupdate/files/postinst
@@ -0,0 +1,2 @@
+#!/bin/sh
+deb-systemd-helper enable swupdate.socket || true
diff --git a/recipes-core/swupdate/files/swupdate.cfg b/recipes-core/swupdate/files/swupdate.cfg
new file mode 100644
index 0000000..e0222f1
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate.cfg
@@ -0,0 +1,6 @@
+globals :
+{
+    verbose = true;
+    loglevel = 10;
+    syslog = false;
+};
diff --git a/recipes-core/swupdate/files/swupdate.service.example b/recipes-core/swupdate/files/swupdate.service.example
new file mode 100644
index 0000000..d0b821e
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate.service.example
@@ -0,0 +1,11 @@
+[Unit]
+Description=SWUpdate daemon
+Documentation=https://github.com/sbabic/swupdate
+
+[Service]
+Type=simple
+ExecStart=/usr/bin/swupdate -f /etc/swupdate.cfg
+KillMode=mixed
+
+[Install]
+WantedBy=multi-user.target
diff --git a/recipes-core/swupdate/files/swupdate.socket.example b/recipes-core/swupdate/files/swupdate.socket.example
new file mode 100644
index 0000000..2b75671
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate.socket.example
@@ -0,0 +1,11 @@
+[Unit]
+Description=SWUpdate socket listener
+Documentation=https://github.com/sbabic/swupdate
+Documentation=https://sbabic.github.io/swupdate
+
+[Socket]
+ListenStream=/tmp/sockinstctrl
+ListenStream=/tmp/swupdateprog
+
+[Install]
+WantedBy=sockets.target
diff --git a/recipes-core/swupdate/files/swupdate.socket.tmpl b/recipes-core/swupdate/files/swupdate.socket.tmpl
new file mode 100644
index 0000000..8e7fc1d
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate.socket.tmpl
@@ -0,0 +1,13 @@
+[Unit]
+Description=SWUpdate socket listener
+Documentation=https://github.com/sbabic/swupdate
+Documentation=https://sbabic.github.io/swupdate
+
+[Socket]
+SocketUser=${SWUPDATE_SOCKET_OWNER}
+SocketGroup=root
+ListenStream=/tmp/sockinstctrl
+ListenStream=/tmp/swupdateprog
+
+[Install]
+WantedBy=sockets.target
diff --git a/recipes-core/swupdate/files/swupdate_defconfig b/recipes-core/swupdate/files/swupdate_defconfig
new file mode 100644
index 0000000..9ae7cb5
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig
@@ -0,0 +1,83 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Swupdate Configuration
+#
+CONFIG_HAVE_DOT_CONFIG=y
+
+#
+# Swupdate Settings
+#
+
+#
+# General Configuration
+#
+# CONFIG_CURL is not set
+# CONFIG_CURL_SSL is not set
+CONFIG_SYSTEMD=y
+CONFIG_SCRIPTS=y
+# CONFIG_HW_COMPATIBILITY is not set
+CONFIG_SW_VERSIONS_FILE="/etc/sw-versions"
+
+#
+# Socket Paths
+#
+CONFIG_SOCKET_CTRL_PATH="/tmp/sockinstctrl"
+CONFIG_SOCKET_PROGRESS_PATH="/tmp/swupdateprog"
+CONFIG_SOCKET_REMOTE_HANDLER_DIRECTORY="/tmp/"
+# CONFIG_MTD is not set
+# CONFIG_LUA is not set
+# CONFIG_LUAPKG is not set
+# CONFIG_FEATURE_SYSLOG is not set
+
+#
+# Build Options
+#
+CONFIG_CROSS_COMPILE=""
+CONFIG_SYSROOT=""
+CONFIG_EXTRA_CFLAGS=""
+CONFIG_EXTRA_LDFLAGS=""
+CONFIG_EXTRA_LDLIBS=""
+
+#
+# Debugging Options
+#
+# CONFIG_DEBUG is not set
+# CONFIG_WERROR is not set
+# CONFIG_NOCLEANUP is not set
+# CONFIG_BOOTLOADER_EBG is not set
+# CONFIG_UBOOT is not set
+# CONFIG_BOOTLOADER_NONE is not set
+# CONFIG_BOOTLOADER_GRUB is not set
+# CONFIG_DOWNLOAD is not set
+# CONFIG_DOWNLOAD_SSL is not set
+# CONFIG_CHANNEL_CURL is not set
+# CONFIG_HASH_VERIFY=y
+# CONFIG_SIGNED_IMAGES is not set
+# CONFIG_ENCRYPTED_IMAGES is not set
+# CONFIG_SURICATTA is not set
+# CONFIG_WEBSERVER is not set
+CONFIG_GUNZIP=y
+
+#
+# Parser Features
+#
+CONFIG_LIBCONFIG=y
+CONFIG_PARSERROOT=""
+# CONFIG_JSON is not set
+# CONFIG_LUAEXTERNAL is not set
+# CONFIG_SETEXTPARSERNAME is not set
+# CONFIG_SETSWDESCRIPTION is not set
+
+#
+# Image Handlers
+#
+CONFIG_RAW=y
+# CONFIG_LUASCRIPTHANDLER is not set
+# CONFIG_SHELLSCRIPTHANDLER is not set
+# CONFIG_HANDLER_IN_LUA is not set
+# CONFIG_EMBEDDED_LUA_HANDLER is not set
+# CONFIG_EMBEDDED_LUA_HANDLER_SOURCE is not set
+CONFIG_ARCHIVE=y
+# CONFIG_REMOTE_HANDLER is not set
+# CONFIG_SWUFORWARDER_HANDLER is not set
+# CONFIG_BOOTLOADERHANDLER is not set
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet b/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
new file mode 100644
index 0000000..8e3688c
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_efibootguard.snippet
@@ -0,0 +1,3 @@
+CONFIG_BOOTLOADER_NONE=n
+CONFIG_BOOTLOADER_EBG=y
+CONFIG_BOOTLOADERHANDLER=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet b/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
new file mode 100644
index 0000000..b39f9df
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_lua.snippet
@@ -0,0 +1,2 @@
+CONFIG_LUA=y
+CONFIG_LUAPKG="lua53"
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet b/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
new file mode 100644
index 0000000..b4a2de8
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_luahandler.snippet
@@ -0,0 +1,4 @@
+CONFIG_LUASCRIPTHANDLER=y
+CONFIG_HANDLER_IN_LUA=y
+CONFIG_EMBEDDED_LUA_HANDLER=y
+CONFIG_EMBEDDED_LUA_HANDLER_SOURCE="swupdate_handlers.lua"
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet b/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
new file mode 100644
index 0000000..eab98dd
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_mtd.snippet
@@ -0,0 +1 @@
+CONFIG_MTD=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet b/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
new file mode 100644
index 0000000..6b5832a
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_u-boot.snippet
@@ -0,0 +1,3 @@
+CONFIG_UBOOT=y
+CONFIG_UBOOT_FWENV="/etc/fw_env.config"
+CONFIG_BOOTLOADERHANDLER=y
diff --git a/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet b/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
new file mode 100644
index 0000000..d1c7732
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_defconfig_ubi.snippet
@@ -0,0 +1,6 @@
+CONFIG_UBIVOL=y
+CONFIG_UBIATTACH=y
+CONFIG_UBIBLACKLIST=""
+CONFIG_UBIWHITELIST=""
+CONFIG_UBIVIDOFFSET=0
+CONFIG_CFI=y
diff --git a/recipes-core/swupdate/files/swupdate_handlers.lua b/recipes-core/swupdate/files/swupdate_handlers.lua
new file mode 100644
index 0000000..f2ecc54
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate_handlers.lua
@@ -0,0 +1,453 @@
+--[[
+
+    Round-robin Image and File Handler.
+
+    Copyright (C) 2019, Siemens AG
+
+    Author: Christian Storm <christian.storm@siemens.com>
+
+    SPDX-License-Identifier: GPL-2.0-or-later
+
+    An `sw-description` file using these handlers may look like:
+        software =
+        {
+            version = "0.1.0";
+            images: ({
+                filename = "rootfs.ext4";
+                device = "sda4,sda5";
+                type = "roundrobin";
+                compressed = false;
+            });
+            files: ({
+                filename = "vmlinuz";
+                path = "vmlinuz";
+                type = "kernelfile";
+                device = "sda2,sda3";
+                filesystem = "vfat";
+            },
+            {
+                filename = "initrd.img";
+                path = "initrd.img";
+                type = "kernelfile";
+                device = "sda2,sda3";
+                filesystem = "vfat";
+            });
+        }
+
+    The semantics is as follows: Instead of having a fixed target device,
+    the 'roundrobin' image handler calculates the target device by parsing
+    /proc/cmdline, matching the root=<device> kernel parameter against its
+    'device' attribute's list of devices, and sets the actual target
+    device to the next 'device' attribute list entry in a round-robin
+    manner. The actual flashing is done via chain-calling another handler,
+    defaulting to the "raw" handler.
+
+    The 'kernelfile' file handler reuses the 'roundrobin' handler's target
+    device calculation by reading the actual target device from the same
+    index into its 'device' attribute's list of devices. The actual placing
+    of files into this partition is done via chain-calling another handler,
+    defaulting to the "rawfile" handler.
+
+    In the above example, if /dev/sda4 is currently booted according to
+    /proc/cmdline, /dev/sda5 will be flashed and the vmlinuz and initrd.img
+    files will be placed on /dev/sda3. If /dev/sda5 is booted, /dev/sda4
+    will be flashed and the vmlinuz and initrd.img files are placed on
+    /dev/sda2.
+    In addition to "classical" device nodes as in this example, partition
+    UUIDs as reported, e.g., by `blkid -s PARTUUID` are also supported.
+    UBI volumes are supported as well by specifying a CSV list of
+    ubi<number>:<label> items.
+
+    Configuration is done via an INI-style configuration file located at
+    /etc/swupdate.handler.ini or via compiled-in configuration (by
+    embedding the Lua handler script into the SWUpdate binary via using
+    CONFIG_EMBEDDED_LUA_HANDLER), the latter having precedence over the
+    former. See the example configuration below.
+    If uncommenting this example block, it will take precedence over any
+    /etc/swupdate.handler.ini configuration file.
+
+    The chain-called handlers can either be specified in the configuration,
+    i.e., a static run-time setting, or via the 'chainhandler' property of
+    an 'image' or 'file' section in the sw-description, with the latter
+    taking precedence over the former, e.g.,
+        ...
+        images: ({
+                filename = "rootfs.ext4";
+                device = "sda4,sda5";
+                type = "roundrobin";
+                properties: {
+                    chainhandler = "myraw";
+                };
+            });
+        ...
+    Such a sw-description fragment will chain-call the imaginary "myraw"
+    handler regardless of what's been configured in the compiled-in or the
+    configuration file.
+    When chain-calling the "rdiff_image" handler, its 'rdiffbase' property
+    is subject to round-robin as well, i.e., the 'rdiffbase' property is
+    expected to be a CSV list as for the 'device' property, and the actual
+    'rdiffbase' property value is calculated following the same round-robin
+    calculation mechanism stated above prior to chain-calling the actual
+    "rdiff_image" handler, e.g.,
+        images: ({
+                filename = "rootfs.ext4";
+                type = "roundrobin";
+                device = "sda4,sda5";
+                properties: {
+                    chainhandler = "rdiff_image";
+                    rdiffbase="sda1,sda2";
+                };
+            });
+    will set the 'rdiffbase' property to /dev/sda2 (/dev/sda1) if /dev/sda4
+    (/dev/sda5) is the currently booted root file system according to
+    /proc/cmdline parsing.
+
+]]
+
+
+local configuration = [[
+[bootloader]
+# Required: bootloader name, uboot and ebg currently supported.
+name=ebg
+# Required: bootloader-specific key-value pairs, e.g., for ebg:
+kernelname=linux.signed.efi
+# For relying on FAT labels, prefix bootlabels with 'L:', e.g., L:BOOT0.
+# For using custom labels, i.e., relying on the contents of an EFILABEL
+# file within the partition, prefix it with 'C:', e.g., C:BOOT0.
+bootlabel={ "C:BOOT0:", "C:BOOT1:" }
+
+# Optional: handler to chain-call for the 'roundrobin' handler,
+# defaulting to 'raw'
+[roundrobin]
+chainhandler=raw
+
+# Optional: handler to chain-call for the 'kernelfile' handler,
+# defaulting to 'rawfile'
+[kernelfile]
+chainhandler=rawfile
+]]
+
+-- Default configuration file, tried if no compiled-in config is available.
+local cfgfile = "/etc/swupdate.handler.ini"
+
+-- Table holding the configuration.
+local config = {}
+
+-- Mandatory configuration [section] and keys
+local BOOTLOADERCFG = {
+    ebg   = {
+        bootloader = {"name", "bootlabel", "kernelname"}
+    },
+    -- TODO fill with mandatory U-Boot configuration
+    uboot = {
+        bootloader = {"name"}
+    }
+}
+
+-- enum-alikes to make code more readable
+local BOOTLOADER = { EBG = "ebg", UBOOT = "uboot" }
+local PARTTYPE   = { UUID = 1, PLAIN = 2, UBI = 3 }
+
+-- Target table describing the target device the image is to be/has been flashed to.
+local rrtarget = {
+    size = function(self)
+        local _size = 0
+        for index in pairs(self) do _size = _size + 1 end
+        return _size - 1
+    end
+}
+
+-- Helper function parsing CSV fields of a struct img_type such as
+-- the "device" fields or the "rdiffbase" property.
+local get_device_list = function(device_node_csv_list)
+    local device_list = {}
+    for item in device_node_csv_list:gmatch("([^,]+)") do
+        local device_node = item:gsub("/dev/", "")
+        device_list[#device_list+1] = device_node
+        device_list[device_node] = #device_list
+    end
+    return device_list
+end
+
+-- Helper function to determine device node location.
+local get_device_path = function(device_node)
+    if device_node:match("ubi%d+:%S+") then
+        return 0, device_node, PARTTYPE.UBI
+    end
+    local device_path = string.format("/dev/disk/by-partuuid/%s", device_node)
+    local file = io.open(device_path, "rb" )
+    if file then
+        file:close()
+        return 0, device_path, PARTTYPE.UUID
+    end
+    device_path = string.format("/dev/%s", device_node)
+    file = io.open(device_path, "rb" )
+    if file then
+        file:close()
+        return 0, device_path, PARTTYPE.PLAIN
+    end
+    swupdate.error(string.format("Cannot access target device node /dev/{,disk/by-partuuid}/%s", device_node))
+    return 1, nil, nil
+end
+
+-- Helper function parsing the INI-style configuration.
+local get_config = function()
+    -- Return configuration right away if it's already parsed.
+    if config ~= nil and #config > 0 then
+        return config
+    end
+
+    -- Get configuration INI-style string.
+    if not configuration then
+        swupdate.trace(string.format("No compiled-in config found, trying %s", cfgfile))
+        local file = io.open(cfgfile, "r" )
+        if not file then
+            swupdate.error(string.format("Cannot open config file %s", cfgfile))
+            return nil
+        end
+        configuration = file:read("*a")
+        file:close()
+    end
+    if configuration:sub(-1) ~= "\n" then
+        configuration=configuration.."\n"
+    end
+
+    -- Parse INI-style contents into config table.
+    local sec, key, value
+    for line in configuration:gmatch("(.-)\n") do
+        if line:match("^%[([%w%p]+)%][%s]*") then
+            sec = line:match("^%[([%w%p]+)%][%s]*")
+            config[sec] = {}
+        elseif sec then
+            key, value = line:match("^([%w%p]-)=(.*)$")
+            if key and value then
+                if tonumber(value)  then value = tonumber(value) end
+                if value == "true"  then value = true            end
+                if value == "false" then value = false           end
+                if value:sub(1,1) == "{" then
+                    local _value = {}
+                    for _key, _ in value:gmatch("\"(%S+)\"") do
+                        table.insert(_value, _key)
+                    end
+                    value = _value
+                end
+                config[sec][key] = value
+            else
+                if not line:match("^$") and not line:match("^#") then
+                    swupdate.warn(string.format("Syntax error, skipping '%s'", line))
+                end
+            end
+        else
+            swupdate.error(string.format("Syntax error. no [section] encountered."))
+            return nil
+        end
+    end
+
+    -- Check config table for mandatory key existence.
+    if config["bootloader"] == nil or config["bootloader"]["name"] == nil then
+        swupdate.error(string.format("Syntax error. no [bootloader] encountered or name= missing therein."))
+        return nil
+    end
+    local bcfg = BOOTLOADERCFG[config.bootloader.name]
+    if not bcfg then
+        swupdate.error(string.format("Bootloader unsupported, name=uboot|ebg missing in [bootloader]?."))
+        return nil
+    end
+    for sec, _ in pairs(bcfg) do
+        for _, key in pairs(bcfg[sec]) do
+            if config[sec] == nil or config[sec][key] == nil then
+                swupdate.error(string.format("Mandatory config key %s= in [%s] not found.", key, sec))
+            end
+        end
+    end
+
+    return config
+end
+
+-- Round-robin image handler for updating the root partition.
+function handler_roundrobin(image)
+    -- Read configuration.
+    if not get_config() then
+        swupdate.error("Cannot read configuration.")
+        return 1
+    end
+
+    -- Check if we can chain-call the handler.
+    local chained_handler = "raw"
+    if image.properties ~= nil and image.properties["chainhandler"] ~= nil then
+        chained_handler = image.properties["chainhandler"]
+    elseif config["roundrobin"] ~= nil and config["roundrobin"]["chainhandler"] ~= nil then
+        chained_handler = config["roundrobin"]["chainhandler"]
+    end
+    if not swupdate.handler[chained_handler] then
+        swupdate.error(string.format("'%s' handler not available in SWUpdate distribution.", chained_handler))
+        return 1
+    end
+
+    -- Get device list for round-robin.
+    local devices = get_device_list(image.device)
+    if #devices < 2 then
+        swupdate.error("Specify at least 2 devices in the device= property for 'roundrobin'.")
+        return 1
+    end
+
+    -- Check that rrtarget is unset, else a reboot may be pending.
+    if rrtarget:size() > 0 then
+        swupdate.warn("The 'roundrobin' handler has been run. Is a reboot pending?")
+    end
+
+    -- Determine current root device.
+    local file = io.open("/proc/cmdline", "r")
+    if not file then
+        swupdate.error("Cannot open /proc/cmdline.")
+        return 1
+    end
+    local cmdline = file:read("*l")
+    file:close()
+
+    local rootparam, rootdevice
+    for item in cmdline:gmatch("%S+") do
+        rootparam, rootdevice = item:match("(root=[%u=]*[/dev/]*(%S+))")
+        if rootparam and rootdevice then break end
+    end
+    if not rootdevice then
+        -- Use findmnt to get the rootdev
+      rootdevice = io.popen('findmnt -nl / -o PARTUUID'):read("*l")
+      if not rootdevice then
+        swupdate.error("Cannot determine current root device.")
+        return 1
+      end
+    end
+    swupdate.info(string.format("Current root device is: %s", rootdevice))
+
+    if not devices[rootdevice] then
+        swupdate.error(string.format("Current root device '%s' is not in round-robin root devices list: %s", rootdevice, image.device:gsub("/dev/", "")))
+        return 1
+    end
+
+    -- Perform round-robin calculation for target.
+    local err
+    rrtarget.index = devices[rootdevice] % #devices + 1
+    rrtarget.device_node = devices[rrtarget.index]
+    err, rrtarget.device_path, rrtarget.parttype = get_device_path(devices[rrtarget.index])
+    if err ~= 0 then
+        return 1
+    end
+    swupdate.info(string.format("Using '%s' as 'roundrobin' target via '%s' handler.", rrtarget.device_path, chained_handler))
+
+    -- If the chain-called handler is rdiff_image, adapt the rdiffbase property
+    if chained_handler == "rdiff_image" then
+        if image.properties ~= nil and image.properties["rdiffbase"] ~= nil then
+            local rdiffbase_devices = get_device_list(image.properties["rdiffbase"])
+            if #rdiffbase_devices < 2 then
+                swupdate.error("Specify at least 2 devices in the rdiffbase= property for 'roundrobin'.")
+                return 1
+            end
+            err, image.propierties["rdiffbase"], _ = get_device_path(rdiffbase_devices[rrtarget.index])
+            if err ~= 0 then
+                return 1
+            end
+            swupdate.info(string.format("Using device %s as rdiffbase.", image.properties["rdiffbase"]))
+        else
+            swupdate.error("Property 'rdiffbase' is missing in sw-description.")
+            return 1
+        end
+    end
+
+    -- Actually flash the partition.
+    local msg
+    image.type = chained_handler
+    image.device = rrtarget.device_path
+    err, msg = swupdate.call_handler(chained_handler, image)
+    if err ~= 0 then
+        swupdate.error(string.format("Error chain-calling '%s' handler: %s", chained_handler, (msg or "")))
+        return 1
+    end
+
+    if config.bootloader.name == BOOTLOADER.EBG then
+      if rootparam then
+        local value = cmdline:gsub(
+            rootparam:gsub("%-", "%%-"),
+            string.format("root=%s%s",
+                (rrtarget.parttype == PARTTYPE.PLAIN and "") or (rrtarget.parttype == PARTTYPE.UBI and "") or "PARTUUID=",
+                 rrtarget.parttype == PARTTYPE.PLAIN and rrtarget.device_path or devices[rrtarget.index]
+            )
+        )
+        swupdate.info(string.format("Setting EFI Bootguard environment: kernelparams=%s", value))
+        swupdate.set_bootenv("kernelparams", value)
+      end
+    elseif config.bootloader.name == BOOTLOADER.UBOOT then
+        -- Update U-Boot environment.
+        swupdate.info(string.format("Setting U-Boot environment"))
+        local value = rrtarget.index
+        swupdate.set_bootenv("swupdpart", value);
+    end
+
+    return 0
+end
+
+-- File handler for updating kernel files.
+function handler_kernelfile(image)
+    -- Check if we can chain-call the handler.
+    local chained_handler = "rawfile"
+    if image.properties ~= nil and image.properties["chainhandler"] ~= nil then
+        chained_handler = image.properties["chainhandler"]
+    elseif config["kernelfile"] ~= nil and config["kernelfile"]["chainhandler"] ~= nil then
+        chained_handler = config["kernelfile"]["chainhandler"]
+    end
+    if not swupdate.handler[chained_handler] then
+        swupdate.error(string.format("'%s' handler not available in SWUpdate distribution."), chained_handler)
+        return 1
+    end
+
+    -- Check that rrtarget is set, else the 'roundrobin' handler hasn't been run.
+    if rrtarget:size() == 0 then
+        swupdate.error("The 'roundrobin' handler hasn't been run.")
+        swupdate.info("Place 'roundrobin' above 'kernelfile' in sw-description.")
+        return 1
+    end
+
+    -- Get device list for round-robin.
+    local devices = get_device_list(image.device)
+    if #devices < 2 then
+        swupdate.error("Specify at least 2 devices in the device= property for 'kernelfile'.")
+        return 1
+    end
+    if rrtarget.index > #devices then
+        swupdate.error("Cannot map kernel partition to root partition.")
+        return 1
+    end
+
+    -- Perform round-robin indexing for target.
+    local err
+    err, image.device, _ = get_device_path(devices[rrtarget.index])
+    if err ~= 0 then
+        return 1
+    end
+    swupdate.info(string.format("Using '%s' as 'kernelfile' target via '%s' handler.", image.device, chained_handler))
+
+    -- Actually copy the 'kernelfile' files.
+    local msg
+    image.type = chained_handler
+    err, msg = swupdate.call_handler(chained_handler, image)
+    if err ~= 0 then
+        swupdate.error(string.format("Error chain-calling '%s' handler: %s", chained_handler, (msg or "")))
+        return 1
+    end
+
+    if config.bootloader.name == BOOTLOADER.EBG then
+        -- Update EFI Boot Guard environment: kernelfile
+        local value = string.format("%s%s", config.bootloader.bootlabel[rrtarget.index], config.bootloader.kernelname)
+        swupdate.info(string.format("Setting EFI Bootguard environment: kernelfile=%s", value))
+        swupdate.set_bootenv("kernelfile", value)
+    elseif config.bootloader.name == BOOTLOADER.UBOOT then
+        -- Update U-Boot environment.
+        swupdate.info(string.format("Setting U-Boot environment"))
+        -- TODO
+    end
+
+    return 0
+end
+
+swupdate.register_handler("roundrobin", handler_roundrobin, swupdate.HANDLER_MASK.IMAGE_HANDLER)
+swupdate.register_handler("kernelfile", handler_kernelfile, swupdate.HANDLER_MASK.FILE_HANDLER)
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
new file mode 100644
index 0000000..95cf73a
--- /dev/null
+++ b/recipes-core/swupdate/swupdate.bb
@@ -0,0 +1,54 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+hDESCRIPTION = "swupdate utility for software updates"
+HOMEPAGE= "https://github.com/sbabic/swupdate"
+LICENSE = "GPL-2.0"
+LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
+
+SRC_URI = "git://github.com/sbabic/swupdate.git;branch=master;protocol=https"
+
+SRCREV = "1a6dfbb5a0be978ac1a159758e278ab4d44167e2"
+PV = "2020.4-git+isar"
+
+DEFCONFIG := "swupdate_defconfig"
+
+SRC_URI += "file://debian \
+            file://${DEFCONFIG} \
+            file://${PN}.cfg"
+
+DEPENDS += "libubootenv"
+
+DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
+
+inherit dpkg
+inherit swupdate-config
+
+KFEATURES += "luahandler"
+
+S = "${WORKDIR}/git"
+
+TEMPLATE_FILES = "debian/changelog.tmpl debian/control.tmpl debian/rules.tmpl"
+TEMPLATE_VARS += "BUILD_DEB_DEPENDS DEFCONFIG DEBIAN_DEPENDS"
+
+do_prepare_build() {
+        DEBDIR=${S}/debian
+        cp -R ${WORKDIR}/debian ${S}
+
+        install -m 0644 ${WORKDIR}/${PN}.cfg ${S}/swupdate.cfg
+        install -m 0644 ${WORKDIR}/${DEFCONFIG}.gen ${S}/configs/${DEFCONFIG}
+
+        if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore
+        then
+                echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
+        fi
+        # luahandler
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}
+}
-- 
2.20.1


--xl52Xrh0MCOZaS9dmh8i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5002): https://lists.cip-project.org/g/cip-dev/message=
/5002
Mute This Topic: https://lists.cip-project.org/mt/75767669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xl52Xrh0MCOZaS9dmh8i--
