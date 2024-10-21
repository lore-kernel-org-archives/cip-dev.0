Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C3D17127
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 18:55:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.401.1729536905054448218
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 11:55:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=dHqS/nXV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1326448-202410211855038f0e05e999b46451bc-yprz76@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202410211855038f0e05e999b46451bc
        for <cip-dev@lists.cip-project.org>;
        Mon, 21 Oct 2024 20:55:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oESPdi1Tu4E53ZXMAFiESw+AkjbKAkCjn+DLU46lwpw=;
 b=dHqS/nXVSnIlzJHfyWnhl7mZkJbhcDhWI/j8cLEaON4LFExSDV+i1H2o+GG9+EUXENbtZH
 d7jX6ddDlU8L1hnRDpSmPyOhValdjNr/7sXVwo8yT7srYy+ilr0xvQnuya0HwV/sl55+i/EJ
 EHjvR7p3VC+ye5Q1VRybcHdHX8F90W2oQ6g78RWeJuBJ1MKpCcxmbcSwO3FBeJSBElQIUyS9
 /P5G3gmw2hWXYUrt+kxRFHfhPhOOznUY561eaPrK/WF/9OcEEZSosni1KhUehA0oyRdx3nJ0
 fJU4pZrzSIyB5lYCB0alIe0CN9jl4z91qoWrf2QzzgUqVeGcqV+C6BYg==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/2] Reuse var ADDITIONAL_DISK_ENCRYPTION_PACKAGES in package initramfs-crypt-hook.
Date: Mon, 21 Oct 2024 20:53:59 +0200
Message-ID: <20241021185359.927395-3-alexander.heinisch@siemens.com>
In-Reply-To: <20241021185359.927395-1-alexander.heinisch@siemens.com>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 18:55:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17061

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../initramfs-crypt-hook_0.2.bb                    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 72de5b6..3a8dc21 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -9,10 +9,16 @@
 # SPDX-License-Identifier: MIT
 
 inherit dpkg-raw
-DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
-    awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
-    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
-    e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
+DEBIAN_DEPENDS = "\
+    initramfs-tools, \
+    ${ADDITIONAL_DISK_ENCRYPTION_PACKAGES}, \
+    awk, \
+    openssl, \
+    e2fsprogs, \
+    tpm2-tools, \
+    coreutils, \
+    uuid-runtime \
+    "
 
 CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
-- 
2.43.0


