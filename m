Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02409EB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 10:50:23 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.4799.1687171820641484925
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 03:50:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hs2D9WE4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20230619105016d682047bb5dd0a8712-0_f83t@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230619105016d682047bb5dd0a8712
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jun 2023 12:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=YMr55FSdX1WSfLd0/pleTfDSKdAlq44Pi1MAhNy8//U=;
 b=hs2D9WE4RTNY22IjZi8gFSY1f72MtPT1QLWBX52QnZZ42JM8JF9Wu+Y/CZjsmmsdXsj1dY
 IqYplWrz/r6oAjou4cA5UUsF2+bhr2jEvxPxmr8ryx49dQ7ehaBhbQi4DC0IHAwuM/6ebxHl
 xZeiOTOM0ob6ereypBk4sifIzTm8Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	christian.storm@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] swupdate: Update to 2023.05 with wfx support
Date: Mon, 19 Jun 2023 12:50:15 +0200
Message-Id: <20230619105015.195380-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 10:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12071

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
(tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.

You can enable wfx by enabling during in the systemd service by writing
to `/etc/swupdate/conf.d/suricatta.conf`:
```
SWUPDATE_SURICATTA_ARGS="-S lua <wfx arguments>"
```
For the <wfx arguments> see 'swupdate -h'.

To switch between wfx and hawkbit exchange `lua` with `hawkbit`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - add patch to display swupdate version
   - this Patch also sets the EXTRAVERSION with packageversion+git commit sha
 - set CONFIG_SURICATTA_WFX to always enable wfx
 - use version 2023.05 as it is the version stored in the swupdate
   sources
 - move patches to version specific folders for readability
 - Add instructions to start swupdate service with wfx

 conf/distro/cip-core-bookworm.conf            |  2 +-
 conf/distro/cip-core-bullseye.conf            |  2 +-
 conf/distro/cip-core-sid-ports.conf           |  1 +
 recipes-core/images/swupdate.inc              |  5 +-
 recipes-core/persistent-fs/files/data.mount   | 13 +++
 recipes-core/persistent-fs/files/postinst     |  3 +
 .../persistent-fs/persistent-fs_0.1.bb        | 20 ++++
 .../0002-debian-rules-Add-CONFIG_MTD.patch    | 27 ------
 ...-SWUpdate-USB-service-and-Udev-rules.patch |  0
 ...ules-Add-Embedded-Lua-handler-option.patch |  0
 ...es-Add-option-to-disable-fs-creation.patch |  0
 ...ules-Add-option-to-disable-webserver.patch |  0
 ...ch-to-fix-bootloader_env_get-for-EBG.patch |  0
 ...prepare-build-for-isar-debian-buster.patch |  0
 ...d-rules-Add-option-for-suricatta_lua.patch |  4 +-
 ...rate-build_profile-option-for-delta-.patch | 45 +++++++++
 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ++++++
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  2 +
 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 39 --------
 recipes-core/swupdate/swupdate_2023.05.bb     | 60 ++++++++++++
 21 files changed, 273 insertions(+), 74 deletions(-)
 create mode 100644 recipes-core/persistent-fs/files/data.mount
 create mode 100755 recipes-core/persistent-fs/files/postinst
 create mode 100644 recipes-core/persistent-fs/persistent-fs_0.1.bb
 delete mode 100644 recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
 rename recipes-core/swupdate/files/{ => 2021.11}/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch (100%)
 rename recipes-core/swupdate/files/{ => 2021.11}/0002-debian-rules-Add-Embedded-Lua-handler-option.patch (100%)
 rename recipes-core/swupdate/files/{ => 2021.11}/0003-debian-rules-Add-option-to-disable-fs-creation.patch (100%)
 rename recipes-core/swupdate/files/{ => 2021.11}/0004-debian-rules-Add-option-to-disable-webserver.patch (100%)
 rename recipes-core/swupdate/files/{ => 2021.11}/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch (100%)
 rename recipes-core/swupdate/files/{ => 2021.11}/0006-debian-prepare-build-for-isar-debian-buster.patch (100%)
 rename recipes-core/swupdate/files/{ => 2023.05}/0001-d-rules-Add-option-for-suricatta_lua.patch (87%)
 create mode 100644 recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
 create mode 100644 recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 create mode 100644 recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
 delete mode 100644 recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
 create mode 100644 recipes-core/swupdate/swupdate_2023.05.bb

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index f05d3d3..adafc92 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,6 +12,6 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_swupdate ?= "2022.12%"
+PREFERRED_VERSION_swupdate ?= "2023.05%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 9c83054..4f26299 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -15,6 +15,6 @@ require cip-core-common.inc
 DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
 DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
 
-PREFERRED_VERSION_swupdate ?= "2022.12%"
+PREFERRED_VERSION_swupdate ?= "2023.05%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index edd3c28..2e74af7 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -14,6 +14,7 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+PREFERRED_VERSION_swupdate ?= "2023.05%"
 
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
diff --git a/recipes-core/persistent-fs/files/data.mount b/recipes-core/persistent-fs/files/data.mount
new file mode 100644
index 0000000..dc64a91
--- /dev/null
+++ b/recipes-core/persistent-fs/files/data.mount
@@ -0,0 +1,13 @@
+[Unit]
+Description=Mount /data partition
+Before=local-fs.target
+
+[Mount]
+What=${PERSISTENT_PARTITION}
+Where=/data
+Type=auto
+Options=defaults
+
+
+[Install]
+WantedBy=local-fs.target
diff --git a/recipes-core/persistent-fs/files/postinst b/recipes-core/persistent-fs/files/postinst
new file mode 100755
index 0000000..8a13328
--- /dev/null
+++ b/recipes-core/persistent-fs/files/postinst
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+#deb-systemd-helper enable data.mount  || true
diff --git a/recipes-core/persistent-fs/persistent-fs_0.1.bb b/recipes-core/persistent-fs/persistent-fs_0.1.bb
new file mode 100644
index 0000000..c665b6c
--- /dev/null
+++ b/recipes-core/persistent-fs/persistent-fs_0.1.bb
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+SRC_URI = "file://postinst \
+           file://data.mount"
+
+do_install[cleandirs]+="${D}/lib/systemd/system"
+do_install[cleandirs]+="${D}/data"
+do_install() {
+    install -m 0644 ${WORKDIR}/data.mount ${D}/lib/systemd/system/data.mount
+}
diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
deleted file mode 100644
index e62a4fc..0000000
--- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From c3adc5d2be41e151c811c96f2bed245778fec82c Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 29 Sep 2021 11:29:57 +0200
-Subject: [PATCH 02/10] debian/rules: Add CONFIG_MTD
-
-if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/debian/rules b/debian/rules
-index 08b74a1..6705140 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -20,6 +20,7 @@ endif
- override_dh_auto_configure:
- 	cp debian/configs/defconfig  configs/debian_defconfig
- ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_MTD=y                  >> configs/debian_defconfig
- 	echo CONFIG_SWUFORWARDER_HANDLER=y >> configs/debian_defconfig
- 	echo CONFIG_CFI=y                  >> configs/debian_defconfig
- 	echo CONFIG_CFIHAMMING1=y          >> configs/debian_defconfig
--- 
-2.34.1
-
diff --git a/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/2021.11/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
similarity index 100%
rename from recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
rename to recipes-core/swupdate/files/2021.11/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/2021.11/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
similarity index 100%
rename from recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
rename to recipes-core/swupdate/files/2021.11/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/2021.11/0003-debian-rules-Add-option-to-disable-fs-creation.patch
similarity index 100%
rename from recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
rename to recipes-core/swupdate/files/2021.11/0003-debian-rules-Add-option-to-disable-fs-creation.patch
diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/2021.11/0004-debian-rules-Add-option-to-disable-webserver.patch
similarity index 100%
rename from recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
rename to recipes-core/swupdate/files/2021.11/0004-debian-rules-Add-option-to-disable-webserver.patch
diff --git a/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch b/recipes-core/swupdate/files/2021.11/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
similarity index 100%
rename from recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
rename to recipes-core/swupdate/files/2021.11/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
diff --git a/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/2021.11/0006-debian-prepare-build-for-isar-debian-buster.patch
similarity index 100%
rename from recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
rename to recipes-core/swupdate/files/2021.11/0006-debian-prepare-build-for-isar-debian-buster.patch
diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
similarity index 87%
rename from recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
rename to recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
index 0be5a71..5aeb605 100644
--- a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
+++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
@@ -1,7 +1,7 @@
-From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 2001
+From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 3 May 2023 16:02:37 +0200
-Subject: [PATCH] d/rules: Add option for suricatta_lua
+Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
 
 This allows to use lua plugins as suricatta backends. It is optional
 as it overrides the default HAWKBIT backend.
diff --git a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
new file mode 100644
index 0000000..4203061
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
@@ -0,0 +1,45 @@
+From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 15 Jun 2023 18:48:25 +0200
+Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for delta
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
+index 91106fbd..8cac6359 100755
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
diff --git a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
new file mode 100644
index 0000000..857b4ab
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -0,0 +1,94 @@
+From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 16 Jun 2023 19:43:38 +0200
+Subject: [PATCH 3/4] d/patches: Add patch to add the build version to swupdate
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
+index 00000000..7f964fb7
+--- /dev/null
++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
+@@ -0,0 +1,46 @@
++From bc50744125e8686ec2eb7e5676522da98e51601f Mon Sep 17 00:00:00 2001
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
++index 09d03a34..1004945c 100644
++--- a/Makefile
+++++ b/Makefile
++@@ -5,7 +5,7 @@
++ VERSION = 2023
++ PATCHLEVEL = 05
++ SUBLEVEL = 0
++-EXTRAVERSION =
+++EXTRAVERSION ?=
++ NAME =
++ 
++ IPCLIB_VERSION = 0.1
++diff --git a/Makefile.flags b/Makefile.flags
++index 2a021c89..8eada8fc 100644
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
+index 8cac6359..566a21bd 100755
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
+2.39.2
+
diff --git a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
new file mode 100644
index 0000000..9c5ebd3
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
@@ -0,0 +1,30 @@
+From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 16 Jun 2023 20:32:38 +0200
+Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
+
+Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
+suricattawfx lua module.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/rules | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/debian/rules b/debian/rules
+index 566a21bd..fc122d0d 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -61,6 +61,9 @@ endif
+ ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
+ endif
++ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
++	echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
++endif
+ ifneq (,$(LUA_VERSION))
+ 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
+ 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
+-- 
+2.39.2
+
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index da1434e..2384f41 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -15,6 +15,8 @@ require swupdate.inc
 DEB_BUILD_PROFILES += "nodoc"
 DEB_BUILD_OPTIONS += "nodoc"
 
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2021.11:"
+
 SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
 SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
 
diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
deleted file mode 100644
index da44ae5..0000000
--- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
+++ /dev/null
@@ -1,39 +0,0 @@
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
-inherit dpkg-gbp
-
-require swupdate.inc
-
-DEPENDS += "libebgenv-dev"
-
-DEB_BUILD_PROFILES += "nodoc"
-DEB_BUILD_OPTIONS += "nodoc"
-
-SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
-SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
-SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
-
-# deactivate signing and hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
-# use suricatta-lua instead of suricatta-hawkbit
-# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
-
-# Disable cross for arm and arm64 on bullseye
-# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
-ISAR_CROSS_COMPILE:bullseye = "0"
-
-# add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
-
-# use backport build profile for bullseye
-DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
new file mode 100644
index 0000000..26c0e67
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -0,0 +1,60 @@
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
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
+
+SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
+SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
+
+SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
+
+# patches
+SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
+            file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
+            file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
+            file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
+
+# deactivate signing and hardware compability for simple a/b rootfs update
+DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
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
+DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
+CHANGELOG_V ?= "${PV}+cip-${SRCREV_upstream}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.39.2


