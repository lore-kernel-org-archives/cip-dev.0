Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303A8C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 16:38:03 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.17271.1699979875858279864
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Nov 2023 08:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BiQsr1dM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20231114163752102bb4970679e369f4-c76xfp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231114163752102bb4970679e369f4
        for <cip-dev@lists.cip-project.org>;
        Tue, 14 Nov 2023 17:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Bxw71nxSM/xzmDVe0s+/D68BWx28NnywtdLSn9LdgMU=;
 b=BiQsr1dM51qwDRkf4IqaCG5YDaBDR8D2Qqkzhi+FWZWu9FBhDcuM2cw2HwdmfSNLYOTO8v
 cYmXjRVh/SOsWbpax5BbI+Wg03wp3Llp/zRKjO+2lv4fISOMMcpyqKmBPTp4i2DkqmIsiaGb
 l3UoGdxrmGyWZFgS1g9+IORwrscCc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: Update debian folder to 2023.05+dfsg-4
Date: Tue, 14 Nov 2023 17:37:32 +0100
Message-ID: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Nov 2023 16:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13579

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the system user swupdate and changes the permission
of the sockets to 0660 instead of world writable.

Also suricatta lua is now set automatically.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...d-rules-Add-option-for-suricatta_lua.patch | 30 -------------------
 ...ate-build_profile-option-for-delta-.patch} | 16 +++++-----
 ...ch-to-add-the-build-version-to-swup.patch} |  8 ++---
 ...-Add-option-to-enable-suricatta_wfx.patch} | 14 ++++-----
 recipes-core/swupdate/swupdate_2023.05.bb     | 15 ++++------
 5 files changed, 24 insertions(+), 59 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
 rename recipes-core/swupdate/files/2023.05/{0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch => 0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch} (76%)
 rename recipes-core/swupdate/files/2023.05/{0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
 rename recipes-core/swupdate/files/2023.05/{0004-d-rules-Add-option-to-enable-suricatta_wfx.patch => 0003-d-rules-Add-option-to-enable-suricatta_wfx.patch} (69%)

diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
deleted file mode 100644
index 5aeb605..0000000
--- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 3 May 2023 16:02:37 +0200
-Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
-
-This allows to use lua plugins as suricatta backends. It is optional
-as it overrides the default HAWKBIT backend.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/debian/rules b/debian/rules
-index 57da4ca7..91106fbd 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -56,6 +56,9 @@ endif
- ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
- endif
-+ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
-+endif
- ifneq (,$(LUA_VERSION))
- 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
- 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
--- 
-2.39.2
-
diff --git a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
similarity index 76%
rename from recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
rename to recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
index 4203061..d92860e 100644
--- a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
+++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
@@ -1,7 +1,7 @@
-From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
+From 8d9d7b561f311b2bd2757ee3f14ca51b22563118 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Thu, 15 Jun 2023 18:48:25 +0200
-Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for delta
+Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for delta
  update
 
 Delta update need zchunk 1.3 to work on memory restricted
@@ -15,20 +15,20 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/debian/control b/debian/control
-index e47c320c..d4b17972 100644
+index a389b2a9..2f0c0053 100644
 --- a/debian/control
 +++ b/debian/control
-@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
+@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
                 uuid-dev,
                 zlib1g-dev,
                 libzstd-dev,
--               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
+-               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
 +               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
                 libp11-kit-dev <pkg.swupdate.p11>,
-                libwolfssl-dev <pkg.swupdate.p11>,
+                libwolfssl-dev (>= 5),
                 libmtd-dev [linux-any],
 diff --git a/debian/rules b/debian/rules
-index 91106fbd..8cac6359 100755
+index 05422d68..97afc92b 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
@@ -41,5 +41,5 @@ index 91106fbd..8cac6359 100755
  endif
  ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
 -- 
-2.39.2
+2.42.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
similarity index 94%
rename from recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
rename to recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
index 857b4ab..f6092af 100644
--- a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
+++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -1,7 +1,7 @@
-From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
+From 81e9c0d781314bfff479bd5cb6a778f5d4e08ac3 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Fri, 16 Jun 2023 19:43:38 +0200
-Subject: [PATCH 3/4] d/patches: Add patch to add the build version to swupdate
+Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
 
 The build version is only set if build in a git repository
 this patch allows to use the version information stored in
@@ -77,7 +77,7 @@ index 5638bbf5..12324569 100644
  use-gcc-compiler.diff
 +Makefile.flags-Set-version-if-git-returns-no-informa.diff
 diff --git a/debian/rules b/debian/rules
-index 8cac6359..566a21bd 100755
+index 97afc92b..18cd7643 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -17,6 +17,8 @@ export DH_WITH=--with lua
@@ -90,5 +90,5 @@ index 8cac6359..566a21bd 100755
  ifeq (linux,$(DEB_HOST_ARCH_OS))
  	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
 -- 
-2.39.2
+2.42.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
similarity index 69%
rename from recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
rename to recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
index 9c5ebd3..8a5bd82 100644
--- a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
+++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
@@ -1,7 +1,7 @@
-From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
+From 319f0d2f54781ef207bf16a4c85dc8de20796ed4 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Fri, 16 Jun 2023 20:32:38 +0200
-Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
+Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
 
 Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
 suricattawfx lua module.
@@ -12,12 +12,12 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/debian/rules b/debian/rules
-index 566a21bd..fc122d0d 100755
+index 18cd7643..9635adb1 100755
 --- a/debian/rules
 +++ b/debian/rules
-@@ -61,6 +61,9 @@ endif
- ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
+@@ -58,6 +58,9 @@ endif
+ ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
  endif
 +ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
 +	echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
@@ -26,5 +26,5 @@ index 566a21bd..fc122d0d 100755
  	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
  	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
 -- 
-2.39.2
+2.42.0
 
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index 762fac2..8d50ec3 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -22,16 +22,14 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
 SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
 SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
 
-SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRCREV_debian = "78cb6f20319d2b911e170eea5305f2cf0bd33030"
 SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
 
 # patches
-SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
-            file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
-            file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
-            file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
-
-
+SRC_URI += " file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
+            file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
+            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch \
+            "
 # The option: "pkg.swupdate.nosigning" disables the required signing
 # of update binaries
 # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
@@ -39,9 +37,6 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
 # deactivate hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
 
-# suricatta wfx requires suricatta lua and the dependency
-# is not set automatically
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
 # add suricatta wfx
 DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
 
-- 
2.42.0


