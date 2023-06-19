Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4CEB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 15:53:44 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.11062.1687190013736684918
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 08:53:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=nEJ6bDpm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230619155330de6aaf497bfe871c52-k7dsyj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230619155330de6aaf497bfe871c52
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jun 2023 17:53:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xMIyJ487wUZVWQThACO7CYQzUc1rGzXPXYupQ4M6n+0=;
 b=nEJ6bDpmDtnvgHNDRS/7ePh54TdmKtIY/vIjqppzlpT84Gk03yaweNbV2Lqm4O2XM81KF/
 jlVr8jDdSwC9SV6DFFlQC9XNJl1IyP+jofrCWTu+A8hdM8HkHcfosoEs948rUTUTLvlyL3+3
 iFO0GvRRVjLxEQqWg41tyL7IU5Tk8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	felix.moessbauer@siemens.com
Subject: [PATCH] swupdate: Patch to add the missing build version
Date: Mon, 19 Jun 2023 17:53:21 +0200
Message-Id: <20230619155321.475974-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 15:53:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12079

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

swupdate generates the runtime version only in a git repository. As
the Debian build uses a tarball for the source code no version
is generated.

This patch uses the version included in the SWUpdate Makefile and the
debian/changelog to generate the version string.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

This patch is for swupdate 2022.12.

 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   |  9 ++
 2 files changed, 103 insertions(+)
 create mode 100644 recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch

diff --git a/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
new file mode 100644
index 0000000..efc584b
--- /dev/null
+++ b/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -0,0 +1,94 @@
+From 48963be5c3cd33ed9f36db52130cbd1dda3ed007 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 16 Jun 2023 19:43:38 +0200
+Subject: [PATCH] d/patches: Add patch to add the build version to swupdate
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
+index 00000000..480b67f5
+--- /dev/null
++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
+@@ -0,0 +1,46 @@
++From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
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
++index 9f6a33a6..56189688 100644
++--- a/Makefile
+++++ b/Makefile
++@@ -5,7 +5,7 @@
++ VERSION = 2022
++ PATCHLEVEL = 12
++ SUBLEVEL = 0
++-EXTRAVERSION =
+++EXTRAVERSION ?=
++ NAME =
++ 
++ IPCLIB_VERSION = 0.1
++diff --git a/Makefile.flags b/Makefile.flags
++index 2bec8468..f69ab5e8 100644
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
+index 57da4ca7..f645cc6e 100755
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
diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
index da44ae5..4401bd0 100644
--- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
@@ -20,6 +20,7 @@ DEB_BUILD_OPTIONS += "nodoc"
 SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
 SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
 SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
+SRC_URI += "file://0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
 
 # deactivate signing and hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
@@ -37,3 +38,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
 
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
+
+CHANGELOG_V ?= "2022.12+dfsg-4+cip+${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+}
+
-- 
2.39.2


