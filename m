Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259EAC4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 13:45:12 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.20316.1707313508826959928
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 05:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=S4XaLRpp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202402071345063bc0d77c64936fb87e-kggro8@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202402071345063bc0d77c64936fb87e
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Feb 2024 14:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/Z8+aQfCZeMSDDfsHaXTRO/7HLZybL+7MTYEaRxjPvc=;
 b=S4XaLRpp/YI5CweD4BnRJpSxWCPYFs/fY2zHn/ZEpDZP0x0oXXjD06gE6iHbhRhYKHJZ5l
 iN+vg3pRFXS5P4BPvH2uFvYmptBl1va+plMqWOwi4jsjjLvMXnUBkcjKHxve1So0ihOUvCnW
 me72tmhZZA6OtLG7IxGoEKl4oPk68=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/3] swupdate-config: move swupdate.cfg from customizations to own recipe
Date: Wed,  7 Feb 2024 14:44:25 +0100
Message-ID: <20240207134505.3286003-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
References: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 13:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14883

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows downstream customizations without including unwanted
packages.

It also adds the possibilty to set the SWU_HW_COMPAT

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
index 0000000..ec1d667
--- /dev/null
+++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
@@ -0,0 +1 @@
+cip-${MACHINE} ${IMAGE_HW_VERSION}
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


