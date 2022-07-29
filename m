Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0705C48BEA
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 08:39:42 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.5788.1659083977163424319
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=YBCmH0Kq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-202207290839348921a5143c3e6a2249-4mcpgk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202207290839348921a5143c3e6a2249
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 10:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ekMv7LiVvF2MXSm/wh6FURXAGuwJbvgXqcU8kTx4qRA=;
 b=YBCmH0KqCWk1ytle22KCZEb+8kwYvQ7HAR9JrgH+PZg8jgt0kPt+T8E8nLQjegrgIEraZW
 wEQgH6wAlqeO9JKztZf9JxZ/1p2NGzR5VAGXMlK3JLze3pBvbeGyiRizeTiZWo28QWFXleH+
 hMjcNDI6cfnfkGjDdPQ6oihAICE2Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/4] recipes-devtools/ovmf-binaries:
 Adapt to sbuild environment
Date: Fri, 29 Jul 2022 10:39:30 +0200
Message-Id: <20220729083931.419731-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 08:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8974

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Due to sbuild we can no longer access the build chroot with all installed
packages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../ovmf-binaries/files/control.tmpl           | 11 -----------
 recipes-devtools/ovmf-binaries/files/rules     | 17 +++++++++++++++++
 .../ovmf-binaries/ovmf-binaries_0.1.bb         | 18 +++++++++++-------
 3 files changed, 28 insertions(+), 18 deletions(-)
 delete mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
 create mode 100644 recipes-devtools/ovmf-binaries/files/rules

diff --git a/recipes-devtools/ovmf-binaries/files/control.tmpl b/recipes-devtools/ovmf-binaries/files/control.tmpl
deleted file mode 100644
index 54641d6..0000000
--- a/recipes-devtools/ovmf-binaries/files/control.tmpl
+++ /dev/null
@@ -1,11 +0,0 @@
-Source: ${PN}
-Section: misc
-Priority: optional
-Standards-Version: 3.9.6
-Maintainer: ${MAINTAINER}
-Build-Depends: debhelper (>= 9), ${DEBIAN_BUILD_DEPENDS}
-
-Package: ${PN}
-Architecture: ${DPKG_ARCH}
-Depends: ${DEBIAN_DEPENDS}
-Description: ${DESCRIPTION}
diff --git a/recipes-devtools/ovmf-binaries/files/rules b/recipes-devtools/ovmf-binaries/files/rules
new file mode 100644
index 0000000..dcbef80
--- /dev/null
+++ b/recipes-devtools/ovmf-binaries/files/rules
@@ -0,0 +1,17 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# This file is subject to the terms and conditions of the MIT License.
+# See COPYING.MIT file in the top-level directory.
+#
+
+override_dh_auto_configure:
+	mkdir -p /home/builder/ovmf-binaries/image/var/share/
+	cp -r /usr/share/OVMF /home/builder/ovmf-binaries/image/var/share/
+
+%:
+	dh $@
diff --git a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
index 6524300..0f4592a 100644
--- a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
+++ b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
@@ -14,18 +14,22 @@ inherit dpkg-raw
 DESCRIPTION = "Copy the OVMF biniaries from the build changeroot to the deploy dir"
 
 # this is a empty debian package
-SRC_URI = "file://control.tmpl"
+SRC_URI = "file://rules"
 
 DEBIAN_BUILD_DEPENDS = "ovmf"
-TEMPLATE_FILES = "control.tmpl"
-TEMPLATE_VARS += "PN DEBIAN_DEPENDS MAINTAINER DESCRIPTION DPKG_ARCH DEBIAN_BUILD_DEPENDS"
 
 SSTATETASKS = ""
 
-do_extract_ovmf() {
+do_install() {
+     install -v -d ${D}/var/share
+     touch ${D}/var/share/test
+}
+
+do_deploy() {
     install -m 0755 -d ${DEPLOY_DIR_IMAGE}
-    cp -r ${BUILDCHROOT_DIR}/usr/share/OVMF ${DEPLOY_DIR_IMAGE}
-    chown $(id -u):$(id -g) ${DEPLOY_DIR_IMAGE}/OVMF
+    dpkg --extract ${WORKDIR}/${PN}_${PV}*.deb ${WORKDIR}
+    cp -r ${WORKDIR}/var/share/OVMF ${DEPLOY_DIR_IMAGE}
 }
+addtask do_deploy after do_dpkg_build before do_deploy_deb
+
 
-addtask do_extract_ovmf after do_install_builddeps before do_dpkg_build
-- 
2.35.1


