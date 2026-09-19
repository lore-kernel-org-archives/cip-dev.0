Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6941C982CC
	for <webhook@archiver.kernel.org>; Sat, 19 Sep 2026 11:08:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10542.1789816089361915929
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Sep 2026 04:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 68JB872i3866669; Sat, 19 Sep 2026 20:08:07 +0900
X-Iguazu-Qid: 2yAaMsnyJJMCPV23LU
X-Iguazu-QSIG: v=2; s=1; t=1789816086; q=2yAaMsnyJJMCPV23LU; m=eYUDpueboL7wU3g1VueSXMXpc3jY1S90jWROJlt0FMs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hn6D655WXz1xnZ; Sat, 19 Sep 2026 20:08:06 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v2] Fix file timestamps are not reproducible for EFI certificates
Date: Sat, 19 Sep 2026 16:23:55 +0530
X-TSB-HOP2: ON
Message-Id: <20260919105355.826423-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Sep 2026 11:08:04.0896 (UTC) FILETIME=[24C77A00:01DD4827]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Sep 2026 11:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24245

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
index 263f794..1c8220b 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -35,7 +35,7 @@ EOF
 
 override_dh_auto_build:
 	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
-	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
+	sign-efi-sig-list -t ${DEBIAN_CHANGELOG_TIMESTAMP} -k /usr/share/secure-boot-secrets/secure-boot.key \
 	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
 	cp PK.auth KEK.auth
 	cp PK.auth db.auth
-- 
2.39.5



