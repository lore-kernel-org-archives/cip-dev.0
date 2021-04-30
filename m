Return-Path: <SRS0=df3B=J3=lists.cip-project.org=bounce+64572+6402+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DFC43460
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:20:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B095561477
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B095561477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6402+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n2hWYY4521723xsE0nRMkw3c; Fri, 30 Apr 2021 05:20:25 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.10667.1619785223925546044
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Apr 2021 05:20:24 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13UCKLLU030187
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 30 Apr 2021 14:20:21 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.11.215])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13UCKKwW012691;
	Fri, 30 Apr 2021 14:20:20 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] swupdate-config: add prefix to variables
Date: Fri, 30 Apr 2021 14:20:20 +0200
Message-Id: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C5QPUEiJkCKinazyyBpL83uKx4520388AA=
Content-Type: multipart/mixed; boundary="IIINoqTyUJZD9Sv7iMJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619785225;
 bh=ZXqfVFj0SA++Wlg3rNDEAs/rNSOJtcEBwdcE8aGc0lQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Zsit0Uz8D2o+LVxFdrMloTmpyF6Pdomh67b53P7t8aGnYFyGpAgCzKb5jn+ubdvKk54
 /7F7wM9ECBVcaRsmdFqdi/utdmRcUnPdVqDZ2hypxZwD8IxU3Y6MSZRtgnMB72NV7LtFp
 L/P7efhzFVFvcdSvDWlejLe/zTuJyBd3BVY=

--IIINoqTyUJZD9Sv7iMJy
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The variables U_BOOT and BOOTLOADER are only used for swupdate
mark add the prefix SWUPDATE to indicate the intended usage.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 9909113..8ec1104 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -45,19 +45,23 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
 
 KFEATURE_DEPS[ubi] = "mtd"
 
+
+SWUPDATE_BOOTLOADER ?= "${BOOTLOADER}"
+SWUPDATE_U_BOOT ?= "${U_BOOT}"
 USE_U_BOOT_CONFIG ?= "true"
+
 KFEATURE_u-boot = ""
 KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
 KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
                                           if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
                                           else 'libubootenv0.1'}"
-KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
+KFEATURE_u-boot[DEPENDS] = "${SWUPDATE_U_BOOT} libubootenv"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
 SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
 
 def get_bootloader_featureset(d):
-    bootloader = d.getVar("BOOTLOADER", True) or ""
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
     if bootloader == "efibootguard":
         return "efibootguard"
     if bootloader == "u-boot":
@@ -68,11 +72,11 @@ SWUPDATE_KFEATURES ??= ""
 KFEATURES = "${SWUPDATE_KFEATURES}"
 KFEATURES += "${@get_bootloader_featureset(d)}"
 
-# Astonishingly, as an anonymous python function, BOOTLOADER is always None
+# Astonishingly, as an anonymous python function, SWUPDATE_BOOTLOADER is always None
 # one time before it gets set. So the following must be a task.
 python do_check_bootloader () {
-    bootloader = d.getVar("BOOTLOADER", True) or "None"
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
     if not bootloader in ["efibootguard", "u-boot"]:
-        bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
+        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
 }
 addtask check_bootloader before do_fetch
-- 
2.20.1


--IIINoqTyUJZD9Sv7iMJy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6402): https://lists.cip-project.org/g/cip-dev/message=
/6402
Mute This Topic: https://lists.cip-project.org/mt/82479643/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IIINoqTyUJZD9Sv7iMJy--
