Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1CC19F2B
	for <webhook@archiver.kernel.org>; Mon,  1 Aug 2022 14:57:59 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.25855.1659365874026593894
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Aug 2022 07:57:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=BsxiGTgX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-202208011457518c3dec9b8097300360-izqsof@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202208011457518c3dec9b8097300360
        for <cip-dev@lists.cip-project.org>;
        Mon, 01 Aug 2022 16:57:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=u/oX2Ba++mClQoQU9xeVOKKaSL6adWFBNG1IwjkL3B0=;
 b=BsxiGTgXqxz4iYlKCHtY3lH5wQbr8yhrv6IMBm5SdUR8JkC/NQz1VXdeQSzdHnOBc4ZNZ9
 B0j7WMMTBOWuvZkl0+k9VLWl7zWRT+1T0mXQmFNtFVgdCrCdL6NDwWf55bFOqOB0LsYp2YVl
 Xofw41+6Aonj1YMfxKl1mh2HxFBmk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/2] kas/opt/swupdate: Move the package
 installation to swupdate.inc
Date: Mon,  1 Aug 2022 16:57:49 +0200
Message-Id: <20220801145749.42714-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
References: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Aug 2022 14:57:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8991

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


