Return-Path: <SRS0=bQOV=PB=lists.cip-project.org=bounce+64572+6813+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4FC4332F
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03080610EA
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 03080610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 48xQYY4521723xfJN379i24a; Wed, 13 Oct 2021 06:40:57 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.8381.1634132456510087465
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:40:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DDesYs004542
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:40:54 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDerfJ007799;
	Wed, 13 Oct 2021 15:40:54 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to own recipe
Date: Wed, 13 Oct 2021 15:40:50 +0200
Message-ID: <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KinvpAaxmsPhudZCymja9bR3x4520388AA=
Content-Type: multipart/mixed; boundary="ydi4CdhsCRGGDuxQgBMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634132457;
 bh=D4OIELvzX25aDE9K3VhEKhAXlo4V4xpO/uHAwta+0kQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QbUW/g0CRuIitaaKKTvNOMW9S0uaKsy2a+iEzdpHGoia9Oc1R26jC1xbffiMf1UyVGr
 cXcvpc0E7cNBNpLB0cPaCo16GAIGDK9rhiAqMgOUgADCvPdJRyOrkqvqHD7ZsFCZC3eJ3
 lje+bvDfkF1STk5xx+8MJ7B7v42EQXOokFE=
Message-ID: <20211013134050.PXBQh_9mNKoNcllVg5hiaWqBJbzikiu3MGJkece6cBs@z>

--ydi4CdhsCRGGDuxQgBMH
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Split the SWUpdate lua handler into a seperate recipe in
preparation for using the Debian provided SWUpdate package.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass               |  8 -----
 kas/opt/swupdate.yml                          |  1 +
 .../swupdate.handler.efibootguard.ini         |  0
 .../files/swupdate.handler.efibootguard.ini   |  0
 .../swupdate-handler-roundrobin_0.1.bb        | 32 +++++++++++++++++++
 recipes-core/swupdate/swupdate.bb             | 13 --------
 6 files changed, 33 insertions(+), 21 deletions(-)
 rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/secureboot/swupdate.handler.efibootguard.ini (100%)
 rename recipes-core/{swupdate => swupdate-handler-roundrobin}/files/swupdate.handler.efibootguard.ini (100%)
 create mode 100644 recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index e4879c7..1d57ce1 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -17,14 +17,6 @@ BUILD_DEB_DEPENDS = " \
     zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
     python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev, pkg-config"
 
-SRC_URI += " ${@ 'git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1' \
-    if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
-    }"
-SRCREV_swupdate-handler-roundrobin ?= "6f561f136fdbe51d2e9066b934dfcb06b94c6624"
-
-SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
-SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
-
 KFEATURE_lua = ""
 KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
 KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index bd0f6e4..974eacb 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -17,6 +17,7 @@ header:
 local_conf_header:
   swupdate: |
     IMAGE_INSTALL_append = " swupdate"
+    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
   wic-swu: |
     IMAGE_TYPE = "wic-swu-img"
diff --git a/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
similarity index 100%
rename from recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
rename to recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
diff --git a/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
similarity index 100%
rename from recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
rename to recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
new file mode 100644
index 0000000..b9ccec2
--- /dev/null
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -0,0 +1,32 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+PROVIDES = "swupdate-handlers"
+
+SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
+SRCREV_swupdate-handler-roundrobin ?= "ba4c5ae8e664a9624335753cb152e6e264b3f518"
+
+SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
+
+SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
+SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
+
+do_install[cleandirs] = "${D}/etc \
+                         ${D}/usr/share/lua/5.3"
+do_install() {
+    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
+    fi
+    if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
+       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
+    fi
+}
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 8bef9ab..a29a797 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -29,8 +29,6 @@ DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
 inherit dpkg
 inherit swupdate-config
 
-SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
-SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
 KFEATURES += "luahandler"
 
 S = "${WORKDIR}/git"
@@ -47,15 +45,4 @@ do_prepare_build() {
     if ! grep -q "configs/${DEFCONFIG}" ${S}/.gitignore; then
         echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
     fi
-    # luahandler
-    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
-        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}/swupdate_handlers.lua
-    fi
-    if [ -e ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ]; then
-       install -m 0644 ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ${S}/swupdate.handler.ini
-       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
-    elif [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
-       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${S}/swupdate.handler.ini
-       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
-    fi
 }
-- 
2.30.2


--ydi4CdhsCRGGDuxQgBMH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6813): https://lists.cip-project.org/g/cip-dev/message/=
6813
Mute This Topic: https://lists.cip-project.org/mt/86287949/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ydi4CdhsCRGGDuxQgBMH--
