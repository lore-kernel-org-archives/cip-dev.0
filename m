Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7154DC433F5
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:53 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.754.1632854992362917609
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 18SInnQK007496
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:50 +0200
Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmgx026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change
 assignment of IMAGE_TYPE and WKS_FILE
Date: Tue, 28 Sep 2021 20:49:47 +0200
Message-Id: <20210928184948.737071-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Sep 2021 18:49:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6757

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Replace the default assignment to ensure the generation of the
swu file. As stated in [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

This fixes [2].

[1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
[2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 7d86ad5..3cc02a3 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,5 +19,5 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate"
 
   wic-swu: |
-    IMAGE_TYPE ?= "wic-swu-img"
-    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
+    IMAGE_TYPE = "wic-swu-img"
+    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.30.2


