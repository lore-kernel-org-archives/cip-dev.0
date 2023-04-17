Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83693C77B72
	for <webhook@archiver.kernel.org>; Mon, 17 Apr 2023 12:04:42 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.52505.1681733076083817931
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Apr 2023 05:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BLClYgXS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023041712043207bc301c79c8670748-qhuuqr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023041712043207bc301c79c8670748
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Apr 2023 14:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=i80594URQ5R/KMEcSizeb1WnBYT1+gIAvDUjRhyCRcU=;
 b=BLClYgXSof+ZxBv83YZ0qdWjt0Dqt+3Rn+ZxY4gBlz8s6TTTHkvnuhKXF79uxZFghYvGfZ
 jzbJLFyT0HUDOzUy3niHKV+fPjNfUAWr8EFy2G6LMHdWnyfN0xo/cktzeqwzO5RwkGGsYwHO
 D1PnC18mC6CMWliv4VQ1Co7iRSqKk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] efibootguard: use debian folder from salsa
Date: Mon, 17 Apr 2023 14:04:31 +0200
Message-Id: <20230417120431.356950-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Apr 2023 12:04:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11226

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To avoid package name conflicts between cip-core and Debian upstream
use the debian folder from upstream to build efibootguard.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - rebase onto next 
 - always build efibootguard 

Changes v3:
 - resend only efibootguard as patch "Enable Images based on Debian 12 (bookworm)" is already deployed
 - rebase onto next
 - remove unnecessary patch 0002-d-control-remove-native-from-python3-shtab.patch

 ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 30 +++++++++-------
 ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
 recipes-bsp/efibootguard/files/debian/compat  |  1 -
 .../efibootguard/files/debian/control.tmpl    | 20 -----------
 .../debian/efibootguard-dev.install.tmpl      |  2 --
 .../files/debian/efibootguard.install         |  5 ---
 recipes-bsp/efibootguard/files/debian/rules   | 15 --------
 ...01-add-machine-type-name-for-riscv64.patch |  0
 recipes-core/images/efibootguard.inc          |  5 ---
 recipes-core/images/swupdate.inc              |  6 ++--
 recipes-core/swupdate/swupdate.inc            |  2 +-
 11 files changed, 57 insertions(+), 65 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (55%)
 create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
 delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
 delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 delete mode 100755 recipes-bsp/efibootguard/files/debian/rules
 rename recipes-bsp/efibootguard/files/{ => src-patches}/0001-add-machine-type-name-for-riscv64.patch (100%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
similarity index 55%
rename from recipes-bsp/efibootguard/efibootguard_0.13.bb
rename to recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
index dd76198..d61c080 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
@@ -16,25 +16,29 @@ LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
+
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
-    file://debian \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
+    git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
+    file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+SRCREV_debian = "78a14cbde6ac1d2132a61bddbea7cf39b661d82a"
+
 # add riscv64 support
-SRC_URI += "file://0001-add-machine-type-name-for-riscv64.patch"
+SRC_URI += "file://src-patches"
+
 CHANGELOG_V = "${PV}+cip"
 
-PROVIDES = "${PN}"
-PROVIDES += "${PN}-dev"
+PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-DEPENDS = "python3-shtab"
-BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
-BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
-BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
+S = "${WORKDIR}/git"
+
+PATCHTOOL = "git"
 
 inherit dpkg
 
+DEPENDS = "python3-shtab"
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
@@ -43,10 +47,10 @@ python() {
         d.setVar('DEB_HOST_MULTIARCH', proc.read())
 }
 
-TEMPLATE_FILES = "debian/control.tmpl debian/efibootguard-dev.install.tmpl"
-TEMPLATE_VARS += "DESCRIPTION_DEV BUILD_DEB_DEPENDS DEB_HOST_MULTIARCH"
+CHANGELOG_V = "<orig-version>+isar"
 
 do_prepare_build() {
-    cp -R ${WORKDIR}/debian ${S}
     deb_add_changelog
+    cd ${S}/debian
+    quilt import ${WORKDIR}/src-patches/*.patch
 }
diff --git a/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
new file mode 100644
index 0000000..844eae4
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
@@ -0,0 +1,36 @@
+From 299b2fecb4be67b3b669762a88cb3376a9fd5628 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 14 Feb 2023 10:30:34 +0100
+Subject: [PATCH 1/2] d/control: Make compatible with debian buster
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/compat  | 1 +
+ debian/control | 2 +-
+ 2 files changed, 2 insertions(+), 1 deletion(-)
+ create mode 100644 debian/compat
+
+diff --git a/debian/compat b/debian/compat
+new file mode 100644
+index 0000000..9a03714
+--- /dev/null
++++ b/debian/compat
+@@ -0,0 +1 @@
++10
+\ No newline at end of file
+diff --git a/debian/control b/debian/control
+index fa7867c..8b92019 100644
+--- a/debian/control
++++ b/debian/control
+@@ -2,7 +2,7 @@ Source: efibootguard
+ Section: admin
+ Priority: optional
+ Maintainer: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+-Build-Depends: debhelper-compat (= 13),
++Build-Depends: debhelper,
+  autoconf-archive,
+  check,
+  gnu-efi,
+-- 
+2.39.1
+
diff --git a/recipes-bsp/efibootguard/files/debian/compat b/recipes-bsp/efibootguard/files/debian/compat
deleted file mode 100644
index ec63514..0000000
--- a/recipes-bsp/efibootguard/files/debian/compat
+++ /dev/null
@@ -1 +0,0 @@
-9
diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
deleted file mode 100644
index 626d43f..0000000
--- a/recipes-bsp/efibootguard/files/debian/control.tmpl
+++ /dev/null
@@ -1,20 +0,0 @@
-Source: ${PN}
-Section: base
-Priority: optional
-Standards-Version: 3.9.6
-Build-Depends: ${BUILD_DEB_DEPENDS}
-Homepage: ${HOMEPAGE}
-Maintainer: ${MAINTAINER}
-
-Package: ${PN}
-Depends: ${shlibs:Depends}, python3:any
-Section: base
-Architecture: ${DISTRO_ARCH}
-Priority: required
-Description: ${DESCRIPTION}
-
-Package: ${PN}-dev
-Section: base
-Architecture: ${DISTRO_ARCH}
-Priority: optional
-Description: ${DESCRIPTION_DEV}
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
deleted file mode 100644
index 948019a..0000000
--- a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
+++ /dev/null
@@ -1,2 +0,0 @@
-include/ebgenv.h usr/include/efibootguard
-libebgenv.a usr/lib/${DEB_HOST_MULTIARCH}
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
deleted file mode 100644
index 01cf974..0000000
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ /dev/null
@@ -1,5 +0,0 @@
-usr/bin
-usr/lib/*/efibootguard/kernel-stub*.efi
-usr/lib/*/efibootguard/efibootguard*.efi
-usr/lib/*/libebgenv.so.0*
-usr/share/efibootguard/completion
diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
deleted file mode 100755
index 9c3b916..0000000
--- a/recipes-bsp/efibootguard/files/debian/rules
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/usr/bin/make -f
-export DH_VERBOSE=1
-export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
-include /usr/share/dpkg/pkg-info.mk
-
-override_dh_auto_test:
-	# we do not run the tests; that avoids having to pull the fff submodule
-
-override_dh_installchangelogs:
-	# we're not interested in changelogs
-
-override_dh_installdocs:
-	# we're not interested in docs
-%:
-	dh $@ --with autoreconf
diff --git a/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
similarity index 100%
rename from recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
rename to recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index bb1aa1d..cdf5558 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -10,11 +10,6 @@
 #
 
 IMAGE_INSTALL:append = " efibootguard"
-IMAGE_PREINSTALL:append:sid = " efibootguard"
-IMAGE_PREINSTALL:append:bookworm = " efibootguard"
-IMAGE_INSTALL:append:bullseye = " efibootguard"
-IMAGE_INSTALL:append:buster = " efibootguard"
-
 WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 817fce0..ebc844a 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,9 +12,9 @@
 inherit image_uuid
 inherit read-only-rootfs
 
-IMAGE_PREINSTALL:append:sid = " swupdate"
-IMAGE_PREINSTALL:append:bookworm = " swupdate"
-IMAGE_INSTALL:append:bullseye = " swupdate"
 IMAGE_INSTALL:append:buster = " swupdate"
+IMAGE_INSTALL:append:bullseye = " swupdate"
+IMAGE_PREINSTALL:append:bookworm = " swupdate"
+IMAGE_PREINSTALL:append:sid = " swupdate"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 53b8133..e5e7282 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -26,7 +26,7 @@ DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
 def get_bootloader_dependencies(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
     if bootloader == "efibootguard":
-        return "efibootguard-dev"
+        return "libebgenv-dev"
     if bootloader == "u-boot":
         if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
             return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
-- 
2.39.2


