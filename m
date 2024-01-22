Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A2C47DDB
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 12:38:00 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.72530.1705927075843946712
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 04:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Trp0CeHZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024012212375391b8346f511d08a695-zklscn@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024012212375391b8346f511d08a695
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 13:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8gdVGx4Z5xq8iYax84Yl9Na4eLxa7Y9TBY/9za/LuH8=;
 b=Trp0CeHZrSQ4rHhFHMlysEcCnRdOv7RC9Whw58Mlj01EW9DXHadmz1k/8FUAumpQS64TT9
 JbbkYABzXJXjdHMOW5F5PFXT2SsoLqJPnjaLS/k0Cb31jVgqNfty7DxWKuhhAJ2q5d/g0Hos
 bzDvkYNBFaYQ30Wz64hx+ItnMbSho=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 4/4] swupdate: Add patch to copy the server_wfx.lua to /usr/share
Date: Mon, 22 Jan 2024 13:37:15 +0100
Message-ID: <20240122123751.83696-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 12:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14434

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to use wfx together with swupdate with out embedding
server_wfx.lua.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...rate-build_profile-option-for-delta-.patch |  8 ++--
 ...tch-to-add-the-build-version-to-swup.patch |  6 +--
 ...s-Add-option-to-enable-suricatta_wfx.patch |  6 +--
 ...install-Fix-path-for-debian-bullseye.patch |  6 +--
 ...tall-server_wfx.lua-to-usr-share-lua.patch | 44 +++++++++++++++++++
 recipes-core/swupdate/swupdate_2023.05.bb     |  8 +---
 6 files changed, 58 insertions(+), 20 deletions(-)
 create mode 100644 recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch

diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
index 0d0fc0a..4a63dfd 100644
--- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
+++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
@@ -1,7 +1,7 @@
-From 03d455be74d439c7e2eb849e5acdfb494afb3d7c Mon Sep 17 00:00:00 2001
+From ce4e66c37fd6f2cb147fd0e75cfcabebdef3abd5 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Thu, 15 Jun 2023 18:48:25 +0200
-Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for delta
+Subject: [PATCH 1/6] d/rules: Add seperate build_profile option for delta
  update
 
 Delta update need zchunk 1.3 to work on memory restricted
@@ -15,7 +15,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/debian/control b/debian/control
-index a389b2a9..2f0c0053 100644
+index acbecd47..a0d4edcc 100644
 --- a/debian/control
 +++ b/debian/control
 @@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
@@ -41,5 +41,5 @@ index 3b1cc0f6..2c91677c 100755
  endif
  ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
 -- 
-2.42.0
+2.43.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
index 8056818..65c3cb6 100644
--- a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
+++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -1,7 +1,7 @@
-From ad714bc12b03c148aadb3523f87cc14d42a477b0 Mon Sep 17 00:00:00 2001
+From 384613cc6d0b87e58cf8ca9636f65730b0790061 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Fri, 16 Jun 2023 19:43:38 +0200
-Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
+Subject: [PATCH 2/6] d/patches: Add patch to add the build version to swupdate
 
 The build version is only set if build in a git repository
 this patch allows to use the version information stored in
@@ -90,5 +90,5 @@ index 2c91677c..5d72987c 100755
  ifeq (linux,$(DEB_HOST_ARCH_OS))
  	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
 -- 
-2.42.0
+2.43.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
index 87c60d7..e320665 100644
--- a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
+++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
@@ -1,7 +1,7 @@
-From fae97f0e23f945c1ab6e767451cda1d2798aa348 Mon Sep 17 00:00:00 2001
+From 2be6e19412eb44c55b648bb8f34acf4e87bb0d3a Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Fri, 16 Jun 2023 20:32:38 +0200
-Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
+Subject: [PATCH 3/6] d/rules: Add option to enable suricatta_wfx
 
 Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
 suricattawfx lua module.
@@ -26,5 +26,5 @@ index 5d72987c..d7ff5510 100755
  	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
  	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
 -- 
-2.42.0
+2.43.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
index b2d831d..a1e8bc7 100644
--- a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
+++ b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
@@ -1,7 +1,7 @@
-From f2184e7573e705bad408cf1422599b967773d48e Mon Sep 17 00:00:00 2001
+From 4ee463885ce2532b5bdf8beb6106e357670a737a Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Thu, 16 Nov 2023 16:40:19 +0100
-Subject: [PATCH 4/4] d/swupdate-www.install: Fix path for debian-bullseye
+Subject: [PATCH 4/6] d/swupdate-www.install: Fix path for debian-bullseye
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -20,5 +20,5 @@ index 7e3d95c6..9c6113cc 100644
  web-app/js           /usr/share/swupdate/www
  web-app/node_modules /usr/share/swupdate/www
 -- 
-2.42.0
+2.43.0
 
diff --git a/recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch b/recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch
new file mode 100644
index 0000000..a4c960a
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch
@@ -0,0 +1,44 @@
+From c34282446c928d7a1603b7dd825de7e1ddede829 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Mon, 15 Jan 2024 13:28:42 +0100
+Subject: [PATCH 5/6] d/rules: install server_wfx.lua to /usr/share/lua
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/lua-swupdate.install | 1 +
+ debian/rules                | 5 +++++
+ 2 files changed, 6 insertions(+)
+
+diff --git a/debian/lua-swupdate.install b/debian/lua-swupdate.install
+index afde2a68..6cd5436c 100644
+--- a/debian/lua-swupdate.install
++++ b/debian/lua-swupdate.install
+@@ -1 +1,2 @@
++examples/suricatta/swupdate_suricatta.lua usr/share/lua/5.3/
+ usr/lib/*/lua/*/lua_swupdate*.so*
+diff --git a/debian/rules b/debian/rules
+index d7ff5510..8be9221f 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -71,6 +71,10 @@ endif
+ 	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
+ 	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
+ 	$(MAKE) debian_defconfig
++ifneq (,$(LUA_VERSION))
++	mv suricatta/server_wfx.lua suricatta/swupdate_suricatta.lua
++	echo "suricatta/swupdate_suricatta.lua /usr/share/lua/$(LUA_VERSION)" >> debian/swupdate.install
++endif
+ 
+ override_dh_auto_build:
+ ifeq (,$(filter nodoc,$(DEB_BUILD_OPTIONS) $(DEB_BUILD_PROFILES)))
+@@ -97,6 +101,7 @@ endif
+ endif
+ 
+ override_dh_auto_install:
++
+ 	dh_auto_install -- V=1
+ 
+ override_dh_installsystemd:
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index d1fe1fa..7533bfa 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -28,15 +28,9 @@ SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
 # patches
 SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
             file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
-            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
+            file://0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch"
 SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
 
-# suricatta wfx requires suricatta lua and the dependency
-# is not set automatically
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
-# add suricatta wfx
-DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
-
 # Disable cross for arm and arm64 on bullseye
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"
-- 
2.43.0


