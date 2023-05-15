Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16164C77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 14:14:43 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.89893.1684160074596155633
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 07:14:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bu/LlSHk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20230515141431bedc09f4249a21dfdb-ejjy9n@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230515141431bedc09f4249a21dfdb
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 May 2023 16:14:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=YbrtfUfvzEbe5khURKoNHFzxvV1DimT8p/jIs98jL10=;
 b=bu/LlSHk/Oeg+nijSZmbZ5OYmo0nhGwavShIEsYMPz4zQcOzcYak1hqcAYGa8a/CBPVdIx
 iHi5pEcfMqDcnLnpeI8BZbY5WHrbMwiOP5eN5hxkvIFs8iayBTqVN5c3CPBFbdt4MKGW4f+3
 bqyVNKWHT7HxcdllROr6xx3shFlfA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] swupdate: Add recipe for 2022.12 for bullseye and bookworm
Date: Mon, 15 May 2023 16:14:30 +0200
Message-Id: <20230515141430.13315-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 14:14:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11455

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows modified swupdate builds in cip-core. It also
adds the option to use suricatta-lua instead of the default
suricatta-hawkbit to communicate with a webserver.

`suricatta-lua` is currently in use for internal projects. Some of these
projects are planned to be released as open source.

To enable suricatta-lua add the following line to the swupdate recipe or
use a bbappend.
```
DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v3:
 - remove OVERRIDE for suricatta-lua
 - correct titel of PATCH from buster to bookworm
 - add description for DEB_BUILD_OPTIONS

Changes v2:
 - Add usage of `suricatta-lua` the to commit message
 - Add missing space to DEB_BUILD_PROFILES


 conf/distro/cip-core-bookworm.conf            |  1 +
 conf/distro/cip-core-bullseye.conf            |  4 ++
 conf/distro/cip-core-buster.conf              |  1 +
 ...eferences.swupdate-bullseye-backports.conf |  3 ++
 kas/opt/swupdate.yml                          |  1 +
 ...d-rules-Add-option-for-suricatta_lua.patch | 30 ++++++++++++++
 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 40 +++++++++++++++++++
 7 files changed, 80 insertions(+)
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
index 0000000..df0b3b2
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
@@ -0,0 +1,40 @@
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
+
+# use suricatta-lua instead of suricatta-hawkbit
+# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
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
-- 
2.39.2


