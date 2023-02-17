Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE78C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:26:04 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.8958.1676647561183282015
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:26:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QBNtecj7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202302171525582dface23fd40395462-ytcygj@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202302171525582dface23fd40395462
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 16:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=iacOfr57qhsQbH5zbYTJNVm58c79GlFyCqSlJmfR4DY=;
 b=QBNtecj75uMXH7tx2QfKNLx06GRCrSpmhcXPrXWRFw3q4kQ/MPHT9/N+SFemfYEVm2M8DQ
 C9DFTiZzsOsig8haTuuN7EMI4hEDUyumM9L6/kU0Hpr5m8rSkqjd/ZTxJXu3wljfs2rkp7L6
 ybhmH0/yRL2RWPzetri+dA4VUq8mw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 2/3] efibootguard: use debian folder from salsa
Date: Fri, 17 Feb 2023 16:25:55 +0100
Message-Id: <20230217152556.516948-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:26:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10733

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To avoid package name conflicts between cip-core and Debian upstream
use the debian folder from upstream to build efibootguard.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-bookworm.conf            |  1 +
 conf/distro/cip-core-bullseye.conf            |  1 +
 conf/distro/cip-core-buster.conf              |  1 +
 conf/distro/cip-core-sid-ports.conf           |  1 +
 ...uard_0.13.bb => efibootguard_0.13+isar.bb} | 25 +++++++------
 ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
 ...rol-remove-native-from-python3-shtab.patch | 26 ++++++++++++++
 recipes-bsp/efibootguard/files/debian/compat  |  1 -
 .../efibootguard/files/debian/control.tmpl    | 20 -----------
 .../debian/efibootguard-dev.install.tmpl      |  2 --
 .../files/debian/efibootguard.install         |  5 ---
 recipes-bsp/efibootguard/files/debian/rules   | 15 --------
 recipes-core/swupdate/swupdate.inc            |  2 +-
 13 files changed, 79 insertions(+), 57 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+isar.bb} (55%)
 create mode 100644 recipes-bsp/efibootguard/files/0001-d-control-Make-compatible-with-debian-buster.patch
 create mode 100644 recipes-bsp/efibootguard/files/0002-d-control-remove-native-from-python3-shtab.patch
 delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
 delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 delete mode 100755 recipes-bsp/efibootguard/files/debian/rules

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index de2e435..70136b1 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_efibootguard ?= "0.13-2"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 3a0550c..f672051 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-bullseye.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_efibootguard ?= "0.13+isar"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index c5cb39c..dbc5e1e 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-buster.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_efibootguard ?= "0.13+isar"
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index edd3c28..1900408 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -12,6 +12,7 @@
 require conf/distro/debian-sid-ports.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_efibootguard ?= "0.13-2"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
 
diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13+isar.bb
similarity index 55%
rename from recipes-bsp/efibootguard/efibootguard_0.13.bb
rename to recipes-bsp/efibootguard/efibootguard_0.13+isar.bb
index 3279854..6a1fa56 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13+isar.bb
@@ -16,22 +16,23 @@ LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
+
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
-    file://debian \
-    "
-SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
+    git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
+    file://0001-d-control-Make-compatible-with-debian-buster.patch \
+    file://0002-d-control-remove-native-from-python3-shtab.patch"
 
-PROVIDES = "${PN}"
-PROVIDES += "${PN}-dev"
+SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
+SRCREV_debian = "78a14cbde6ac1d2132a61bddbea7cf39b661d82a"
 
-DEPENDS = "python3-shtab"
-BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
-BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
-BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
+PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
+
+S = "${WORKDIR}/git"
 
 inherit dpkg
 
+DEPENDS = "python3-shtab"
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
@@ -40,10 +41,8 @@ python() {
         d.setVar('DEB_HOST_MULTIARCH', proc.read())
 }
 
-TEMPLATE_FILES = "debian/control.tmpl debian/efibootguard-dev.install.tmpl"
-TEMPLATE_VARS += "DESCRIPTION_DEV BUILD_DEB_DEPENDS DEB_HOST_MULTIARCH"
+CHANGELOG_V = "<orig-version>+isar"
 
 do_prepare_build() {
-    cp -R ${WORKDIR}/debian ${S}
     deb_add_changelog
 }
diff --git a/recipes-bsp/efibootguard/files/0001-d-control-Make-compatible-with-debian-buster.patch b/recipes-bsp/efibootguard/files/0001-d-control-Make-compatible-with-debian-buster.patch
new file mode 100644
index 0000000..844eae4
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0001-d-control-Make-compatible-with-debian-buster.patch
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
diff --git a/recipes-bsp/efibootguard/files/0002-d-control-remove-native-from-python3-shtab.patch b/recipes-bsp/efibootguard/files/0002-d-control-remove-native-from-python3-shtab.patch
new file mode 100644
index 0000000..1c6cdc1
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0002-d-control-remove-native-from-python3-shtab.patch
@@ -0,0 +1,26 @@
+From bc54a466bd48b78a9761a38a7f3b3cf67b19469d Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Wed, 15 Feb 2023 10:47:38 +0100
+Subject: [PATCH 2/2] d/control: remove :native from python3-shtab
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/control | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/debian/control b/debian/control
+index 8b92019..53e2b66 100644
+--- a/debian/control
++++ b/debian/control
+@@ -9,7 +9,7 @@ Build-Depends: debhelper,
+  help2man,
+  libpci-dev,
+  pkg-config,
+- python3-shtab:native,
++ python3-shtab,
+  zlib1g-dev
+ Standards-Version: 4.6.1
+ Homepage: https://github.com/siemens/efibootguard
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
2.39.1


