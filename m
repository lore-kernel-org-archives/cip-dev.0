Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD62C48BEC
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 08:08:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.14261.1708070934589967777
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 00:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=frkL0jxJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240216080850be0b4976ceb4e4ada6-jqg8pb@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240216080850be0b4976ceb4e4ada6
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 09:08:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4Z+x6ETy3nlZLU4V8X6Ej8p8Ok4fZqrrQvJbZiNOxmQ=;
 b=frkL0jxJtCTW9bL2sTwrYkBleSzMWLbPHRyZmJQ9w0T68xFC7oBz7jWGUaKgDBgsbAVlLq
 WVaGYcbuJLzj5P0fxa+0uMIslcw8CfHF+awXpzQlx5RlQ5b8pI7RQIUSjaqu8AOVFFRDPW+s
 bMdI1fuNHXv7VZg96Z6XqNOfBmIEE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 2/3] add SWUpdate 2022.12
Date: Fri, 16 Feb 2024 09:07:14 +0100
Message-ID: <20240216080848.9146-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240216080848.9146-1-Quirin.Gylstorff@siemens.com>
References: <20240216080848.9146-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 08:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15007

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

SWUpdate changed the Suricatta lua API in release 2023.05.
To support released legacy applications add SWUpdate 2022.12
which supports the old api.

We use the latest release from salsa[1].

[1]: https://salsa.debian.org/debian/swupdate/-/tree/debian/2022.12+dfsg-4?ref_type=tags

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate-2022.12.yaml                 | 21 +++++
 ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
 .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 kas/opt/swupdate-2022.12.yaml
 create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
 create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
 create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb

diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
new file mode 100644
index 0000000..cbaa4b5
--- /dev/null
+++ b/kas/opt/swupdate-2022.12.yaml
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
+# from the first wic partition
+
+header:
+  version: 14
+  includes:
+   - kas/opt/swupdate.yml
+
+local_conf_header:
+  swupdate-2022.12: |
+    PREFERRED_VERSION_swupdate = "2022.12%"
diff --git a/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
new file mode 100644
index 0000000..dafbf6d
--- /dev/null
+++ b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
@@ -0,0 +1,27 @@
+From 451a80e1a98d7f6abd287215e7cac3929eebe025 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 15 Feb 2024 11:06:52 +0100
+Subject: [PATCH 1/2] Add option to enable surricatta-lua
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ debian/rules | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/debian/rules b/debian/rules
+index 57da4ca7..a78d9ca8 100755
+--- a/debian/rules
++++ b/debian/rules
+@@ -56,6 +56,9 @@ endif
+ ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
+ 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
+ endif
++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
++	echo CONFIG_SURICATTA_LUA=y              >> configs/debian_defconfig
++endif
+ ifneq (,$(LUA_VERSION))
+ 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
+ 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
new file mode 100644
index 0000000..4ff7419
--- /dev/null
+++ b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
@@ -0,0 +1,94 @@
+From 356ed7987a489f0259c0878117a4cac8e22ba8d5 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 16 Jun 2023 19:43:38 +0200
+Subject: [PATCH 2/2] d/patches: Add patch to add the build version to swupdate
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
+index a78d9ca8..1bc70f84 100755
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
+2.43.0
+
diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
new file mode 100644
index 0000000..fcccc2c
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
@@ -0,0 +1,41 @@
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
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2022.12:"
+
+SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
+
+SRCREV = "aa9edf070567fa5b3e942c270633a8feef49dad8"
+SRC_URI += "file://0001-Add-option-to-enable-surricatta-lua.patch"
+SRC_URI += "file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
+
+ISAR_CROSS_COMPILE:bullseye = "0"
+
+DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
+
+# use backport build profile for bullseye
+DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
+
+CHANGELOG_V ?= "${PV}-${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.43.0


