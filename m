Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1EAC4725D
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 09:52:19 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.69968.1705917134308447484
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 01:52:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PNFqNgLA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202401220952114c0e92102980dedd98-y_wuiv@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202401220952114c0e92102980dedd98
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 10:52:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=E/gUt7chmkVefIxx7EdSdS8tjWgAG1kDgmJwN5+3SPc=;
 b=PNFqNgLAbjXbEprrKabcRgRYNO2SFfXWU+1pcviVSfGXGyGjKxtt4PeiG/pi7GlOAbFr2x
 7df9MHEJWDDONEwLaJwMULnYll31Hk8/PIVxIJ6HFGMOl9Dj6CwS+JOOR3JxNPLUVi7W2pAD
 fg7KZ42fh364jXNSDF52U/+h8EDhM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Fix broken SRCREV to official tag version 0.16-1
Date: Mon, 22 Jan 2024 10:51:29 +0100
Message-ID: <20240122095210.54158-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 09:52:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14432

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is now the tag version of 0.16-1.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
index 93114c3..e9a34d4 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
@@ -22,9 +22,10 @@ SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${EBG_VERSION}.tar.gz;downloadfilename=efibootguard_${EBG_VERSION}.orig.tar.gz;unpack=0;name=tarball \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
+    file://debian-patches/0002-d-control-remove-native-from-python3-shtab.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "eacf94e767136a0257850ea0c888d234cb8cace4"
+SRCREV_debian = "ee551bc5239068ce5ab024089cf20385749ae77e"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.43.0


