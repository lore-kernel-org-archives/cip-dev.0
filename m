Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7120C4345F
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 14:07:08 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.6205.1712991591851485997
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Apr 2024 23:59:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm1 header.b=LO6teOM4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1212295-2024041306594891102511c04e3f6709-noh_h7@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024041306594891102511c04e3f6709
        for <cip-dev@lists.cip-project.org>;
        Sat, 13 Apr 2024 08:59:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9B0SEdjWzvMNStDM8sDM/ej4+8tVksdytryZrve7bsw=;
 b=LO6teOM4c20b3FFP1pCX3/1gERmV+b7KYmE1Nog91k4F7lqta5/pOTiSWJNRfRTd/cAmQR
 pUPhTyPC/lM5Dtt3Qxx911LTh/gkVD33sBKq4OZ2MQts8n88MZNskM2LnWh8X8by1ziglzxX
 MkBI4KnLo2I7xxtkFoUUOzWvQg8fY=;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [PATCH] recipes-devtools: use DPKG_ARCH=all for arch-independent packages
Date: Sat, 13 Apr 2024 08:59:29 +0200
Message-Id: <20240413065929.2289085-1-cedric.hombourger@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Apr 2024 14:07:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15555

Most devtools packages are architecture-independent and should really
be built with "Package: all" instead of "Package: any". Bump PV for
all affected packages (to be "apt full-upgrade" friendly).

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 ...g-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} | 1 +
 .../{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb}           | 0
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 +
 .../{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} | 0
 ...snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} | 0
 .../swupdate-certificates/swupdate-certificates-key.inc          | 1 +
 ...-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} | 0
 recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 +
 ...swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} | 0
 9 files changed, 4 insertions(+)
 rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} (96%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb} (100%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key-snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} (100%)

diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
similarity index 96%
rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
index 57ad1be..83289d4 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -16,6 +16,7 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
 
 DEPENDS = "secure-boot-secrets"
 DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
+DPKG_ARCH = "all"
 
 SRC_URI = "file://sign_secure_image.sh"
 
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
rename to recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 76233b3..859637f 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -11,6 +11,7 @@
 
 inherit dpkg-raw
 
+DPKG_ARCH = "all"
 PROVIDES += "secure-boot-secrets"
 
 SB_KEY ??= ""
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
rename to recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
similarity index 100%
rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 2c67e89..944c2dc 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -13,6 +13,7 @@ inherit dpkg-raw
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
+DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
similarity index 100%
rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 564dda4..d319d8e 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -13,6 +13,7 @@ inherit dpkg-raw
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
+DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates"
 
 SWU_SIGN_CERT ??= ""
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb
similarity index 100%
rename from recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
rename to recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb
-- 
2.34.1


