Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D74C54E58
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 13:01:02 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.43631.1710939659931182885
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 06:01:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=CNZ2v0QO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240320130056411ef90a050e2d855c-gp2cmj@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240320130056411ef90a050e2d855c
        for <cip-dev@lists.cip-project.org>;
        Wed, 20 Mar 2024 14:00:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+hcuvub8UFRrF5CT40XqvRmYn1VhSwudI+6JzN9p1Es=;
 b=CNZ2v0QOcyzvQN2c5kYMnsERnElM92/DEYA6JWP/OFcQVsJGVCwKXHRfgXL/XYML6baNsA
 z4S0gXTd3D2jyNfRh7Fj/jHIgrdH67RnjDygeaBmzA+qLVCtzuIbyOKHLFrvAaK8g+rgGpql
 PSGAQv8g7lxsYqv+NwRLx5UL5Rj9I=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Adithya.Balakumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate-handler-roundrobin: Add link for handler search path
Date: Wed, 20 Mar 2024 13:59:48 +0100
Message-ID: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 13:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15388

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The lua version which is used to search for additional handler is
hard coded in SWUpdate and debian salsa[1].

To support multiple distribution with different lua versions add
the variables SWUPDATE_LUA_VERSION and SWUPDATE_ADDITIONAL_LUA_VERSIONS.

SWUPDATE_LUA_VERSION defines the main version and for all space
seperated entries in SWUPDATE_ADDITIONAL_LUA_VERSIONS a symbolic link
is generated.

[1]: https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13

This fixes issue #102 SWUpdate failed to install update on bookworm
amd64 image.

Reported-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb           | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index b39278e..95ceedd 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -20,12 +20,22 @@ SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
 SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
 
-# lua version 5.2 is currently hard coded in swupdate @ debian salsa
+# The lua version used by swupdate to search for additional handler is hard coded in debian/rules
+# see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
+SWUPDATE_LUA_VERSION ??= "5.4"
+SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
+
+do_prepare_build:append() {
+    for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIONS}; do
+        echo "usr/share/lua/${SWUPDATE_LUA_VERSION} usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.links
+    done
+}
+
 do_install[cleandirs] = "${D}/etc \
-                         ${D}/usr/share/lua/5.3"
+                         ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
 do_install() {
     if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
-        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
     fi
     if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
        install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
-- 
2.43.0


