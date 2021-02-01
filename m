Return-Path: <SRS0=obG1=HD=lists.cip-project.org=bounce+64572+6154+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6752C433E6
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 12:33:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D821E64E9E
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 12:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D821E64E9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6154+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UKgFYY4521723xE8JjwyB056; Mon, 01 Feb 2021 04:33:35 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.33160.1612182814204145217
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Feb 2021 04:33:34 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 111CXVJs003880
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 1 Feb 2021 13:33:31 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.15.10])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 111CXUDb032379;
	Mon, 1 Feb 2021 13:33:31 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com,
        florian.bezdeka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] Use u-boot-config instead of tools
Date: Mon,  1 Feb 2021 13:33:30 +0100
Message-Id: <20210201123330.20610-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uK77TU3Z97suaPjOhhs8SiHVx4520388AA=
Content-Type: multipart/mixed; boundary="BJff94G4DJnVbXnegEDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612182815;
 bh=zI6BkQSK55iQrNCS0xzRFUftg/amUwRcXesnzbVsbng=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BxP91cUSNdB6r07Fn6JRM0ADS0Wp3QGMcoT0MftMM6OAeifwqT6cwAR/TGWx6150m8j
 ermGVY6eVvpi3+sKCOygZQdpoIK2hNVl+4XDrrMWakTfKG4ISWi4cUPg00BHXDCG3UbHk
 /X8vRYt4Op9JIvtfzAcDcPIcF+Hk1aFhilE=

--BJff94G4DJnVbXnegEDH
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Swupdate requires libubootenv0.1 and u-boot-config to access the u-boot
environment. u-boot-config adds the configuration files.

Add the flag `USE_U_BOOT_CONFIG` to deactivate the addition of
'u-boot-${MACHINE}-config.' If the image uses an upstream u-boot binary
(e.g. [1]) remove the package by setting `USE_U_BOOT_CONFIG` to `false`.

[1]: https://packages.debian.org/buster/u-boot-omap

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass   | 8 +++++---
 recipes-core/swupdate/swupdate.bb | 2 --
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index dd0317f..9909113 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -45,10 +45,13 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
 
 KFEATURE_DEPS[ubi] = "mtd"
 
+USE_U_BOOT_CONFIG ?= "true"
 KFEATURE_u-boot = ""
 KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
-KFEATURE_u-boot[DEBIAN_DEPENDS] = "libubootenv-tool, u-boot-tools"
-KFEATURE_u-boot[DEPENDS] = "${U_BOOT}"
+KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
+                                          if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
+                                          else 'libubootenv0.1'}"
+KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
 SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
@@ -73,4 +76,3 @@ python do_check_bootloader () {
         bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
 }
 addtask check_bootloader before do_fetch
-
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index b4d64fe..526c72f 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -24,8 +24,6 @@ SRC_URI += "file://debian \
             file://${DEFCONFIG} \
             file://${PN}.cfg"
 
-DEPENDS += "libubootenv"
-
 DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
 
 inherit dpkg
-- 
2.20.1


--BJff94G4DJnVbXnegEDH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6154): https://lists.cip-project.org/g/cip-dev/message=
/6154
Mute This Topic: https://lists.cip-project.org/mt/80283340/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BJff94G4DJnVbXnegEDH--
