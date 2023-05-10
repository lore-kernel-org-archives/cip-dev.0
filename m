Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956FC77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 15:27:40 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.20439.1683732456025144540
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 08:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=G56CZuWP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202305101527313a8c586bb763d5d680-q0ilae@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202305101527313a8c586bb763d5d680
        for <cip-dev@lists.cip-project.org>;
        Wed, 10 May 2023 17:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=9IoHsUNX9YoExsw7dCLV49oMIMPTIfMW22JZOUoC/TY=;
 b=G56CZuWP19FUn4dH0FOmfVnanM69vBG4ypPWn9xKI4PFoxw8zZDBCX4IwIl1BCa+9hCgrH
 oXLsnbuWUxu5dTF4+rrUOOrbki/nF0XPofl2e0XAisiYisakja6Y+S/cqIacs5sWkEtduFsM
 K2kJjUioYHh84MDTHP3/o3sgonPiQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: Add recipe for 2022.12 for bullseye and buster
Date: Wed, 10 May 2023 17:27:30 +0200
Message-Id: <20230510152730.4060989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 15:27:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11435

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows modified swupdate builds in cip-core. It also
adds the option to use suricatta-lua instead of the default
suricatta-hawkbit to communicate with a webserver.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-bookworm.conf            |  1 +
 conf/distro/cip-core-bullseye.conf            |  4 +++
 conf/distro/cip-core-buster.conf              |  1 +
 ...eferences.swupdate-bullseye-backports.conf |  3 ++
 kas/opt/swupdate.yml                          |  1 +
 ...d-rules-Add-option-for-suricatta_lua.patch | 30 ++++++++++++++++
 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 35 +++++++++++++++++++
 7 files changed, 75 insertions(+)
 create mode 100644 conf/distro/preferences.swupdate-bullseye-backports.conf
 create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
 create mode 100644 recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index de2e435..f05d3d3 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_swupdate ?= "2022.12%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 3a0550c..9c83054 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -12,5 +12,9 @@
 require conf/distro/debian-bullseye.conf
 require cip-core-common.inc
 
+DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
+DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
+
+PREFERRED_VERSION_swupdate ?= "2022.12%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index c5cb39c..4e9a4a7 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-buster.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_swupdate ?= "2021.11%"
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
new file mode 100644
index 0000000..a2377bb
--- /dev/null
+++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
@@ -0,0 +1,3 @@
+Package: dh-nodejs
+Pin: release n=bullseye-backports
+Pin-Priority: 801
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 29b7dd6..1528b09 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -17,6 +17,7 @@ header:
 local_conf_header:
   image-option-swupdate: |
     CIP_IMAGE_OPTIONS:append = " swupdate.inc"
+    OVERRIDES .= ":swupdate"
 
   wic-swu: |
     IMAGE_TYPEDEP:wic += "squashfs"
diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
new file mode 100644
index 0000000..0be5a71
--- /dev/null
+++ b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
@@ -0,0 +1,30 @@
+From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Wed, 3 May 2023 16:02:37 +0200
+Subject: [PATCH] d/rules: Add option for suricatta_lua
+
+This allows to use lua plugins as suricatta backends. It is optional
+as it overrides the default HAWKBIT backend.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/rules | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/debian/rules b/debian/rules
+index 57da4ca7..91106fbd 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -56,6 +56,9 @@ endif
+ ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
+ endif
++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
++	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
++endif
+ ifneq (,$(LUA_VERSION))
+ 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
+ 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
+-- 
+2.39.2
+
diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
new file mode 100644
index 0000000..f5478a3
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
@@ -0,0 +1,35 @@
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
+inherit dpkg-gbp
+
+require swupdate.inc
+
+DEPENDS += "libebgenv-dev"
+
+DEB_BUILD_PROFILES += "nodoc"
+DEB_BUILD_OPTIONS += "nodoc"
+
+SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
+SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
+
+# deactivate signing and hardware compability for simple a/b rootfs update
+DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
+DEB_BUILD_PROFILES:append:suricatta-lua = "pkg.swupdate.suricattalua"
+
+# Disable cross for arm and arm64 on bullseye
+ISAR_CROSS_COMPILE:bullseye = "0"
+
+# add cross build and deactivate testing for arm based builds
+DEB_BUILD_PROFILES += "cross nocheck"
+DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
-- 
2.39.2


