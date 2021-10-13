Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31DC43217
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:58 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.8307.1634132456906907225
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DDesFT026258
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:40:54 +0200
Received: from md2dvrtc.ad001.siemens.net ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDerfL007799;
	Wed, 13 Oct 2021 15:40:54 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] swupdate-handler: Use same lua
 version as swupdate-debian-gbp
Date: Wed, 13 Oct 2021 15:40:52 +0200
Message-Id: <20211013134053.1400723-4-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 13:40:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6815

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                       | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index b9ccec2..3a5a51e 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -20,11 +20,12 @@ SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
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


