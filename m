Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D17C25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 09:51:25 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web08.8858.1660297875951284536
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 02:51:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=ihIVwyx8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-20220812095113731cb0b9d4d1b892c8-cqjtjv@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220812095113731cb0b9d4d1b892c8
        for <cip-dev@lists.cip-project.org>;
        Fri, 12 Aug 2022 11:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mtATVuEETdt3mYL5WI6GNRdW13LiUd0Y4Fh/3LKqffo=;
 b=ihIVwyx8H+5LMAs5MF7H8edH1OPT2eAZaylspGKkKyqM7mFtknOnBY485DFQBhKUjkA2hz
 LQA/cD7CrXdXg4KTppfGZCLG0DYIgzlZhHExGtvF79MfU0mjOCFtpjLa77AwYcXOLieG/Okb
 IVW43MinsZoH6md3Ur37u10KXq8i0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 2/3] kas/opt/swupdate: Move the
 package installation to swupdate.inc
Date: Fri, 12 Aug 2022 11:51:11 +0200
Message-Id: <20220812095112.632930-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
References: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 09:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9169

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml | 4 ----
 kas/opt/swupdate.yml                 | 4 ----
 recipes-core/images/swupdate.inc     | 3 +++
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 2822cef..3202076 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -18,10 +18,6 @@ local_conf_header:
   image-options-swupdate: |
     CIP_IMAGE_OPTIONS_append = " swupdate.inc"
 
-  swupdate: |
-    IMAGE_INSTALL_append = " swupdate"
-    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
-
   secure-boot-image: |
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index c2bd15c..8ba03c9 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -15,10 +15,6 @@ header:
   version: 10
 
 local_conf_header:
-  swupdate: |
-    IMAGE_INSTALL_append = " swupdate"
-    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
-
   image-option-swupdate: |
     CIP_IMAGE_OPTIONS_append = " swupdate.inc"
 
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index e0252df..edc41a0 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,9 @@
 inherit swupdate
 inherit read-only-rootfs
 
+IMAGE_INSTALL += " swupdate"
+IMAGE_INSTALL += " swupdate-handler-roundrobin"
+
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
 
 FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
-- 
2.35.1


