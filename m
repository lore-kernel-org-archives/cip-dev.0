Return-Path: <SRS0=R0Qe=KW=lists.cip-project.org=bounce+64572+6478+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6DC47089
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:28:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F244E61059
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F244E61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6478+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rqxPYY4521723xhaSGgWzsUZ; Thu, 27 May 2021 06:28:46 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.6961.1622122125676653093
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 May 2021 06:28:46 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 14RDSiQF031222
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 27 May 2021 15:28:44 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.10.167])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 14RDHgaw007209;
	Thu, 27 May 2021 15:17:42 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/5] swupdate-config: add dependency to u-boot-${MACHINE}-config
Date: Thu, 27 May 2021 15:17:37 +0200
Message-Id: <20210527131741.8828-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
References: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Opxfk98EBa9sGtAJH8GhdW1Kx4520388AA=
Content-Type: multipart/mixed; boundary="K1ImvQsDnIukz3pr4Pgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622122126;
 bh=0vp2Kgsd08sppynekvZJXlFrjTXhYSsLNk1cVzlxn20=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XdwonYucXty/JwvY6lyi5JThc9+xp/SAgz7FVytlslPimRENWjMfShcSt7I0OBLJbjB
 HQNWsExNljXqeM7Id2RqLxGsTTw/gUAeXX9t2hNMTByQ06+xdZ3zleHlHTusk3izq/5vJ
 1id1DYBGK5xC3Xo2QpzHLiERwck82PPYpEI=

--K1ImvQsDnIukz3pr4Pgy
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If U_BOOT_CONFIG_PACKAGE is set,  swupdate should depend on
the u-boot-${MACHINE}-config.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 4e46b37..f67ca4f 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -54,7 +54,9 @@ KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
 KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
                                           if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1" \
                                           else 'libubootenv0.1'}"
-KFEATURE_u-boot[DEPENDS] = "libubootenv"
+KFEATURE_u-boot[DEPENDS] = "${@ 'libubootenv u-boot-${MACHINE}-config' \
+                                          if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1" \
+                                          else 'libubootenv'}"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
 SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
-- 
2.20.1


--K1ImvQsDnIukz3pr4Pgy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6478): https://lists.cip-project.org/g/cip-dev/message=
/6478
Mute This Topic: https://lists.cip-project.org/mt/83124076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--K1ImvQsDnIukz3pr4Pgy--
