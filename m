Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7593C47085
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.3506.1649834201191474110
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=fY7N5pPc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-20220413071638943d4bbb37a5647276-a_ygdq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220413071638943d4bbb37a5647276
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vGYvJ2H6eZXyBZZdiBVU0oj4Cwjy4ICTxVgcRenErBI=;
 b=fY7N5pPcUqrc94mI1S73bvSYK9XjLU2yHdCJSNeZjifoDiH8fRJVDQROXwLyOqO3JrYxUg
 w0s3BhFw1rXoL1N23V54i/wOZx+zLR0kHwiL4k695r+07bltbc5XjbhOaIjiox3FN0R2TWYB
 Rbg83GeStmtjEGR4ZONvJ80AB6a24=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 04/19] swupdate: Rename secure-swupdate-img
 class
Date: Wed, 13 Apr 2022 09:16:21 +0200
Message-Id: 
 <97436664b76f3439a4f05e34cae2a9f399f44e63.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8056

From: Jan Kiszka <jan.kiszka@siemens.com>

Align the name to the non-secure counter part wic-swu-img.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{secure-swupdate-img.bbclass => secure-wic-swu-img.bbclass} | 0
 kas/opt/ebg-secure-boot-snakeoil.yml                           | 3 +--
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename classes/{secure-swupdate-img.bbclass => secure-wic-swu-img.bbclass} (100%)

diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-wic-swu-img.bbclass
similarity index 100%
rename from classes/secure-swupdate-img.bbclass
rename to classes/secure-wic-swu-img.bbclass
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index a7d644b..10414fb 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -14,7 +14,6 @@ header:
   includes:
    - kas/opt/ebg-secure-boot-base.yml
 
-
 local_conf_header:
   image-options: |
     CIP_IMAGE_OPTIONS_append = " read-only.inc"
@@ -24,7 +23,7 @@ local_conf_header:
 
   verity-img: |
     SECURE_IMAGE_FSTYPE = "squashfs"
-    IMAGE_FSTYPES = "secure-swupdate-img"
+    IMAGE_FSTYPES = "secure-wic-swu-img"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
 
   secure-boot: |
-- 
2.34.1


