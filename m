Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B054C48BC4
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 15:30:31 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21578.1708097428358512616
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 07:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ibGbeXtp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240216153025a0f68c8e247651b6eb-tjw5y0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240216153025a0f68c8e247651b6eb
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 16:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gFHeFtwB7CJhWmJfJ3kyZu2Lsot7qoAWZqb2W8RYz6s=;
 b=ibGbeXtp+yji9LTTduNV5MlevZjSeHOEMlg89N9nVUfB8lI0ZLNtivZ5EWcYwobpNstxN1
 cPncuNy7ll1Ua7rpot2tMHRDe/vOh5pA2+remxF8SVVwTKpHmtsuCMzim3kX2bueSP+eyUuQ
 FOW7CD3fHK2YJVyOboGDRDESBwjLo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 1/4] swupdate-config: move swupdate.cfg from customizations to own recipe
Date: Fri, 16 Feb 2024 16:30:02 +0100
Message-ID: <20240216153024.260416-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
References: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 15:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15014

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows downstream customizations without including unwanted
packages.

It also adds the new variable `MACHINE_HW_VERSION` to check the
compatibility between machine/image and the swupdate file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc        |  8 ++----
 .../swupdate-config/files/hwrevision.tmpl     |  1 +
 .../files/swupdate.cfg                        |  0
 .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
 rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
 create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 79bf80d..37872c1 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,8 +19,6 @@ SRC_URI = " \
     file://99-silent-printk.conf \
     file://99-watchdog.conf"
 
-SRC_URI:append:swupdate = " file://swupdate.cfg"
-
 CUSTOM_HOSTNAME ??= "demo"
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
@@ -29,12 +27,14 @@ TEMPLATE_FILES += "postinst.tmpl"
 TEMPLATE_VARS += "CUSTOM_HOSTNAME"
 
 DEPENDS += "sshd-regen-keys change-root-homedir"
+RDEPENDS:append:swupdate = " swupdate-config"
 
 DEBIAN_DEPENDS = " \
     ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
     change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
 	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
+DEBIAN_DEPENDS:append:swupdate = ", swupdate-config"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
@@ -46,7 +46,3 @@ do_install() {
 	install -v -d ${D}/etc/systemd/system.conf.d
 	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
 }
-
-do_install:append:swupdate() {
-	install -v -m 644 ${WORKDIR}/swupdate.cfg ${D}/etc/
-}
diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
new file mode 100644
index 0000000..1eb0996
--- /dev/null
+++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
@@ -0,0 +1 @@
+cip-${MACHINE} ${MACHINE_HW_VERSION}
diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
similarity index 100%
rename from recipes-core/customizations/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg
diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
new file mode 100644
index 0000000..6991321
--- /dev/null
+++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI = "file://swupdate.cfg \
+           file://hwrevision.tmpl"
+
+MACHINE_HW_VERSION ??= ""
+TEMPLATE_FILES += "hwrevision.tmpl"
+TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
+
+do_install[cleandirs] = "${D}/etc/"
+do_install() {
+	install -v -m 644 "${WORKDIR}"/swupdate.cfg "${D}"/etc/
+        if [ -n "${MACHINE_HW_VERSION}" ]; then
+            install -v -m 644 "${WORKDIR}"/hwrevision "${D}"/etc/
+        fi
+}
-- 
2.43.0


