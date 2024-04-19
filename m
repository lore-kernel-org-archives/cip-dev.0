Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999CC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 12:25:02 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.12313.1713498618198212838
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 20:50:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=ewoY8P7Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1325885-20240419035016636d94f9a388370dac-zp5par@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240419035016636d94f9a388370dac
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 05:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=coPZgFwk45nOgbTQMjW71p2aEOCONkmomh2niZzuKN8=;
 b=ewoY8P7YyCoNCmFtxlWhRMySXglbby0P6n/ynS28O6BVvYXwocW3ghp56E+sElK6zdfcLz
 E9POuv21riuFfwSVhvq3WWPjWocmHC+PRniWVa3uj9glf3lPLhxctmgIGu4BqNZaPHu/GHxv
 fli+d/HdLURZNTNUgU20/j6lFYmH8=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in debian/control
Date: Fri, 19 Apr 2024 09:20:01 +0530
Message-Id: <20240419035001.594631-2-kumar.rakesh@siemens.com>
In-Reply-To: <20240419035001.594631-1-kumar.rakesh@siemens.com>
References: <20240419035001.594631-1-kumar.rakesh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 12:25:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15698

Previously, the debian/control file contained a duplicate Provides line,
    which caused a build failure ad below
    | DEBUG: Executing shell function do_dpkg_source
    | dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/control at line 16:
    | duplicate field Provides found

Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
that the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
-- 
2.39.2


