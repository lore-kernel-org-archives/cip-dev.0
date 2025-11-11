Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BBCCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 10:12:57 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14165.1762855969975041331
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 02:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm1 header.b=QtlwXeNK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1212295-20251111101240bcf79ec40900020749-t7eq8t@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251111101240bcf79ec40900020749
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Nov 2025 11:12:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=x95KszuOMMicGecCFbC5YXjmYGYZacol9qOlbT8uP0g=;
 b=QtlwXeNKTTm6COfLcXpVoTsa0i5AdgQ1fQzoVCtvmM6FAQOtQMpID8PwCSBCGNd/aqpDCc
 kiO+dViFhXy62iEVDZgGfdiWADmsOmPkTLrzStqB3gAQwZUA+IjA4CdACJBuQxsnm5QktliJ
 t909rQSWUiELiWxlJxLrYjNIJnLRn0V2KSPaPm21QZSlvKZ1FKzmBVuXCsp8o+0GSvAJtTGX
 JYWHEvdZJbvFt1EUAbMl39jG20VvPqxxcj0PRfwIpj0WGaZXNiRMIZgsiln9Gdpz3jysQKcl
 VkuLYSk269m4UCukZGmBjTJ5v1DBUSU4e/MhBklJ8rAHOZa1O3lEa1LA==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate: generate reproducible source tarballs
Date: Tue, 11 Nov 2025 11:12:31 +0100
Message-ID: <20251111101231.143022-1-cedric.hombourger@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 10:12:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20493

Apply additional options to the tar command used to generate
reproducible source tarballs: (1) use numeric and null [GU]IDs,
-clamp-mtime for file modification times to never be later than
SOURCE_DATE_EPOCH (preserving mtimes for files not modified by
the recipe) and --sort=name for consistent ordering within the
archive.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb | 6 +++++-
 recipes-core/swupdate/swupdate_2023.12.bb            | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
index fcccc2c..b5becaa 100644
--- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
+++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
@@ -37,5 +37,9 @@ CHANGELOG_V ?= "${PV}-${SRCREV}"
 do_prepare_build() {
     deb_add_changelog
     cd ${WORKDIR}
-    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
+    tar cJf ${PN}_${PV}.orig.tar.xz \
+        --exclude=.git --exclude=debian ${P}
+        --mtime=@${SOURCE_DATE_EPOCH} --clamp-mtime \
+        --owner=0 --group=0 --numeric-owner \
+        --sort=name ${P}
 }
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index cc01a98..50df215 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -50,5 +50,9 @@ CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
 do_prepare_build() {
     deb_add_changelog
     cd ${WORKDIR}
-    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz \
+        --exclude=.git --exclude=debian \
+        --mtime=@${SOURCE_DATE_EPOCH} --clamp-mtime \
+        --owner=0 --group=0 --numeric-owner \
+        --sort=name ${P}
 }
-- 
2.47.3


