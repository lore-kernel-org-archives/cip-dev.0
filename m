Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB4C48BF1
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 15:53:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.17206.1708012436111872986
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 07:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GFqmW/Xt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2024021515535150db600cd02c93ca45-vj899y@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024021515535150db600cd02c93ca45
        for <cip-dev@lists.cip-project.org>;
        Thu, 15 Feb 2024 16:53:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B+5OxU/5EHXHonSgLx82UNhWIoikErw1XMJjnhbp56Q=;
 b=GFqmW/Xts47yElGdkdPN1I1Z+L6YgRmv1M6F8nLYq6rd+rfI5SGjXlZuTImUxinamIehH0
 ud2cmHo8vc/yoMNEIIWClKkmlQKG/YnI8bbmYD5thFTJbuB0H8+YmVEIjjZ2L2aMeVroGonb
 PZkg/exMoHfq/faVeTQvs17NugMo8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 1/3] swupdate delete unused patch
Date: Thu, 15 Feb 2024 16:53:26 +0100
Message-ID: <20240215155350.434472-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
References: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 15:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15003

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...tch-to-add-the-build-version-to-swup.patch | 94 -------------------
 1 file changed, 94 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch

diff --git a/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
deleted file mode 100644
index efc584b..0000000
--- a/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
+++ /dev/null
@@ -1,94 +0,0 @@
-From 48963be5c3cd33ed9f36db52130cbd1dda3ed007 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Fri, 16 Jun 2023 19:43:38 +0200
-Subject: [PATCH] d/patches: Add patch to add the build version to swupdate
-
-The build version is only set if build in a git repository
-this patch allows to use the version information stored in
-the Makefile.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
- debian/patches/series                         |  1 +
- debian/rules                                  |  2 +
- 3 files changed, 49 insertions(+)
- create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-
-diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-new file mode 100644
-index 00000000..480b67f5
---- /dev/null
-+++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
-@@ -0,0 +1,46 @@
-+From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
-+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-+Date: Sat, 17 Jun 2023 17:56:18 +0200
-+Subject: [PATCH] Makefile.flags: Set version if git returns no information
-+
-+This set the swupdate version if build in a non git environment.
-+E.g. pristine-tar build or from a release tarball.
-+
-+Also allows to set the EXTRAVERSION from the command line.
-+
-+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-+---
-+ Makefile       | 2 +-
-+ Makefile.flags | 3 +++
-+ 2 files changed, 4 insertions(+), 1 deletion(-)
-+
-+diff --git a/Makefile b/Makefile
-+index 9f6a33a6..56189688 100644
-+--- a/Makefile
-++++ b/Makefile
-+@@ -5,7 +5,7 @@
-+ VERSION = 2022
-+ PATCHLEVEL = 12
-+ SUBLEVEL = 0
-+-EXTRAVERSION =
-++EXTRAVERSION ?=
-+ NAME =
-+ 
-+ IPCLIB_VERSION = 0.1
-+diff --git a/Makefile.flags b/Makefile.flags
-+index 2bec8468..f69ab5e8 100644
-+--- a/Makefile.flags
-++++ b/Makefile.flags
-+@@ -7,6 +7,9 @@
-+ # ==========================================================================
-+ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
-+ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
-++ifeq (,$(SWU_VER))
-++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
-++endif
-+ export SWU_VER
-+ SKIP_STRIP ?= n
-+ 
-+-- 
-+2.39.2
-+
-diff --git a/debian/patches/series b/debian/patches/series
-index 5638bbf5..12324569 100644
---- a/debian/patches/series
-+++ b/debian/patches/series
-@@ -1,3 +1,4 @@
- Link-config-to-swupdate-www-path.diff
- Replace-Font-Awesome-5-with-Fork-Awesome.diff
- use-gcc-compiler.diff
-+Makefile.flags-Set-version-if-git-returns-no-informa.diff
-diff --git a/debian/rules b/debian/rules
-index 57da4ca7..f645cc6e 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -17,6 +17,8 @@ export DH_WITH=--with lua
- export HAVE_LUA=y
- endif
- 
-+DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
-+export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
- BU_SWU=
- ifeq (linux,$(DEB_HOST_ARCH_OS))
- 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
--- 
-2.39.2
-
-- 
2.43.0


