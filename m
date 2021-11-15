Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6545C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:16:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.24679.1636992981767194135
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1AFGGHor013054;
 Tue, 16 Nov 2021 01:16:17 +0900
X-Iguazu-Qid: 34tKOM77SxLipHhol1
X-Iguazu-QSIG: v=2; s=0; t=1636992977; q=34tKOM77SxLipHhol1;
 m=t6DiGzzLEBULTEaJHtt4MEOAlTl7jYLim18T7eUmKX8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 1AFGGGF3028977
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Nov 2021 01:16:16 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D86711000B5
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 01:15:37 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AFGFb6D025265
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 01:15:37 +0900
From: venkata.pyla@toshiba-tsip.com
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>
Subject: [PATCH] cip-core-image-security: remove unnecessary dependency
 package names
Date: Mon, 15 Nov 2021 21:45:54 +0530
X-TSB-HOP: ON
Message-Id: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Nov 2021 16:15:35.0934 (UTC)
 FILETIME=[05B4B1E0:01D7DA3C]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:16:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6902

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

It is not necessary to mention dependency package names when parent
package is present, the dependency packages will automatically
install by isar framework.

so removing the dependency packages which are not necessary.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 61ddc39..6c41b00 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -17,12 +17,12 @@ IMAGE_INSTALL += "security-customizations"
 
 # Debian packages that provide security features
 IMAGE_PREINSTALL += " \
-	openssl libssl1.1 \
+	openssl \
 	fail2ban \
 	openssh-server openssh-sftp-server openssh-client \
 	syslog-ng-core syslog-ng-mod-journal \
-	aide aide-common \
-	libnftables0 nftables \
+	aide \
+	nftables \
 	libpam-pkcs11 \
 	chrony \
 	tpm2-tools \
@@ -30,7 +30,7 @@ IMAGE_PREINSTALL += " \
 	libtss2-esys0 libtss2-udev \
 	libpam-cracklib \
 	acl \
-	libauparse0 audispd-plugins auditd \
+	audispd-plugins auditd \
 	uuid-runtime \
 	sudo \
 "
-- 
2.20.1



