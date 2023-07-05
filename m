Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E80C001DD
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 07:34:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.11642.1688542447551139200
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 00:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3657Y4Op2239421; Wed, 5 Jul 2023 16:34:05 +0900
X-Iguazu-Qid: 2rWh1qS7zaRVybj5oh
X-Iguazu-QSIG: v=2; s=0; t=1688542444; q=2rWh1qS7zaRVybj5oh; m=bg2SLAHHL/uxF5EsY1IGxTinWavHj6Zecd1ASkJ3A6A=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 3657Y3LP1004383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jul 2023 16:34:04 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/2] kas/opt/security.yml : Change password to fit pam_passwdqc policy
Date: Wed,  5 Jul 2023 13:03:57 +0530
X-TSB-HOP2: ON
Message-Id: <20230705073358.16663-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 07:34:00.0642 (UTC) FILETIME=[10DEDA20:01D9AF13]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 07:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12226

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Since we using pam_passwdqc from bookworm, our current security image login password
does not meet the requirements based on the below given pam_passwdqc policy.

When calculating the number of character classes, upper-case letters used as the
first character and digits used as the last character of a password are not counted.
This makes our password to have only 3 character classes. Hence we are adding multiple
capital characters to make the total number of character classes as 4.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 kas/opt/security.yml                                | 2 +-
 recipes-core/security-customizations/files/postinst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 77a2713..f7dd18c 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -6,7 +6,7 @@
 
 set -e
 
-echo "CIP Core Security Image (login: root/Cipsecurity@123)" > /etc/issue
+echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issue
 
 HOSTNAME=demo
 echo "$HOSTNAME" > /etc/hostname
-- 
2.20.1



