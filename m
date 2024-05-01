Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0846C4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 12:01:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.10690.1714564823274035016
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 May 2024 05:00:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=XWgKY6Jy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1325885-20240501120020276ce0b6d907240d37-paf8a1@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240501120020276ce0b6d907240d37
        for <cip-dev@lists.cip-project.org>;
        Wed, 01 May 2024 14:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TvZNSw/GDX6tEhX03GaPAkSOUx+J7xlv6+oOe/8QwQo=;
 b=XWgKY6Jykv3d+WkkoIR6mKwIf6HefulZKyM8HIU/RuabdBREnTmBh2qzVt2l2VtUAPiEzg
 8B8XkGFBVrWmI/SasaC7kAGUAXcmS9YYXiBByil4X82ehOLny9sX5scB8hFeblPa+HCPeeBy
 RmLCVnfZz5pDQw7lt1D944pC5ibcE=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [isar-cip-core] [PATCH v3] update ISAR to latest version
Date: Wed,  1 May 2024 17:30:01 +0530
Message-Id: <20240501120001.855311-1-kumar.rakesh@siemens.com>
In-Reply-To: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 May 2024 12:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15788

One of the changes is DEBIAN_PROVIDES, which is required to
resolve the duplicate Provides problem in secure-boot-secrets
to ensure that the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 kas-cip.yml                                                   | 2 +-
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc  | 4 +---
 .../swupdate-certificates/swupdate-certificates-key.inc       | 4 +---
 .../swupdate-certificates/swupdate-certificates.inc           | 4 +---
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0..1b97bd5 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 36c711e4ed6d5ca3c8ab71ffb4a51e78615aa1f0
     layers:
       meta:
 
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 2164b12..00b2a38 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -14,6 +14,7 @@ inherit dpkg-raw
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "secure-boot-secrets"
+DEBIAN_PROVIDES = "${PROVIDES}"
 
 SB_KEY ??= ""
 SB_CERT ??= ""
@@ -31,6 +32,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
 }
 
-do_prepare_build:append() {
-    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 944c2dc..459e288 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates-key"
+DEBIAN_PROVIDES = "${PROVIDES}"
 
 SWU_SIGN_KEY ??= ""
 SWU_SIGN_SCRIPT ??= "sign-swu-cms"
@@ -35,6 +36,3 @@ do_install() {
     install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index dec9a83..02f43e6 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -16,6 +16,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "swupdate-certificates"
+DEBIAN_PROVIDES = "${PROVIDES}"
 
 SWU_SIGN_CERT ??= ""
 
@@ -30,6 +31,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates" >> ${S}/debian/control
-}
-- 
2.39.2


