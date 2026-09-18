Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24157C982D7
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 09:04:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6953.1789722286334384417
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 02:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 68I94iqM2024664; Fri, 18 Sep 2026 18:04:44 +0900
X-Iguazu-Qid: 2yAa5wMLqDWhe0tjgR
X-Iguazu-QSIG: v=2; s=1; t=1789722284; q=2yAa5wMLqDWhe0tjgR; m=UbC7N9xKT0ghY4xUTfUTaxRNC8Q7Fz9a46H2zIwhtgk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmRXD1dlWz1xnZ; Fri, 18 Sep 2026 18:04:44 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH] Fix file timestamps are not reproducible for EFI certificates
Date: Fri, 18 Sep 2026 14:20:31 +0530
X-TSB-HOP2: ON
Message-Id: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Sep 2026 09:04:39.0737 (UTC) FILETIME=[BC8C2290:01DD474C]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 09:04:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24239

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
index 263f794..6a5357d 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -24,6 +24,12 @@ DPKG_ARCH = "all"
 
 do_prepare_build() {
     deb_debianize
+    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
+        timestamp="$(TZ=UTC date -d @${SOURCE_DATE_EPOCH} '+%Y-%m-%d %H:%M:%S')"
+        timestamp_opt="-t \"$timestamp\""
+    else
+        timestamp_opt=""
+    fi
 
     cat <<EOF > ${S}/debian/${BPN}.install
 db.auth usr/share/secure-boot-efi-certs
@@ -35,7 +41,7 @@ EOF
 
 override_dh_auto_build:
 	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
-	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
+	sign-efi-sig-list ${timestamp_opt} -k /usr/share/secure-boot-secrets/secure-boot.key \
 	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
 	cp PK.auth KEK.auth
 	cp PK.auth db.auth
-- 
2.39.5



