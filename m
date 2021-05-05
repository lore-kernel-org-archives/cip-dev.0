Return-Path: <SRS0=4OOP=KA=lists.cip-project.org=bounce+64572+6424+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B8C43460
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:25:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BCB61154
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BCB61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6424+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id E0HnYY4521723xZCiVOkSyvO; Wed, 05 May 2021 01:25:44 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.4948.1620203142840885319
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 01:25:43 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1458PfXo016476
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 5 May 2021 10:25:41 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.16.18])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1458LwLt016955;
	Wed, 5 May 2021 10:21:59 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 1/2] swupdate-config: remove variable U_BOOT
Date: Wed,  5 May 2021 10:21:57 +0200
Message-Id: <20210505082158.18899-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210505082158.18899-1-Quirin.Gylstorff@siemens.com>
References: <20210505082158.18899-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iwLljUhSpL1fobttfVCznE2Qx4520388AA=
Content-Type: multipart/mixed; boundary="9wKDSL5PIWXJ6aJYlfqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620203144;
 bh=BbNKgAaIz2mox6+on68m3Tg6Uo/pa4ZWx/q/4vAmh5g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HKeVPjWADPyK5IA6v9u7UAn2k/iUcXJSfl/s+oatzxKM0Tl8mF36ZLUmdkT3vmIqo29
 DksYUN1WBykpNF26Ufwedx6v7rz3IlmtywyML8QRQ9IGBcPbzJEEBdFIX1MTPrDFrpxKe
 iN+Uj+i9ObOWomkWXxKFX5iu1aViKeXrwY4=

--9wKDSL5PIWXJ6aJYlfqY
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The dependency to ${U_BOOT} is unnecessary for the
SWUPDATE build and the package deployment. The package
`u-boot-${MACHINE}-config` is requested for fw_env.config
from a custom u-boot build. SWUpdate uses fw_env.config
to read/write the u-boot environment.

If the Package `u-boot-${MACHINE}-config` is not activated during
the build, by setting `U_BOOT_CONFIG_PACKAGE` to '1',
then do not add `u-boot-${MACHINE}-config` to the
swupdate dependencies.

U-Boot build by Debian provides example configurations
for different boards with the package u-boot-tools.

If u-boot-tools are installed these examples can be found
at config /usr/share/doc/u-boot-tools/examples/.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 9909113..5af4eba 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -45,13 +45,16 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
 
 KFEATURE_DEPS[ubi] = "mtd"
 
-USE_U_BOOT_CONFIG ?= "true"
 KFEATURE_u-boot = ""
 KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
+# we need u-boot-${MACHINE}-config for fw_env.config
+# only custom build u-boot provides this package
+# for u-boot provided by debian u-boot-tools provides
+# example configurations at /usr/share/doc/u-boot-tools/examples
 KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
-                                          if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
+                                          if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1" \
                                           else 'libubootenv0.1'}"
-KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
+KFEATURE_u-boot[DEPENDS] = "libubootenv"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
 SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
-- 
2.20.1


--9wKDSL5PIWXJ6aJYlfqY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6424): https://lists.cip-project.org/g/cip-dev/message=
/6424
Mute This Topic: https://lists.cip-project.org/mt/82599602/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9wKDSL5PIWXJ6aJYlfqY--
