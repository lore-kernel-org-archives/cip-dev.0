Return-Path: <SRS0=I1Lk=PB=lists.cip-project.org=bounce+64572+6815+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E3C4321E
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8F7610EA
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC8F7610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uZomYY4521723xbcKp5LA871; Wed, 13 Oct 2021 06:40:58 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.8307.1634132456906907225
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 06:40:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DDesFT026258
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 15:40:54 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DDerfL007799;
	Wed, 13 Oct 2021 15:40:54 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] swupdate-handler: Use same lua version as swupdate-debian-gbp
Date: Wed, 13 Oct 2021 15:40:52 +0200
Message-ID: <20211013134053.1400723-4-Quirin.Gylstorff@siemens.com>
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
X-Gm-Message-State: cNyX7VqFKeNhQV04C7xbDHTQx4520388AA=
Content-Type: multipart/mixed; boundary="LkYTwaFHxsq0MYSYKDLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634132458;
 bh=RX1Z2BVKRI0jlYVw52B0oiCmrtyqwwj2KADNjk5ODVo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Tkpjfjb7F2F7kkwcUT+e9tThpHNMLe0rUt9GQxqJPodhS+B1yKMr5cPSIA0MtMBzY4D
 c/kNV8t7DICfsjFqzDsF3hhqJZZ/hgl0xm8uaOBPOzXU9bEjMPBB0i4YVJg60oznr5Y/N
 l3p0pWPFUJtinWya8iLlzVPCjqg19J+rckU=
Message-ID: <20211013134052.Gh1o3XeMfYTvGOJm3cDovXbLuEFo3dpXADxcHxJUc0U@z>

--LkYTwaFHxsq0MYSYKDLF
Content-Transfer-Encoding: 8bit

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


--LkYTwaFHxsq0MYSYKDLF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6815): https://lists.cip-project.org/g/cip-dev/message/=
6815
Mute This Topic: https://lists.cip-project.org/mt/86287951/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LkYTwaFHxsq0MYSYKDLF--
