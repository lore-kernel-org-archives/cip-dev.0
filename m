Return-Path: <SRS0=TYKz=OZ=lists.cip-project.org=bounce+64572+6788+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D5C4167B
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 14:13:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D4E611F2
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96D4E611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NLEYYY4521723xDPLz7tLA11; Tue, 05 Oct 2021 07:13:50 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.985.1633443229738818309
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 07:13:50 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 195EDlVE031990
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 5 Oct 2021 16:13:47 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.1.239])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 195EDkBq022271;
	Tue, 5 Oct 2021 16:13:47 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/4] swupdate-handler: Use same lua version as swupdate-debian-gbp
Date: Tue,  5 Oct 2021 16:13:45 +0200
Message-ID: <20211005141346.2682677-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
References: <20211005141346.2682677-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NgmQvoONCJsPBXkhltp5SyuLx4520388AA=
Content-Type: multipart/mixed; boundary="BPz8m5zKvRxV2GHddtLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633443230;
 bh=w+ZY01L5w9OsAPIxtj1XmK5EroA9YfBtYjbLThzxzVM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qngWQFeEcjBF/fxeiAlL6NLth7igJop4W8ZRa3J8t+3oNwMJF4YrwZkDjqkwyHWGdxL
 LV+7RlmofVcijLY0QNTZwjcvZ16YDlA+9NPyXrYe25AxCv7GWLupLwkUUZFJ1p8j8E+fG
 NnpyPuL2Pyb7zSd44PsX8hTsxxVHYQOK4/c=
Message-ID: <20211005141345.CWj8R_26ESFMlPFan-3RIgNbDph-xpKIWaGUhIuUltA@z>

--BPz8m5zKvRxV2GHddtLS
Content-Transfer-Encoding: 8bit

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


--BPz8m5zKvRxV2GHddtLS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6788): https://lists.cip-project.org/g/cip-dev/message/=
6788
Mute This Topic: https://lists.cip-project.org/mt/86094387/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BPz8m5zKvRxV2GHddtLS--
