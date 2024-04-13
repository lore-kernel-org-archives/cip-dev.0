Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BBC04FF8
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 10:02:07 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.7909.1713002523706311014
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Apr 2024 03:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm1 header.b=mhHNGgzi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1212295-20240413100201a585c18a062989d228-8iqkmo@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240413100201a585c18a062989d228
        for <cip-dev@lists.cip-project.org>;
        Sat, 13 Apr 2024 12:02:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=A8UCSmgL7ubFYud9nv63tf4xwLgOStPVA/8BrzVQoo0=;
 b=mhHNGgziHQYGW6XB0SnD6AWzuivRs/sKskRIsZoVSTcJm1mP2uQlX/zNNEFxVFYG6QSMeH
 diNSk5+O3dVgxHzpGVZLtNGiNkv4Fk/sAoNEva5HSiOUZRx+imHrHLX3eB90hsNASGJERKq8
 OBw6CA4Om1rzioYRZG2iDIWtGpgzY=;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [PATCH v2 1/1] recipes-devtools: use DPKG_ARCH=all for arch-independent packages
Date: Sat, 13 Apr 2024 12:01:40 +0200
Message-Id: <20240413100140.2432650-2-cedric.hombourger@siemens.com>
In-Reply-To: <20240413100140.2432650-1-cedric.hombourger@siemens.com>
References: <17C5CC2DB0C515DA.10043@lists.cip-project.org>
 <20240413100140.2432650-1-cedric.hombourger@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Apr 2024 10:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15554

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
 ...tes-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} | 0
 recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 +
 ...swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} | 0
 10 files changed, 4 insertions(+)
 rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} (96%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb} (100%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key-snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} (100%)
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
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.2.bb
similarity index 100%
rename from recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
rename to recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.2.bb
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


