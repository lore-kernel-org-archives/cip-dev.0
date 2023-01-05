Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C049C3DA7D
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 15:02:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.14857.1672930969769405336
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 07:02:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 305F2lSB005494; Fri, 6 Jan 2023 00:02:47 +0900
X-Iguazu-Qid: 2wGqiQJF0hNCh3gloj
X-Iguazu-QSIG: v=2; s=0; t=1672930966; q=2wGqiQJF0hNCh3gloj; m=cRZIrqz6eF9DdHRCeW67CXBqse9zIBewhJSmPZmhuWU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 305F2jZT026260
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Jan 2023 00:02:46 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>, henning.schild@siemens.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security.yml: Add root user credentials in security kas file
Date: Thu,  5 Jan 2023 20:32:42 +0530
X-TSB-HOP2: ON
Message-Id: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jan 2023 15:02:43.0371 (UTC) FILETIME=[C34C87B0:01D92116]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 15:02:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10322

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Security image creation imposes a rule to have strong password in user
accounts and that should not affect the normal image user account
settings, so overwriting user account settings in security kas file as
required for security image.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/security.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 4e74a9c..c385a62 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -12,3 +12,9 @@ header:
   version: 12
 
 target: cip-core-image-security
+
+local_conf_header:
+  root_password: |
+    USERS += "root"
+    USER_root[password] = "Cipsecurity@123"
+    USER_root[flags] = "clear-text-password"
-- 
2.20.1



