Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73FC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:44:03 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.8149.1666187035257525612
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:43:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=jvODMd8C;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2022101913435204862eb5331ac70afb-w7jxgh@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022101913435204862eb5331ac70afb
        for <cip-dev@lists.cip-project.org>;
        Wed, 19 Oct 2022 15:43:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=siPMDUil+myVuEUyrzKYvXLoEmU+95ma/IxPdbZRD9A=;
 b=jvODMd8CD7Kyqjfob1WlaRlNDG524KAQCpYY1NU28tpdgwFioRzbSo/GOHoHw1jW6PuODY
 0tB4zn6AnMTx2EL1HFXfiOHD2D0JJQ+2hiq5E4gwVt2dlA8gg9iA1RgBrB4cHxWexIfBy49m
 bRuQ2gb+YLahFJlT+Abxht01L+ubA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] Update ISAR revision
Date: Wed, 19 Oct 2022 15:43:51 +0200
Message-Id: <20221019134351.420472-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:44:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9791

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Update for downstream layers.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml          | 2 +-
 kas/opt/swupdate.yml | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 24062c5..10f4594 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 0daa55195f0f55465a367aec1ceeec5f26c161af
+    refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
     layers:
       meta:
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index b2bff64..f0d3f1b 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -24,3 +24,4 @@ local_conf_header:
     IMAGE_FSTYPES = "wic"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
+    WIC_DEPLOY_PARTITIONS = "1"
-- 
2.35.1


