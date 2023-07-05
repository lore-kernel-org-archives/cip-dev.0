Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C1BC0015E
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 06:16:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.10970.1688537779711618345
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 23:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3656GHVO1922199; Wed, 5 Jul 2023 15:16:17 +0900
X-Iguazu-Qid: 2rWhc6jYw81G04Tzwh
X-Iguazu-QSIG: v=2; s=0; t=1688537777; q=2rWhc6jYw81G04Tzwh; m=xQYc2/s1hgoM6vULbzADpK+UYHwomDZYYG1Ot371azY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3656GGbb817114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jul 2023 15:16:16 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] kas/opt/security.yml : Change password to fit pam_passwdqc policy
Date: Wed,  5 Jul 2023 11:46:11 +0530
X-TSB-HOP2: ON
Message-Id: <20230705061611.20080-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230705061611.20080-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230705061611.20080-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 06:16:13.0995 (UTC) FILETIME=[335507B0:01D9AF08]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 06:16:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12222

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Since we using pam_passwdqc from bookworm, our current security image login password
does not meet the requirements based on the below given pam_passwdqc policy.

When calculating the number of character classes, upper-case letters used as the
first character and digits used as the last character of a password are not counted.
This makes our password to have only 3 character classes. Hence we are adding multiple
capital characters to make the total number of character classes as 4.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 kas/opt/security.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 4d11905..1f3745b 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -16,7 +16,7 @@ target: cip-core-image-security
 local_conf_header:
   root_password: |
     USERS += "root"
-    USER_root[password] = "Cipsecurity@123"
+    USER_root[password] = "CIPsecurity@123"
     USER_root[flags] = "clear-text-password"
   adjust-swupdate: |
     ABROOTFS_IMAGE_RECIPE = "cip-core-image-security"
-- 
2.20.1



