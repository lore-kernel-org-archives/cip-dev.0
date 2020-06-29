Return-Path: <SRS0=ZJFt=AK=lists.cip-project.org=bounce+64572+4851+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A93C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9094D23750
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="g1fBOLuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9094D23750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4851+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ElvZYY4521723xLzckoAvzik; Mon, 29 Jun 2020 02:56:16 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.15360.1593424574891263799
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 02:56:15 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05T9uDUe026475
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 11:56:13 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.4.33])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05T9uBnu028120;
	Mon, 29 Jun 2020 11:56:12 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 2/5] patches: add libubootenv
Date: Mon, 29 Jun 2020 11:56:08 +0200
Message-Id: <20200629095611.3000-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6byM1wjWkBq0NLdKD2zA7kS1x4520388AA=
Content-Type: multipart/mixed; boundary="iO0KNnk0KMi6rX032HsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593424576;
 bh=dPHjnJn+toDo7mtKnVQlnrRO4RKi8jaYYdMLhVcFW58=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g1fBOLuWW6HyluiVCIXrL8Pz9+uiFI3YVcikmefUMSATfka3sS4qKb4fand8OUByBx7
 05HZdVaplBeX3qQgMSQVA2tq5tPU3ouYcCwnMNic4XcJF8nrjVxgpuiZrlOf8WcTo9Gxv
 2NLXOB/JjRauKXGD4W9ZkNFE+/s85+nt2G4=

--iO0KNnk0KMi6rX032HsG
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

swupdate 2020.04 requires libubootenv as build dependency.

libubootenv is a library that provides a hardware independent
way to access to U-Boot environment. U-Boot has its default environment
compiled board-dependently and this means that tools to access the environment
are also board specific, too.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../0001-u-boot-add-libubootenv.patch         | 169 ++++++++++++++++++
 kas-cip.yml                                   |   4 +
 2 files changed, 173 insertions(+)
 create mode 100644 isar-patches/0001-u-boot-add-libubootenv.patch

diff --git a/isar-patches/0001-u-boot-add-libubootenv.patch b/isar-patches/0001-u-boot-add-libubootenv.patch
new file mode 100644
index 0000000..10a5b4a
--- /dev/null
+++ b/isar-patches/0001-u-boot-add-libubootenv.patch
@@ -0,0 +1,169 @@
+From 76897e89977f895495e21e37cb76f90392d55ef9 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 19 Jun 2020 17:00:36 +0200
+Subject: [PATCH v2] u-boot: add libubootenv
+
+Add the new library libubootenv and remove fw_printenv and fw_setenv
+form u-boot-tools as the are now part of the new library.
+
+libubootenv is a library that provides a hardware independent
+way to access to U-Boot environment. U-Boot has its default environment
+compiled board-dependently and this means that tools to access the environment
+are also board specific, too.
+
+libubootenv conflicts with u-boot-tools from Debian 10
+as both try to install fw_printenv and fw_sentenv. This conflict is not
+part of the control file as it breaks the installation of custom u-boot-tools
+from the u-boot-sources.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta-isar/conf/machine/de0-nano-soc.conf      |  2 +-
+ .../libubootenv/files/debian/compat           |  1 +
+ .../libubootenv/files/debian/control.tmpl     | 15 +++++++++
+ .../libubootenv/files/debian/rules.tmpl       | 24 ++++++++++++++
+ .../libubootenv/libubootenv_0.2.bb            | 32 +++++++++++++++++++
+ .../files/debian/u-boot-tools.conffiles       |  1 -
+ .../u-boot/files/debian/u-boot-tools.install  |  2 --
+ .../u-boot/files/debian/u-boot-tools.links    |  1 -
+ 8 files changed, 73 insertions(+), 5 deletions(-)
+ create mode 100644 meta/recipes-bsp/libubootenv/files/debian/compat
+ create mode 100644 meta/recipes-bsp/libubootenv/files/debian/control.tmpl
+ create mode 100644 meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
+ create mode 100644 meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
+ delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
+ delete mode 100644 meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
+
+diff --git a/meta-isar/conf/machine/de0-nano-soc.conf b/meta-isar/conf/machine/de0-nano-soc.conf
+index 3a2c009..6558d90 100644
+--- a/meta-isar/conf/machine/de0-nano-soc.conf
++++ b/meta-isar/conf/machine/de0-nano-soc.conf
+@@ -15,4 +15,4 @@ WKS_FILE ?= "de0-nano-soc.wks.in"
+ IMAGER_INSTALL += "u-boot-de0-nano-soc"
+ IMAGER_BUILD_DEPS += "u-boot-de0-nano-soc"
+ 
+-IMAGE_INSTALL += "u-boot-tools u-boot-script"
++IMAGE_INSTALL += "u-boot-tools libubootenv u-boot-script"
+diff --git a/meta/recipes-bsp/libubootenv/files/debian/compat b/meta/recipes-bsp/libubootenv/files/debian/compat
+new file mode 100644
+index 0000000..b4de394
+--- /dev/null
++++ b/meta/recipes-bsp/libubootenv/files/debian/compat
+@@ -0,0 +1 @@
++11
+diff --git a/meta/recipes-bsp/libubootenv/files/debian/control.tmpl b/meta/recipes-bsp/libubootenv/files/debian/control.tmpl
+new file mode 100644
+index 0000000..fade69a
+--- /dev/null
++++ b/meta/recipes-bsp/libubootenv/files/debian/control.tmpl
+@@ -0,0 +1,15 @@
++Source: libubootenv
++Section: embedded
++Priority: optional
++Maintainer: Stefano Babic <sbabic@denx.de>
++Build-Depends: ${BUILD_DEB_DEPENDS}
++Standards-Version: 4.2.1
++Homepage: https://sbabic.github.io/libubootenv
++
++Package: libubootenv
++Architecture: any
++Depends: ${DEBIAN_DEPENDS}
++Description: libubootenv is a library that provides a hardware independent
++ way to access to U-Boot environment. U-Boot has its default environment
++ compiled board-dependently and this means that tools to access the environment
++ are also board specific, too.
+diff --git a/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl b/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
+new file mode 100644
+index 0000000..56ccd19
+--- /dev/null
++++ b/meta/recipes-bsp/libubootenv/files/debian/rules.tmpl
+@@ -0,0 +1,24 @@
++#!/usr/bin/make -f
++
++ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
++export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
++export CC=$(DEB_HOST_GNU_TYPE)-gcc
++export LD=$(DEB_HOST_GNU_TYPE)-gcc
++endif
++
++export DH_VERBOSE = 1
++
++export DEB_BUILD_MAINT_OPTIONS = hardening=+bindnow
++
++override_dh_auto_configure:
++	dh_auto_configure --
++
++%:
++	echo $@
++	dh $@
++
++override_dh_installchangelogs:
++	true
++
++override_dh_installdocs:
++	true
+diff --git a/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
+new file mode 100644
+index 0000000..1be058c
+--- /dev/null
++++ b/meta/recipes-bsp/libubootenv/libubootenv_0.2.bb
+@@ -0,0 +1,32 @@
++# libubootenv
++#
++# This software is a part of ISAR.
++# Copyright (c) Siemens AG, 2020
++#
++# SPDX-License-Identifier: MIT
++
++DESCRIPTION = "swupdate utility for software updates"
++HOMEPAGE= "https://github.com/sbabic/swupdate"
++LICENSE = "GPL-2.0"
++LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
++SRC_URI = "gitsm://github.com/sbabic/libubootenv.git;branch=master;protocol=https"
++
++SRCREV = "bf6ff631c0e38cede67268ceb8bf1383b5f8848e"
++
++BUILD_DEB_DEPENDS = "cmake, zlib1g-dev"
++
++SRC_URI += "file://debian"
++TEMPLATE_FILES = "debian/control.tmpl debian/rules.tmpl"
++TEMPLATE_VARS += "BUILD_DEB_DEPENDS DEFCONFIG DEBIAN_DEPENDS"
++
++
++inherit dpkg
++
++S = "${WORKDIR}/git"
++
++do_prepare_build() {
++        DEBDIR=${S}/debian
++        install -d ${DEBDIR}
++        cp -R ${WORKDIR}/debian ${S}
++        deb_add_changelog
++}
+diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
+deleted file mode 100644
+index d49a8fb..0000000
+--- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.conffiles
++++ /dev/null
+@@ -1 +0,0 @@
+-/etc/fw_env.config
+diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
+index d1ae3e0..2893b9a 100644
+--- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
++++ b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.install
+@@ -1,5 +1,3 @@
+ tools/dumpimage		/usr/bin/
+-tools/env/fw_printenv	/usr/bin/
+ tools/mkenvimage	/usr/bin/
+ tools/mkimage		/usr/bin/
+-tools/env/fw_env.config	/etc
+diff --git a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links b/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
+deleted file mode 100644
+index 92f5a6c..0000000
+--- a/meta/recipes-bsp/u-boot/files/debian/u-boot-tools.links
++++ /dev/null
+@@ -1 +0,0 @@
+-/usr/bin/fw_printenv /usr/bin/fw_setenv
+-- 
+2.20.1
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 019b31e..0da07db 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,6 +22,10 @@ repos:
     refspec: 351af175bc54a201c6f44307d4e998bd6c0afdb8
     layers:
       meta:
+    patches:
+      01-libubootenv:
+        path: isar-patches/0001-u-boot-add-libubootenv.patch
+        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.20.1


--iO0KNnk0KMi6rX032HsG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4851): https://lists.cip-project.org/g/cip-dev/message=
/4851
Mute This Topic: https://lists.cip-project.org/mt/75188183/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iO0KNnk0KMi6rX032HsG--
