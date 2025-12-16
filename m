Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFAD5C0DC
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:26:13 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17470.1765873563272177613
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=QGcwS2NM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251216082600ef0811271f000207c5-dcpjqh@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251216082600ef0811271f000207c5
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Dec 2025 09:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/M39Al12U8rs/bFWH5Sf589PsDdd40F0oOC/h5IlSIQ=;
 b=QGcwS2NMG/IlWAf9Eailk+fjjSbvRH+2F3lyeByb0sw2acyQRPANClIRybPoHjMnSZI1Eh
 u6c2mEYvMNIkldDvWoWIaIHjKCJI2y4M2RO/Qs6QLDZQ+GBS2IHLgmksaxYEmNbTfQL7jFZA
 NB+Er/Kez7eIZa6xBDqBO466Uye/Lx5qb6XTkyUIv1om6WPhNAYNP1DmYv94/ha70TH2kf1y
 HMGU3by40ZnETK1S5+ySMlvHjM22DY2T+ZdB1LYHN7H4IPvlH+dBcCy2cDXe+FvBDHPeXhsx
 6R+6T75uvEur26iIpLhRPOinvMD4z1cJA0abbVDGG1nMkerSkYOQq7Lg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 2/4] fix: initramfs-hook do_prepare_build is executed after do_install
Date: Tue, 16 Dec 2025 09:25:44 +0100
Message-ID: <20251216082559.327416-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21074

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue where the initramfs does not contain the
factory-reset script.

Fixes: 7c89ecb (initramfs-factory-reset: de-duplicate code between local-top and local-bottom)
Fixes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-factory-reset-hook_0.3.bb                   | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
index ed8484d..b689ec1 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
@@ -40,14 +40,10 @@ HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
 
 HOOK_ADD_MODULES = "efivarfs"
 
-# provide the script under the required name
-do_prepare_build:append() {
-    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
-    ln -sf ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}
-}
-
 do_install[cleandirs] += "${D}/usr/share/factory-reset/"
 do_install:prepend() {
+    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
+    ln -sf ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}
     install -m 0755 "${WORKDIR}/reset-env" \
         "${D}/usr/share/factory-reset/reset-env"
 }
-- 
2.51.2


