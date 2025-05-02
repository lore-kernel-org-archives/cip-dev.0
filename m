Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891FDC3ABA5
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 05:24:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.12972.1746163485779955977
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 May 2025 22:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5425Ohtj1664470; Fri, 2 May 2025 14:24:44 +0900
X-Iguazu-Qid: 2yAbaKzOi3OYSDTHO9
X-Iguazu-QSIG: v=2; s=0; t=1746163482; q=2yAbaKzOi3OYSDTHO9; m=E7ImDwovpFbMPAUv5wo6sDP3J77KEvBPN8sToG7Zo5U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 5425Ofvg1700360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 14:24:42 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1] README.security-testing.md: Remove the credentials from console & document them
Date: Fri,  2 May 2025 10:50:34 +0530
X-TSB-HOP2: ON
Message-Id: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 May 2025 05:24:39.0227 (UTC) FILETIME=[803C28B0:01DBBB22]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 05:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18747

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

The IEC 62443-4-2 certification body insists on removing the login credentials
from console prior login prompt and document them as part of user manual.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 doc/README.security-testing.md                      | 7 +++++++
 recipes-core/security-customizations/files/postinst | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
index 213fc82..9696892 100644
--- a/doc/README.security-testing.md
+++ b/doc/README.security-testing.md
@@ -25,6 +25,13 @@ Save & Build
 ```
 host$ ./start-qemu.sh x86
 ```
+# Login using the following credentials
+```
+username: root
+password: CIPsecurity@123
+```
+IEC 62443-4-2 certification body expects to remove the credentials from being displayed on the console prior login stage.
+(Warning) CIP users are strongly recommended not to use CIP default credentials for production images.
 
 # Copy security tests in to the Linux image
 - Clone the cip-security-tests from following URL
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index daade83..15be659 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -6,7 +6,7 @@
 
 set -e
 
-echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issue
+echo "CIP Core Security Image" > /etc/issue
 
 # CR1.7: Strength of password-based authentication
 # Pam configuration to  enforce password strength
-- 
2.30.2



