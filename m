Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039AC433FE
	for <webhook@archiver.kernel.org>; Mon,  4 Oct 2021 13:27:18 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.9306.1633354037133830357
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 06:27:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 194DRE0v003773
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 15:27:14 +0200
Received: from md2dvrtc.fritz.box ([139.22.41.233])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194DRDNo019631;
	Mon, 4 Oct 2021 15:27:13 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
        jan.kiszka@siemens.com
Subject: [PATCH v2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and
 WKS_FILE
Date: Mon,  4 Oct 2021 15:27:13 +0200
Message-Id: <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
References: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Oct 2021 13:27:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6775

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Replace the default assignment to ensure the generation of the
swu file. As stated in [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

This fixes [2].

[1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
[2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 7d86ad5..bd0f6e4 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,5 +19,5 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate"
 
   wic-swu: |
-    IMAGE_TYPE ?= "wic-swu-img"
+    IMAGE_TYPE = "wic-swu-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.30.2


