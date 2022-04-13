Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E0C47082
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.3487.1649834202065311179
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=H3reN+Ic;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-202204130716392135cf3ce2e54743e2-dysyq0@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202204130716392135cf3ce2e54743e2
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/thx0OZbrN9UnHtNyRkJJpxE3uHGG8uq7rfZy4jYdKk=;
 b=H3reN+Ic8ck67ns51DhoHbOzb96a9IT/RIXXZa9yJ00U4Wokqt3OxrWLlTlx/Z+ti+mx31
 s3ZlftATPOlA4bgs2A6p2DHyi6Hgt4sw7jPQuJBIuxRePR6lvrp+1infN9U/y9SmEU3OBslK
 7zp9RCxzZYZGCZXihtdM89G1MFMDg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 08/19] swupdate: Drop PN from TEMPLATE_VARS
Date: Wed, 13 Apr 2022 09:16:25 +0200
Message-Id: 
 <35bdc4f05109e40da19644cf312d0f98634dffc9.1649834193.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8054

From: Jan Kiszka <jan.kiszka@siemens.com>

Was never used in any of the template files.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/secureboot.inc | 2 +-
 recipes-core/images/swupdate.inc   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
index 3e6eef8..e01c834 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -16,6 +16,6 @@ ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
 
-TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME"
+TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
 
 SWU_ADDITIONAL_FILES += "linux.signed.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 2c3ad65..64887df 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -16,6 +16,6 @@ ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
 
-TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME"
+TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
 
 SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
-- 
2.34.1


