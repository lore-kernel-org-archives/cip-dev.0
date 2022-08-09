Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A5C25B07
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 10:41:07 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.10133.1660041663839658418
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Aug 2022 03:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=R+lcC2s1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-2022080910410129cf781694920235b1-piia8i@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022080910410129cf781694920235b1
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Aug 2022 12:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=u/oX2Ba++mClQoQU9xeVOKKaSL6adWFBNG1IwjkL3B0=;
 b=R+lcC2s158cfAf0eTbvxC9jTzW0LwWtVm3FUebBSYODfTXFwhhG0pOw2zNMPlY1ZjZgvjG
 BNfuKqh8K6/mPAofTxy+bdqLPlGn9oVGlrCNGzMsMLDMTmla+E27NVJ5vRQgcJNQ/OP8LTDj
 9sfOObJUbmE+WrQny2zy/WU1Qxl40=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 2/3] kas/opt/swupdate: Move the
 package installation to swupdate.inc
Date: Tue,  9 Aug 2022 12:40:59 +0200
Message-Id: <20220809104100.469265-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
References: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 10:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9145

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml             | 4 ----
 recipes-core/images/swupdate.inc | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

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


