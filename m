Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E06C4332F
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 10:05:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.33837.1699869933437850615
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 02:05:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=eE3Sdklg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2023111310052976bd2382759f26f2aa-3ymblb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023111310052976bd2382759f26f2aa
        for <cip-dev@lists.cip-project.org>;
        Mon, 13 Nov 2023 11:05:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=tPHBGlBK/CnowvcgZ5pvjwYqKrJ6xZENYopzhLAtgrs=;
 b=eE3SdklgPwu5mqaA5lFoWGa9ZUD6rGccJEbP1WZ/CrhP+qWNqkfrRDpFJhuzTZzeLCd8A8
 Nm+RXHxScyPsS8uhFeFVdovbhoIgZL76AiRId+NFhlyZamPbPzvD0XJITrujqI/+8MY2ZW0z
 oy1YP2Kstj7vICdBEo+2u5w5F9dys=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to efibootguard 0.16
Date: Mon, 13 Nov 2023 11:04:27 +0100
Message-ID: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Nov 2023 10:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13572

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...fibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} (84%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
similarity index 84%
rename from recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
index 0cfb6da..ada0592 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
@@ -17,12 +17,12 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v0.15.tar.gz;downloadfilename=efibootguard_0.15.orig.tar.gz;unpack=0;name=tarball \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v0.16.tar.gz;downloadfilename=efibootguard_0.16.orig.tar.gz;unpack=0;name=tarball \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[tarball.sha256sum] = "9d2d46913ed8013056a3c2b080a997e68d78d92a1051ced06fbfefa93353bb7f"
-SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
+SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
+SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.42.0


