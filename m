Return-Path: <SRS0=n108=FE=lists.cip-project.org=bounce+64572+5909+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF3FC64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706B32076E
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BECkXgQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5909+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gjJQYY4521723xadbyVztEMl; Mon, 30 Nov 2020 11:32:25 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.2091.1606764740474563067
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 11:32:21 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AUJWHpD028719
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:18 +0100
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.132])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUJWGdi001649
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:17 +0100
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 2/3] Update Isar revision
Date: Mon, 30 Nov 2020 20:32:15 +0100
Message-Id: <683866e2b0c5113b849ef82cf206b3bb5c6e3e30.1606764736.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1606764736.git.jan.kiszka@siemens.com>
References: <cover.1606764736.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f6EIGTnAacysWBgIjPLy3Ip0x4520388AA=
Content-Type: multipart/mixed; boundary="MzgirxNdEFFmYjyrbOEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606764745;
 bh=CHnlPegUTxnS4QX/MDwzysB92vINuKqxn/vgFqXEjsc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BECkXgQ2t20STiOUIGId3PMzLfIzP24n9+yIhVEM+ZFLGDTzVG6cvQLm/zHKYbEd2ft
 v0aF4Lknkb0vyuzf0b3FeItQue2D/gqEVbZnAQ1TneGcLtSDJPDDk3+1piL17Rj/C8lls
 5RKG55hk7bCS6+lj44fx5hPkDFhkWUotNJM=

--MzgirxNdEFFmYjyrbOEL
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop one patch, needs explicit setting of DISTRO_APT_SOURCES.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-buster.conf              |   2 +
 conf/distro/cip-core-stretch.conf             |   2 +
 .../0001-u-boot-add-libubootenv.patch         | 168 ------------------
 kas-cip.yml                                   |   5 +-
 .../wic/plugins/source/efibootguard-boot.py   |   2 +-
 .../wic/plugins/source/efibootguard-efi.py    |   2 +-
 6 files changed, 7 insertions(+), 174 deletions(-)
 delete mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch

diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index c5cb39c..ef60d24 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -12,5 +12,7 @@
 require conf/distro/debian-buster.conf
 require cip-core-common.inc
 
+DISTRO_APT_SOURCES = "conf/distro/debian-buster.list"
+
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/conf/distro/cip-core-stretch.conf b/conf/distro/cip-core-stretch.conf
index 31900fa..ad185dd 100644
--- a/conf/distro/cip-core-stretch.conf
+++ b/conf/distro/cip-core-stretch.conf
@@ -12,5 +12,7 @@
 require conf/distro/debian-stretch.conf
 require cip-core-common.inc
 
+DISTRO_APT_SOURCES = "conf/distro/debian-stretch.list"
+
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/isar-patches/0001-u-boot-add-libubootenv.patch b/isar-patches/0001-u-boot-add-libubootenv.patch
deleted file mode 100644
index 6002cf1..0000000
--- a/isar-patches/0001-u-boot-add-libubootenv.patch
+++ /dev/null
@@ -1,168 +0,0 @@
-From dda00e6addc7c51862b8175d473a1ea42dcd5c9e Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 19 Jun 2020 17:00:36 +0200
-Subject: [PATCH v2] u-boot: add libubootenv
-
-Add the new library libubootenv and remove fw_printenv and fw_setenv
-form u-boot-tools as the are now part of the new library.
-
-libubootenv is a library that provides a hardware independent
-way to access to U-Boot environment. U-Boot has its default environment
-compiled board-dependently and this means that tools to access the environment
-are also board specific, too.
-
-libubootenv conflicts with u-boot-tools from Debian 10
-as both try to install fw_printenv and fw_sentenv. This conflict is not
-part of the control file as it breaks the installation of custom u-boot-tools
-from the u-boot-sources.
-
-This patch uses dpkg-gdb to build the package from salsa.debian.org and adds
-a fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=967487.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
-
-Changes V2:
-- use dpkg-gbd instead dpkg
-- use salsa.debian.org as source
-- add fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=967487
-
- meta-isar/conf/machine/de0-nano-soc.conf      |  2 +-
- .../0002-Add-support-GNUInstallDirs.patch     | 48 +++++++++++++++++++
- .../libubootenv/libubootenv_0.2.bb            | 30 ++++++++++++
- .../files/debian/u-boot-tools.conffiles       |  1 -
- .../u-boot/files/debian/u-boot-tools.install  |  2 -
- .../u-boot/files/debian/u-boot-tools.links    |  1 -
- 6 files changed, 79 insertions(+), 5 deletions(-)
- create mode 100644 meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
- create mode 100644 meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
- delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
- delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
-
-diff --git a/meta-isar/conf/machine/de0-nano-soc.conf b/meta-isar/conf/machine/de0-nano-soc.conf
-index 3a2c009..6558d90 100644
---- a/meta-isar/conf/machine/de0-nano-soc.conf
-+++ b/meta-isar/conf/machine/de0-nano-soc.conf
-@@ -15,4 +15,4 @@ WKS_FILE ?= "de0-nano-soc.wks.in"
- IMAGER_INSTALL += "u-boot-de0-nano-soc"
- IMAGER_BUILD_DEPS += "u-boot-de0-nano-soc"
- 
--IMAGE_INSTALL += "u-boot-tools u-boot-script"
-+IMAGE_INSTALL += "u-boot-tools libubootenv u-boot-script"
-diff --git a/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch b/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
-new file mode 100644
-index 0000000..f8c3038
---- /dev/null
-+++ b/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
-@@ -0,0 +1,48 @@
-+From b17d194bd8285a19382a902a0bec9e5e042df064 Mon Sep 17 00:00:00 2001
-+From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
-+Date: Tue, 16 Apr 2019 08:52:01 +0900
-+Subject: [PATCH 2/4] Add support GNUInstallDirs
-+
-+This adds the functionality of the module "GNUInstallDirs" to make the
-+installation compatible with GNU.
-+
-+https://cmake.org/cmake/help/v3.14/module/GNUInstallDirs.html
-+
-+Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
-+---
-+ CMakeLists.txt     | 2 ++
-+ src/CMakeLists.txt | 8 ++++----
-+ 2 files changed, 6 insertions(+), 4 deletions(-)
-+
-+diff --git a/CMakeLists.txt b/CMakeLists.txt
-+index 104969e..57477fc 100644
-+--- a/CMakeLists.txt
-++++ b/CMakeLists.txt
-+@@ -10,6 +10,8 @@ add_definitions(-DVERSION="${VERSION}")
-+ 
-+ set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99")
-+ 
-++include("GNUInstallDirs")
-++
-+ #set(CMAKE_C_FLAGS_DEBUG "-g")
-+ include_directories ("${PROJECT_SOURCE_DIR}/src")
-+ add_subdirectory (src)
-+diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
-+index ea5979c..d97f221 100644
-+--- a/src/CMakeLists.txt
-++++ b/src/CMakeLists.txt
-+@@ -19,7 +19,7 @@ add_executable(fw_setenv fw_setenv.c)
-+ target_link_libraries(fw_printenv ubootenv z)
-+ target_link_libraries(fw_setenv ubootenv z)
-+ 
-+-install (TARGETS ubootenv DESTINATION lib)
-+-install (FILES libuboot.h DESTINATION include)
-+-install (TARGETS fw_printenv DESTINATION bin)
-+-install (TARGETS fw_setenv DESTINATION bin)
-++install (TARGETS ubootenv DESTINATION "${CMAKE_INSTALL_LIBDIR}")
-++install (FILES libuboot.h DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
-++install (TARGETS fw_printenv DESTINATION "${CMAKE_INSTALL_BINDIR}")
-++install (TARGETS fw_setenv DESTINATION "${CMAKE_INSTALL_BINDIR}")
-+-- 
-+2.20.1
-+
-diff --git a/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
-new file mode 100644
-index 0000000..995e581
---- /dev/null
-+++ b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
-@@ -0,0 +1,30 @@
-+# libubootenv
-+#
-+# This software is a part of ISAR.
-+# Copyright (c) Siemens AG, 2020
-+#
-+# SPDX-License-Identifier: MIT
-+
-+DESCRIPTION = "swupdate utility for software updates"
-+HOMEPAGE= "https://github.com/sbabic/swupdate"
-+LICENSE = "GPL-2.0"
-+LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
-+
-+inherit dpkg-gbp
-+
-+SRC_URI = "git://salsa.debian.org/debian/libubootenv.git;protocol=https \
-+           file://0002-Add-support-GNUInstallDirs.patch;apply=no "
-+SRCREV = "2c7cb6d941d906dcc1d2e447cc17e418485dff12"
-+
-+S = "${WORKDIR}/git"
-+
-+do_prepare_build() {
-+  cd ${S}
-+  export QUILT_PATCHES=debian/patches
-+  quilt import -f ${WORKDIR}/*.patch
-+	quilt push -a
-+}
-+
-+dpkg_runbuild_prepend() {
-+	export DEB_BUILD_OPTIONS="nocheck"
-+}
-diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
-deleted file mode 100644
-index d49a8fb..0000000
---- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
-+++ /dev/null
-@@ -1 +0,0 @@
--/etc/fw_env.config
-diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
-index d1ae3e0..2893b9a 100644
---- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
-+++ b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
-@@ -1,5 +1,3 @@
- tools/dumpimage		/usr/bin/
--tools/env/fw_printenv	/usr/bin/
- tools/mkenvimage	/usr/bin/
- tools/mkimage		/usr/bin/
--tools/env/fw_env.config	/etc
-diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
-deleted file mode 100644
-index 92f5a6c..0000000
---- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
-+++ /dev/null
-@@ -1 +0,0 @@
--/usr/bin/fw_printenv /usr/bin/fw_setenv
--- 
-2.20.1
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 66a58f1..922ee7e 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -20,13 +20,10 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 351af175bc54a201c6f44307d4e998bd6c0afdb8
+    refspec: 76eac233f1b1d0d117b3f05b3dec8a6da1cdf4c7
     layers:
       meta:
     patches:
-      01-libubootenv:
-        path: isar-patches/0001-u-boot-add-libubootenv.patch
-        repo: cip-core
       02-initramfs:
         path: isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
         repo: cip-core
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index d291f75..b85cfca 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -35,7 +35,7 @@ import logging
 msger = logging.getLogger('wic')
 
 from wic.pluginbase import SourcePlugin
-from wic.utils.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
 
 class EfibootguardBootPlugin(SourcePlugin):
     """
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 6647212..9eb2353 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -33,7 +33,7 @@ import os
 msger = logging.getLogger('wic')
 
 from wic.pluginbase import SourcePlugin
-from wic.utils.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
 
 class EfibootguardEFIPlugin(SourcePlugin):
     """
-- 
2.26.2


--MzgirxNdEFFmYjyrbOEL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5909): https://lists.cip-project.org/g/cip-dev/message=
/5909
Mute This Topic: https://lists.cip-project.org/mt/78616513/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MzgirxNdEFFmYjyrbOEL--
