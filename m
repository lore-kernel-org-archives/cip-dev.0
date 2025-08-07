Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A656C87FCA
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 09:19:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.47065.1754558368914354544
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Aug 2025 02:19:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5779JPYj2324862; Thu, 7 Aug 2025 18:19:26 +0900
X-Iguazu-Qid: 2rWhiV7hVbJINyiEYN
X-Iguazu-QSIG: v=2; s=0; t=1754558364; q=2rWhiV7hVbJINyiEYN; m=Ijfs39FCx7kYDAm6zJuizZz75oSgdXtsPE6yKF9SrQE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5779JNbI3313360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 18:19:24 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2] Remove credentials from console & document them in security README
Date: Thu,  7 Aug 2025 14:39:41 +0530
X-TSB-HOP2: ON
Message-Id: <20250807090941.3393503-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Aug 2025 09:19:21.0986 (UTC) FILETIME=[5C486620:01DC077C]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 09:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19707

Add the information about credentials and a note in the README for
CIP users about not to use the default credentails for production
images. Also, provide the reference to password policy document.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.security-testing.md                      | 13 +++++++++++++
 kas/opt/security.yml                                |  1 +
 recipes-core/security-customizations/files/postinst |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
index 213fc82..a33eecf 100644
--- a/doc/README.security-testing.md
+++ b/doc/README.security-testing.md
@@ -26,6 +26,19 @@ Save & Build
 host$ ./start-qemu.sh x86
 ```
 
+Login using the following credentials
+
+```
+username: root
+password: CIPsecurity@123
+```
+
+**Note**:
+
+The actual credentials are injected here [kas/opt/security.yml](kas/opt/security.yml). CIP users are strongly recommended not to use CIP default credentials for production images.
+
+Refer [password policy](https://gitlab.com/cip-project/cip-documents/-/blob/master/user/user_manual/user_manual.rst#password-policies) and set the password accordingly for production images. The actual password policy settings are defined in the `postinst` script of security-customizations [security-customizations/files/postinst](recipes-core/security-customizations/files/postinst)
+
 # Copy security tests in to the Linux image
 - Clone the cip-security-tests from following URL
 ```
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 8a875db..2ad53ea 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -16,6 +16,7 @@ header:
 
 target: cip-core-image-security
 
+# (Warning) CIP users are strongly recommended not to use CIP default credentials for production images.
 local_conf_header:
   root_password: |
     USERS += "root"
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
2.39.5



