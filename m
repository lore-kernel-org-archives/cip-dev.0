Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD93C433F5
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 10:54:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.5390.1637146470981156631
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 02:54:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1AHAsPYw003066;
 Wed, 17 Nov 2021 19:54:25 +0900
X-Iguazu-Qid: 2wGrVQwHH5oKmLtUGG
X-Iguazu-QSIG: v=2; s=0; t=1637146465; q=2wGrVQwHH5oKmLtUGG;
 m=+srcnEHCB3nefMnhEzTibKTlJ9PPPvSpS3zhkQMw620=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 1AHAsOnX024471
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Nov 2021 19:54:24 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 457B81000F8
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:24 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AHAsOUf008789
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:24 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/3] cip-core-image-security: remove unnecessary
 dependency package names
Date: Wed, 17 Nov 2021 16:24:35 +0530
X-TSB-HOP: ON
Message-Id: <20211117105437.4621-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
References: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Nov 2021 10:54:20.0840 (UTC)
 FILETIME=[79AE4280:01D7DBA1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 10:54:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6941

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

It is not necessary to mention the dependency package names in the recipe
because their names are changed when different distribution version
is used, and anyway the package manager will install the correct version
of dependencies when installing the main package, so it is safer to remove
the dependency packages here.

e.g:
 For the Package: nftables
 Dependecy package name in buster:   libnftables0
 Dependecy package name in bullseye: libnftables1

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 61ddc39..c613dc9 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -17,20 +17,20 @@ IMAGE_INSTALL += "security-customizations"
 
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
 	tpm2-abrmd \
-	libtss2-esys0 libtss2-udev \
+	libtss2-esys0 \
 	libpam-cracklib \
 	acl \
-	libauparse0 audispd-plugins auditd \
+	audispd-plugins auditd \
 	uuid-runtime \
 	sudo \
 "
-- 
2.20.1



