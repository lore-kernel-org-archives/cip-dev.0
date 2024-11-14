Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2418CD65C66
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 09:42:28 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.33475.1731577338845555262
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 01:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=V+c+Uryv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1324425-202411140942150453cad03801a3a148-oisdis@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202411140942150453cad03801a3a148
        for <cip-dev@lists.cip-project.org>;
        Thu, 14 Nov 2024 10:42:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=EdE4zrf/dnf8x8AYkBpaCKrrNJtrz6YNyD/1kq32MvI=;
 b=V+c+UryvnLUtPSAVpMI/2BtBFqipmQPFsK39YEp3ED+kXAazkV6VfDrzILNbdz6zwtPgGI
 4LqXBwxuIckvCXg/O+p+cPjae/32ps2Dl0el7fALJthmvToBy5GOJ0HKmuTc0tHrKhZ59FmS
 IYT4618RV3Ddd+j0bekWHYXH0Pd1IEuLuDc1FJoeirvXX/S/kkLvDOLVdOyugNPZRnx0Lh7m
 yUdUODe3qwdj4+EjwcusRt3NS9sPMt8SWz92Pa9lTrIIGoxGZhko/KMc4B6uaHP+1Sra0XPG
 YLwz8q7mNAnQ85syOiVznUug1nDPl3cZcjMuJeyIOvKILBT26KugIejQ==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-devtools: remove setting of DEBIAN_MULTI_ARCH as foreign for DPKG_ARCH = "all"
Date: Thu, 14 Nov 2024 15:19:56 +0530
Message-Id: <20241114094956.867473-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 09:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17254

From: Srinuvasan A <srinuvasan.a@siemens.com>

If the recipes builds for all architectures, then the default Multi-Arch is
foreign, which is provided by ISAR, hence no need to set it explicitly
in the recipes.

Ref: https://github.com/ilbers/isar/commit/0816ae6e

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb         | 1 -
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 -
 recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 -
 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb      | 1 -
 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb        | 1 -
 5 files changed, 5 deletions(-)

diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
index 88512f6..83289d4 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -17,7 +17,6 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
 DEPENDS = "secure-boot-secrets"
 DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
 DPKG_ARCH = "all"
-DEBIAN_MULTI_ARCH = "foreign"
 
 SRC_URI = "file://sign_secure_image.sh"
 
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index f11e93d..c1fc12f 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -12,7 +12,6 @@
 inherit dpkg-raw
 
 DPKG_ARCH = "all"
-DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "secure-boot-secrets"
 DEBIAN_PROVIDES = "secure-boot-secrets"
 
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 2532de6..43668db 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -14,7 +14,6 @@ inherit dpkg-raw
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 DPKG_ARCH = "all"
-DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "swupdate-certificates"
 DEBIAN_PROVIDES = "swupdate-certificates"
 
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
index 3600c3d..17e64ad 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
@@ -10,7 +10,6 @@
 
 inherit dpkg-raw
 DPKG_ARCH = "all"
-DEBIAN_MULTI_ARCH = "foreign"
 
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
index 8522e5e..a999182 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
@@ -10,7 +10,6 @@
 
 inherit dpkg-raw
 DPKG_ARCH = "all"
-DEBIAN_MULTI_ARCH = "foreign"
 
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
-- 
2.34.1


