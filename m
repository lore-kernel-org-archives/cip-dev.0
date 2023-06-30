Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A37C0015E
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 11:35:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.9659.1688124904265152620
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jun 2023 04:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 35UBZ2Hj224983; Fri, 30 Jun 2023 20:35:02 +0900
X-Iguazu-Qid: 2yAb9zVTf4UN8Gfir4
X-Iguazu-QSIG: v=2; s=0; t=1688124901; q=2yAb9zVTf4UN8Gfir4; m=cNNF34c2dly6oMq2350lGmtibLwXDYo5lANdOdwMrH8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 35UBZ09j2733783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 30 Jun 2023 20:35:01 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security-customizations: Fix broken sshd_config in bookworm
Date: Fri, 30 Jun 2023 17:04:58 +0530
X-TSB-HOP2: ON
Message-Id: <20230630113458.8610-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jun 2023 11:34:59.0559 (UTC) FILETIME=[E6FDBF70:01D9AB46]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jun 2023 11:35:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12162

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

ChallengeResponseAuthentication configuration is sshd_config is deprecated from
bookworm, so modify the configuration setting based on its availability.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/security-customizations/files/postinst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 recipes-core/security-customizations/files/postinst

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
old mode 100644
new mode 100755
index d370345..4438776
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -82,5 +82,11 @@ if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
 fi
 echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
 # Enable PAM configuration for Remote Session
-sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
+if grep -s -q "ChallengeResponseAuthentication" "${SSHD_CONFIG}";then
+       sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
+fi
+
+if grep -s -q "KbdInteractiveAuthentication" "${SSHD_CONFIG}";then
+       sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/g' "${SSHD_CONFIG}"
+fi
 echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"
-- 
2.20.1



