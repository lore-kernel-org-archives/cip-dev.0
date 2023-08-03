Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A2C0015E
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 10:24:17 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.11068.1691058246405879033
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 03:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=XHRkxF63;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230803102402686f19d2185e652e66-es7ifu@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230803102402686f19d2185e652e66
        for <cip-dev@lists.cip-project.org>;
        Thu, 03 Aug 2023 12:24:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ocEVLyVOQVmGey/F7LDpb1XpS7kkODys5030FahXly4=;
 b=XHRkxF63sBdMTDfWRcxj2z4JOyIqq+K/vuz5maNSEJKdOuDPk0+PANkJFjZoJAja4AptmI
 LkB/i2fNY5ngta2ZSKzgNwWPkxLv9NEkG+lPnyFH+ETWja9jE6gL+4qm2Ketnnalm23NWN/4
 GX03EGItHMY6/KXqm/PFXuEj3VXew=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC] swupdate-handler: Add default config to fix u-boot build
Date: Thu,  3 Aug 2023 12:24:01 +0200
Message-Id: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 10:24:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12545

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the missing configuration file to allow to build with u-boot
as the boot selector.

It uses the getroot mechanism from SWUpdate to select the update
partition.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
CC: felix.moessbauer@siemens.com
TO: jan.kiszka@siemens.com

 .../files/swupdate.handler.u-boot.ini                  | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini

diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
new file mode 100644
index 0000000..0e6df08
--- /dev/null
+++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
@@ -0,0 +1,10 @@
+[image]
+chainhandler=raw
+
+[image.selector]
+method=getroot_rrmap
+[kernel]
+chainhandler=rawfile
+
+[kernel.selector]
+method=getroot_rrmap
-- 
2.40.1


