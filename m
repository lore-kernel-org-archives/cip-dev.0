Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C76EB64D8
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 16:47:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.3696.1686934062858985096
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jun 2023 09:47:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=R71X2NQl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20230616164739b7db66fe622b3de0eb-iecbqd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230616164739b7db66fe622b3de0eb
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Jun 2023 18:47:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bLTHKEDF/low3rHNu0b2/Us9Rof+GHd6GC0NtwcIv3M=;
 b=R71X2NQlwrjhzmZifpE6gV4jPV4OSqA1mhmOouLBJ6luLTCtTXRNr07AKF7f0NA8Nsbs1n
 Fs+IhgjIh7HlhZGtZ88bG+KofgTbISbH8XvUg7nky/xrkBYoExqbTKbWSm8cuiCSFNYpTa3p
 ojtOi7CYanmS3x18Ln/I3rV1gfmT8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	christian.storm@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: Update to 2023.06 for wfx support
Date: Fri, 16 Jun 2023 18:47:38 +0200
Message-Id: <20230616164738.3895223-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jun 2023 16:47:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12067

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
(tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-bookworm.conf            |  2 +-
 conf/distro/cip-core-bullseye.conf            |  2 +-
 conf/distro/cip-core-sid-ports.conf           |  1 +
 recipes-core/images/swupdate.inc              |  5 +-
 ...rate-build_profile-option-for-delta-.patch | 47 +++++++++++++++++++
 ...2.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} | 21 +++++++--
 6 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
 rename recipes-core/swupdate/{swupdate_2022.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} (55%)

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index f05d3d3..5563e49 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,6 +12,6 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_swupdate ?= "2022.12%"
+PREFERRED_VERSION_swupdate ?= "2023.06%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 9c83054..604280d 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -15,6 +15,6 @@ require cip-core-common.inc
 DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
 DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
 
-PREFERRED_VERSION_swupdate ?= "2022.12%"
+PREFERRED_VERSION_swupdate ?= "2023.06%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index edd3c28..2f02367 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -14,6 +14,7 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+PREFERRED_VERSION_swupdate ?= "2023.06%"
 
 DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
 HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index ebc844a..6a01abb 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,9 +12,6 @@
 inherit image_uuid
 inherit read-only-rootfs
 
-IMAGE_INSTALL:append:buster = " swupdate"
-IMAGE_INSTALL:append:bullseye = " swupdate"
-IMAGE_PREINSTALL:append:bookworm = " swupdate"
-IMAGE_PREINSTALL:append:sid = " swupdate"
+IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
new file mode 100644
index 0000000..2a6f2e0
--- /dev/null
+++ b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
@@ -0,0 +1,47 @@
+From 5e29e0929e37a6ab6aaad1b44280f1bb0d9a4fbe Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 15 Jun 2023 18:48:25 +0200
+Subject: [PATCH] d/rules: Add seperate build_profile option for delta update
+
+Delta update need zchunk 1.3 to work on memory restricted
+devices. zchunk 1.3 is is not available in bullseye-backports
+and Debian bookworm(12).
+
+To enable delta updates add 'pkg.swupdate.delta' to
+DEB_BUILD_PROFILES.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/control | 2 +-
+ debian/rules   | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/debian/control b/debian/control
+index e47c320c..d4b17972 100644
+--- a/debian/control
++++ b/debian/control
+@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
+                uuid-dev,
+                zlib1g-dev,
+                libzstd-dev,
+-               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
++               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
+                libp11-kit-dev <pkg.swupdate.p11>,
+                libwolfssl-dev <pkg.swupdate.p11>,
+                libmtd-dev [linux-any],
+diff --git a/debian/rules b/debian/rules
+index 57da4ca7..1c8d12e4 100755
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
+2.39.2
+
diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2023.06.bb
similarity index 55%
rename from recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
rename to recipes-core/swupdate/swupdate_2023.06.bb
index da44ae5..26aced4 100644
--- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2023.06.bb
@@ -8,7 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-inherit dpkg-gbp
+inherit dpkg
 
 require swupdate.inc
 
@@ -17,16 +17,19 @@ DEPENDS += "libebgenv-dev"
 DEB_BUILD_PROFILES += "nodoc"
 DEB_BUILD_OPTIONS += "nodoc"
 
-SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
-SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
+SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
+SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
 SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
+SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
 
 # deactivate signing and hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
 
-# use suricatta-lua instead of suricatta-hawkbit
-# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
+# Add suricattalua to support wfx
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
 
 # Disable cross for arm and arm64 on bullseye
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
@@ -37,3 +40,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
 
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
+CHANGELOG_V ?= "${PV}-1+cip"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.39.2


