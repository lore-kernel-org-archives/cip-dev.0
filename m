Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360E2C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 16:39:13 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.17298.1699979951661126134
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Nov 2023 08:39:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=pyNo8nrj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20231114163909803580f8d818ef68f4-wqhxqc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231114163909803580f8d818ef68f4
        for <cip-dev@lists.cip-project.org>;
        Tue, 14 Nov 2023 17:39:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=5fUcd5Cf+mSz7iMp2Mt31Ny+9VXavsfpqXxBs+bwHAw=;
 b=pyNo8nrjxtgmPdVsOFUudIA4XT/hU6WJ6y0ky7gscqDDDFCZppPkgv7AIItCL7fCjYAqWg
 JFWhUTFebAEc4Xlr3DOw/qvCJpoKeY2rxxaXntH6M3aP0ybvQFy6AAGznlodXh7mqpIHSc7E
 SRJVSXHwP8uNlbEkTVk2kYVrDSuBo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][Patch v2] efibootguard: Update to efibootguard 0.16
Date: Tue, 14 Nov 2023 17:38:51 +0100
Message-ID: <20231114163908.1199673-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Nov 2023 16:39:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13580

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...bootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} (75%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
similarity index 75%
rename from recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
index 0cfb6da..a7ffb00 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
@@ -16,13 +16,15 @@ LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
+EBG_VERSION = "${@d.getVar('PV').split('-')[0]}"
+
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v0.15.tar.gz;downloadfilename=efibootguard_0.15.orig.tar.gz;unpack=0;name=tarball \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v${EBG_VERSION}.tar.gz;downloadfilename=efibootguard_${EBG_VERSION}.orig.tar.gz;unpack=0;name=tarball \
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


