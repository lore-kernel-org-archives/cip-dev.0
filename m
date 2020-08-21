Return-Path: <SRS0=koIX=B7=lists.cip-project.org=bounce+64572+5171+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B49C433E5
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217EC20732
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MObmhlCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217EC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5171+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UJppYY4521723xgM8Ouaty8j; Fri, 21 Aug 2020 02:56:04 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.129956.1598003763484095683
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:56:04 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07L9u1ue001291
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 11:56:01 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.58.237])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L9u0Qr003248;
	Fri, 21 Aug 2020 11:56:01 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 2/6] isar-patch: Add initramfs-config patch
Date: Fri, 21 Aug 2020 11:55:55 +0200
Message-Id: <20200821095559.28467-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
References: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ToNwFtk3BBrVq5Mqf09Laf7Kx4520388AA=
Content-Type: multipart/mixed; boundary="QKq7OrqT1SgKKDGaw6cO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598003764;
 bh=Rg1/5LPvS+7o1XID9soJrhENzeVKAxx6P5W9jly+zxY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MObmhlCxG4F2QdEmgicwzjeoetBUzgADMA/Np/0RObmiKN5fV+xkp00J7ZJAZJZNTnI
 EoAlzava4HD8lizTlSvssmvB7dgD0j0GshXN4PdEWIdyH9MXoK0qQowX5dFuCDrMT5rIJ
 mXcQ5Kymz/zRWbN572TqNINIlQ53vVSnJSc=

--QKq7OrqT1SgKKDGaw6cO
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt the initramfs generation to set for example the root device
in the initramfs

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../0001-u-boot-add-libubootenv.patch         | 161 +++++++-------
 ...-support-Generate-a-custom-initramfs.patch | 207 ++++++++++++++++++
 kas-cip.yml                                   |   3 +
 3 files changed, 290 insertions(+), 81 deletions(-)
 create mode 100644 isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch

diff --git a/isar-patches/0001-u-boot-add-libubootenv.patch b/isar-patches/0001-u-boot-add-libubootenv.patch
index 10a5b4a..6002cf1 100644
--- a/isar-patches/0001-u-boot-add-libubootenv.patch
+++ b/isar-patches/0001-u-boot-add-libubootenv.patch
@@ -1,4 +1,4 @@
-From 76897e89977f895495e21e37cb76f90392d55ef9 Mon Sep 17 00:00:00 2001
+From dda00e6addc7c51862b8175d473a1ea42dcd5c9e Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Fri, 19 Jun 2020 17:00:36 +0200
 Subject: [PATCH v2] u-boot: add libubootenv
@@ -16,20 +16,25 @@ as both try to install fw_printenv and fw_sentenv. This conflict is not
 part of the control file as it breaks the installation of custom u-boot-tools
 from the u-boot-sources.
 
+This patch uses dpkg-gdb to build the package from salsa.debian.org and adds
+a fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=967487.
+
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
+
+Changes V2:
+- use dpkg-gbd instead dpkg
+- use salsa.debian.org as source
+- add fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=967487
+
  meta-isar/conf/machine/de0-nano-soc.conf      |  2 +-
- .../libubootenv/files/debian/compat           |  1 +
- .../libubootenv/files/debian/control.tmpl     | 15 +++++++++
- .../libubootenv/files/debian/rules.tmpl       | 24 ++++++++++++++
- .../libubootenv/libubootenv_0.2.bb            | 32 +++++++++++++++++++
+ .../0002-Add-support-GNUInstallDirs.patch     | 48 +++++++++++++++++++
+ .../libubootenv/libubootenv_0.2.bb            | 30 ++++++++++++
  .../files/debian/u-boot-tools.conffiles       |  1 -
- .../u-boot/files/debian/u-boot-tools.install  |  2 --
+ .../u-boot/files/debian/u-boot-tools.install  |  2 -
  .../u-boot/files/debian/u-boot-tools.links    |  1 -
- 8 files changed, 73 insertions(+), 5 deletions(-)
- create mode 100644 meta/recipes-bsp/libubootenv/files/debian/compat
- create mode 100644 meta/recipes-bsp/libubootenv/files/debian/control.tmpl
- create mode 100644 meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
+ 6 files changed, 79 insertions(+), 5 deletions(-)
+ create mode 100644 meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
  create mode 100644 meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
  delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
  delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
@@ -44,70 +49,66 @@ index 3a2c009..6558d90 100644
  
 -IMAGE_INSTALL += "u-boot-tools u-boot-script"
 +IMAGE_INSTALL += "u-boot-tools libubootenv u-boot-script"
-diff --git a/meta/recipes-bsp/libubootenv/files/debian/compat b/meta/recipes-bsp/libubootenv/files/debian/compat
-new file mode 100644
-index 0000000..b4de394
---- /dev/null
-+++ b/meta/recipes-bsp/libubootenv/files/debian/compat
-@@ -0,0 +1 @@
-+11
-diff --git a/meta/recipes-bsp/libubootenv/files/debian/control.tmpl b/meta/recipes-bsp/libubootenv/files/debian/control.tmpl
+diff --git a/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch b/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
 new file mode 100644
-index 0000000..fade69a
+index 0000000..f8c3038
 --- /dev/null
-+++ b/meta/recipes-bsp/libubootenv/files/debian/control.tmpl
-@@ -0,0 +1,15 @@
-+Source: libubootenv
-+Section: embedded
-+Priority: optional
-+Maintainer: Stefano Babic <sbabic@denx.de>
-+Build-Depends: ${BUILD_DEB_DEPENDS}
-+Standards-Version: 4.2.1
-+Homepage: https://sbabic.github.io/libubootenv
-+
-+Package: libubootenv
-+Architecture: any
-+Depends: ${DEBIAN_DEPENDS}
-+Description: libubootenv is a library that provides a hardware independent
-+ way to access to U-Boot environment. U-Boot has its default environment
-+ compiled board-dependently and this means that tools to access the environment
-+ are also board specific, too.
-diff --git a/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl b/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
-new file mode 100644
-index 0000000..56ccd19
---- /dev/null
-+++ b/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
-@@ -0,0 +1,24 @@
-+#!/usr/bin/make -f
-+
-+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
-+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
-+export CC=$(DEB_HOST_GNU_TYPE)-gcc
-+export LD=$(DEB_HOST_GNU_TYPE)-gcc
-+endif
-+
-+export DH_VERBOSE = 1
++++ b/meta/recipes-bsp/libubootenv/files/0002-Add-support-GNUInstallDirs.patch
+@@ -0,0 +1,48 @@
++From b17d194bd8285a19382a902a0bec9e5e042df064 Mon Sep 17 00:00:00 2001
++From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
++Date: Tue, 16 Apr 2019 08:52:01 +0900
++Subject: [PATCH 2/4] Add support GNUInstallDirs
++
++This adds the functionality of the module "GNUInstallDirs" to make the
++installation compatible with GNU.
++
++https://cmake.org/cmake/help/v3.14/module/GNUInstallDirs.html
++
++Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
++---
++ CMakeLists.txt     | 2 ++
++ src/CMakeLists.txt | 8 ++++----
++ 2 files changed, 6 insertions(+), 4 deletions(-)
++
++diff --git a/CMakeLists.txt b/CMakeLists.txt
++index 104969e..57477fc 100644
++--- a/CMakeLists.txt
+++++ b/CMakeLists.txt
++@@ -10,6 +10,8 @@ add_definitions(-DVERSION="${VERSION}")
++ 
++ set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99")
++ 
+++include("GNUInstallDirs")
+++
++ #set(CMAKE_C_FLAGS_DEBUG "-g")
++ include_directories ("${PROJECT_SOURCE_DIR}/src")
++ add_subdirectory (src)
++diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
++index ea5979c..d97f221 100644
++--- a/src/CMakeLists.txt
+++++ b/src/CMakeLists.txt
++@@ -19,7 +19,7 @@ add_executable(fw_setenv fw_setenv.c)
++ target_link_libraries(fw_printenv ubootenv z)
++ target_link_libraries(fw_setenv ubootenv z)
++ 
++-install (TARGETS ubootenv DESTINATION lib)
++-install (FILES libuboot.h DESTINATION include)
++-install (TARGETS fw_printenv DESTINATION bin)
++-install (TARGETS fw_setenv DESTINATION bin)
+++install (TARGETS ubootenv DESTINATION "${CMAKE_INSTALL_LIBDIR}")
+++install (FILES libuboot.h DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
+++install (TARGETS fw_printenv DESTINATION "${CMAKE_INSTALL_BINDIR}")
+++install (TARGETS fw_setenv DESTINATION "${CMAKE_INSTALL_BINDIR}")
++-- 
++2.20.1
 +
-+export DEB_BUILD_MAINT_OPTIONS = hardening=+bindnow
-+
-+override_dh_auto_configure:
-+	dh_auto_configure --
-+
-+%:
-+	echo $@
-+	dh $@
-+
-+override_dh_installchangelogs:
-+	true
-+
-+override_dh_installdocs:
-+	true
 diff --git a/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
 new file mode 100644
-index 0000000..1be058c
+index 0000000..995e581
 --- /dev/null
 +++ b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
-@@ -0,0 +1,32 @@
+@@ -0,0 +1,30 @@
 +# libubootenv
 +#
 +# This software is a part of ISAR.
@@ -119,26 +120,24 @@ index 0000000..1be058c
 +HOMEPAGE= "https://github.com/sbabic/swupdate"
 +LICENSE = "GPL-2.0"
 +LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
-+SRC_URI = "gitsm://github.com/sbabic/libubootenv.git;branch=master;protocol=https"
-+
-+SRCREV = "bf6ff631c0e38cede67268ceb8bf1383b5f8848e"
 +
-+BUILD_DEB_DEPENDS = "cmake, zlib1g-dev"
++inherit dpkg-gbp
 +
-+SRC_URI += "file://debian"
-+TEMPLATE_FILES = "debian/control.tmpl debian/rules.tmpl"
-+TEMPLATE_VARS += "BUILD_DEB_DEPENDS DEFCONFIG DEBIAN_DEPENDS"
-+
-+
-+inherit dpkg
++SRC_URI = "git://salsa.debian.org/debian/libubootenv.git;protocol=https \
++           file://0002-Add-support-GNUInstallDirs.patch;apply=no "
++SRCREV = "2c7cb6d941d906dcc1d2e447cc17e418485dff12"
 +
 +S = "${WORKDIR}/git"
 +
 +do_prepare_build() {
-+        DEBDIR=${S}/debian
-+        install -d ${DEBDIR}
-+        cp -R ${WORKDIR}/debian ${S}
-+        deb_add_changelog
++  cd ${S}
++  export QUILT_PATCHES=debian/patches
++  quilt import -f ${WORKDIR}/*.patch
++	quilt push -a
++}
++
++dpkg_runbuild_prepend() {
++	export DEB_BUILD_OPTIONS="nocheck"
 +}
 diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
 deleted file mode 100644
diff --git a/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch b/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
new file mode 100644
index 0000000..f8fb28e
--- /dev/null
+++ b/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
@@ -0,0 +1,207 @@
+From 7c85e2e363fd39e60bf5041d02e14e8bd62c1a68 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 24 Mar 2020 17:58:08 +0100
+Subject: [PATCH v7 1/3] meta/support: Generate a custom initramfs
+
+This package sets the Parameters for mkinitramfs/update-intramfs
+before it regenerates the initrd.img of debian with a modified version.
+
+Use cases are the remove unnecessary kernel modules to reduce the
+size of the initrd by using the parameters:
+```
+INITRAMFS_MODULES = "list"
+INITRAMFS_MODULE_LIST += "ext4"
+```
+
+Set the boot root during the initrd generation by setting `INITRAMFS_ROOT`.
+
+see also man pages of mkinitramfs and initramfs.conf.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ .../initramfs-config/initramfs-config_0.1.bb  |  6 +++
+ .../initramfs-config/files/control.tmpl       | 12 +++++
+ .../initramfs-config/files/postinst.tmpl      | 50 +++++++++++++++++++
+ .../initramfs-config/files/postrm.tmpl        | 41 +++++++++++++++
+ .../initramfs-config/initramfs-config.inc     | 32 ++++++++++++
+ 5 files changed, 141 insertions(+)
+ create mode 100644 meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+ create mode 100644 meta/recipes-support/initramfs-config/files/control.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/files/postinst.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/files/postrm.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/initramfs-config.inc
+
+diff --git a/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+new file mode 100644
+index 0000000..c951e8a
+--- /dev/null
++++ b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+@@ -0,0 +1,6 @@
++#
++# Copyright (C) Siemens AG, 2020
++#
++# SPDX-License-Identifier: MIT
++
++require recipes-support/initramfs-config/initramfs-config.inc
+diff --git a/meta/recipes-support/initramfs-config/files/control.tmpl b/meta/recipes-support/initramfs-config/files/control.tmpl
+new file mode 100644
+index 0000000..66984eb
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/control.tmpl
+@@ -0,0 +1,12 @@
++Source: ${PN}
++Section: misc
++Priority: optional
++Standards-Version: 3.9.6
++Maintainer: isar-users <isar-users@googlegroups.com>
++Build-Depends: debhelper (>= 9)
++
++
++Package: ${PN}
++Architecture: any
++Depends: ${shlibs:Depends}, ${misc:Depends}, initramfs-tools-core, ${DEBIAN_DEPENDS}
++Description: Configuration files for a custom initramfs
+diff --git a/meta/recipes-support/initramfs-config/files/postinst.tmpl b/meta/recipes-support/initramfs-config/files/postinst.tmpl
+new file mode 100644
+index 0000000..e523906
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/postinst.tmpl
+@@ -0,0 +1,50 @@
++#!/bin/sh
++# postinst script for initramfs-config
++#
++# see: dh_installdeb(1)
++
++set -e
++
++case "$1" in
++    configure)
++        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
++        if [ -f ${INITRAMFS_CONF} ]; then
++            sed -i -E 's/(^MODULES=).*/\1${INITRAMFS_MODULES}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^BUSYBOX=).*/\1${INITRAMFS_BUSYBOX}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^COMPRESS=).*/\1${INITRAMFS_COMPRESS}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^KEYMAP=).*/\1${INITRAMFS_KEYMAP}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^DEVICE=).*/\1${INITRAMFS_NET_DEVICE}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^NFSROOT=).*/\1${INITRAMFS_NFSROOT}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^RUNSIZE=).*/\1${INITRAMFS_RUNSIZE}/' ${INITRAMFS_CONF}
++            if grep -Fxq "ROOT=" "${INITRAMFS_CONF}"; then
++                sed -i -E 's/(^ROOT=).*/\1${INITRAMFS_ROOT}/' ${INITRAMFS_CONF}
++            else
++                sed -i -E "\$aROOT=${INITRAMFS_ROOT}" ${INITRAMFS_CONF}
++            fi
++        fi
++
++        MODULES_LIST_FILE=/etc/initramfs-tools/modules
++        if [ -f ${MODULES_LIST_FILE} ]; then
++            for modname in ${INITRAMFS_MODULE_LIST}; do
++                if ! grep -Fxq "$modname" "${MODULES_LIST_FILE}"; then
++                    echo "$modname" >> "${MODULES_LIST_FILE}"
++                fi
++            done
++        fi
++
++        update-initramfs -v -u
++
++    ;;
++    abort-upgrade|abort-remove|abort-deconfigure)
++    ;;
++
++    *)
++        echo "postinst called with unknown argument \`$1'" >&2
++        exit 1
++        ;;
++esac
++# dh_installdeb will replace this with shell code automatically
++# generated by other debhelper scripts.
++#DEBHELPER#
++
++exit 0
+diff --git a/meta/recipes-support/initramfs-config/files/postrm.tmpl b/meta/recipes-support/initramfs-config/files/postrm.tmpl
+new file mode 100644
+index 0000000..115d9b6
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/postrm.tmpl
+@@ -0,0 +1,41 @@
++#!/bin/sh
++# postrm script for initramfs-config
++#
++# see: dh_installdeb(1)
++
++set -e
++
++case "$1" in
++    purge|remove|upgrade|failed-upgrade|abort-install|abort-upgrade|disappear)
++        # back to the debian defaults
++        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
++        sed -i -E 's/(^MODULES=).*/\1most/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^BUSYBOX=).*/\1auto/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^COMPRESS=).*/\1gzip/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^KEYMAP=).*/\1n/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^DEVICE=).*/\1/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^NFSROOT=).*/\1auto/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^RUNSIZE=).*/\110%/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^ROOT=).*//' ${INITRAMFS_CONF}
++
++        # remove the added modules
++        MODULES_LIST_FILE=/etc/initramfs-tools/modules
++        for modname in ${INITRAMFS_MODULE_LIST}; do
++            sed -i -E 's/$modname//'
++        done
++
++        update-initramfs -v -u
++    ;;
++
++    *)
++        echo "postrm called with unknown argument \`$1'" >&2
++        exit 1
++        ;;
++esac
++
++# dh_installdeb will replace this with shell code automatically
++# generated by other debhelper scripts.
++
++#DEBHELPER#
++
++exit 0
+diff --git a/meta/recipes-support/initramfs-config/initramfs-config.inc b/meta/recipes-support/initramfs-config/initramfs-config.inc
+new file mode 100644
+index 0000000..16049a9
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/initramfs-config.inc
+@@ -0,0 +1,32 @@
++# This software is a part of ISAR.
++# Copyright (C) 2020 Siemens AG
++#
++# SPDX-License-Identifier: MIT
++inherit dpkg-raw
++inherit template
++DESCRIPTION = "Recipe to set the initramfs configuration and generate a new ramfs"
++
++FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
++
++SRC_URI = "file://postinst.tmpl \
++           file://postrm.tmpl \
++           file://control.tmpl \
++          "
++
++INITRAMFS_MODULES ?= "most"
++INITRAMFS_BUSYBOX ?= "auto"
++INITRAMFS_COMPRESS ?= "gzip"
++INITRAMFS_KEYMAP ?= "n"
++INITRAMFS_NET_DEVICE ?= ""
++INITRAMFS_NFSROOT ?= "auto"
++INITRAMFS_RUNSIZE ?= "10%"
++INITRAMFS_ROOT ?= ""
++INITRAMFS_MODULE_LIST ?= ""
++CREATE_NEW_INITRAMFS ?= "n"
++KERNEL_PACKAGE = "${@ ("linux-image-" + d.getVar("KERNEL_NAME", True)) if d.getVar("KERNEL_NAME", True) else ""}"
++DEBIAN_DEPENDS += ", ${KERNEL_PACKAGE}"
++TEMPLATE_FILES = "postinst.tmpl control.tmpl postrm.tmpl"
++TEMPLATE_VARS += "INITRAMFS_MODULES INITRAMFS_BUSYBOX INITRAMFS_COMPRESS \
++                  INITRAMFS_KEYMAP INITRAMFS_NET_DEVICE INITRAMFS_NFSROOT \
++                  INITRAMFS_RUNSIZE INITRAMFS_ROOT INITRAMFS_MODULE_LIST \
++                  CREATE_NEW_INITRAMFS DEBIAN_DEPENDS PN"
+-- 
+2.20.1
+
diff --git a/kas-cip.yml b/kas-cip.yml
index f4edd0f..66a58f1 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -27,6 +27,9 @@ repos:
       01-libubootenv:
         path: isar-patches/0001-u-boot-add-libubootenv.patch
         repo: cip-core
+      02-initramfs:
+        path: isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
+        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.20.1


--QKq7OrqT1SgKKDGaw6cO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5171): https://lists.cip-project.org/g/cip-dev/message=
/5171
Mute This Topic: https://lists.cip-project.org/mt/76326084/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QKq7OrqT1SgKKDGaw6cO--
