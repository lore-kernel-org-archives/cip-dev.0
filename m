Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270ECD1283
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.9305.1711101968829621960
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=j2P7NzoP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240322100606bf5487ee1ee26ff562-pwsqgp@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240322100606bf5487ee1ee26ff562
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SihjlxuH8eCo+mput6tIaKyWQBDGiv1ic/gp94GvunU=;
 b=j2P7NzoPkOGp2QORV2onQHV59Oq6ASihu0T8CfyYm3SyoihXTnhNypQTBwDdYDpfZgYASm
 tBllvYH7xbyuycCpNPDY9tEFP3ONjgXGFmtQVmje5FnXeU+bS54t4bCXgO7gkEHYmvjOFEmd
 WXfD4hrjazAdZ8S8S7dDH2dTyknRU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 01/13] initramfs-crypt-hook: Allow switching between clevis and systemd
Date: Fri, 22 Mar 2024 11:05:11 +0100
Message-ID: <20240322100605.4129226-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15397

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows device which started on Debian 11 to continue using
clevis for encryption and decryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook_0.1.bb                    | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index b275c0f..317ea12 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -17,7 +17,17 @@ CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
 DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
 DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
-DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
+DEBIAN_DEPENDS:append = "${@encryption_dependency(d)}"
+
+def encryption_dependency(d):
+    crypt_backend = d.getVar('CRYPT_BACKEND')
+    if crypt_backend == 'clevis':
+        clevis_depends= d.getVar('CLEVIS_DEPEND')
+        return f"{clevis_depends}, clevis-tpm2"
+    elif crypt_backend == 'systemd':
+        return ", systemd (>= 251)"
+    else:
+        bb.error("unkown cryptbackend defined")
 
 CRYPT_BACKEND:buster = "clevis"
 CRYPT_BACKEND:bullseye = "clevis"
-- 
2.43.0


