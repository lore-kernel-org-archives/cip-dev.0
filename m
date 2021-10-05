Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE4C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 14:13:51 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.985.1633443229738818309
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 07:13:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 195EDlVE031990
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 5 Oct 2021 16:13:47 +0200
Received: from md2dvrtc.fritz.box ([167.87.1.239])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 195EDkBq022271;
	Tue, 5 Oct 2021 16:13:47 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/4] swupdate-handler: Use same lua
 version as swupdate-debian-gbp
Date: Tue,  5 Oct 2021 16:13:45 +0200
Message-Id: <20211005141346.2682677-4-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
References: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Oct 2021 14:13:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6788

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handlers/swupdate-handlers_0.1.bb        | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb b/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
index b6cb30d..b96a6af 100644
--- a/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
+++ b/recipes-core/swupdate-handlers/swupdate-handlers_0.1.bb
@@ -10,26 +10,25 @@
 
 inherit dpkg-raw
 
-DEPENDS = "swupdate"
-DEBIAN_DEPENDS = "swupdate"
-
 SRC_URI += " ${@ 'git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1' \
     if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
     }"
 SRCREV_swupdate-handler-roundrobin ?= "6f561f136fdbe51d2e9066b934dfcb06b94c6624"
 
 SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
-SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
+SWUPDATE_LUASCRIPT ?= "${@ 'swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua' \
+                           if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' }"
 
 
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
 SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
 
+# lua version 5.2 is currently hard coded in swupdate @ debian salsa
 do_install[cleandirs] = "${D}/etc \
-                         ${D}/usr/share/lua/5.3"
+                         ${D}/usr/share/lua/5.2"
 do_install() {
     if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
-        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.2/swupdate_handlers.lua
     fi
     if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
        install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
-- 
2.30.2


