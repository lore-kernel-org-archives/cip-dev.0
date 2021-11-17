Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD721C433EF
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 10:54:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.5544.1637146468186162048
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 02:54:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1AHAsQRU026002;
 Wed, 17 Nov 2021 19:54:26 +0900
X-Iguazu-Qid: 34tMdwO15XwLcN0Qdt
X-Iguazu-QSIG: v=2; s=0; t=1637146465; q=34tMdwO15XwLcN0Qdt;
 m=Pezu3WPSrTNlpcgO8paq1qQCyBvnA2LpdsuWItKAiJs=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 1AHAsOFO003599
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Nov 2021 19:54:25 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id C0211100088
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:24 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AHAsOrn008800
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:24 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/3] cip-core-image-security: Install packages
 based on DISTRO version
Date: Wed, 17 Nov 2021 16:24:36 +0530
X-TSB-HOP: ON
Message-Id: <20211117105437.4621-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
References: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Nov 2021 10:54:20.0949 (UTC)
 FILETIME=[79BEE450:01D7DBA1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 10:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6939

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Package names like below have different names in different DISTRO versions
and those packages should be installed based on the Distro version is
selected.

Package name in Buster:   libtss2-esys0
Package name in Bullseye: libtss2-esys-3.0.2-0

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index c613dc9..3ea544a 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -27,10 +27,15 @@ IMAGE_PREINSTALL += " \
 	chrony \
 	tpm2-tools \
 	tpm2-abrmd \
-	libtss2-esys0 \
 	libpam-cracklib \
 	acl \
 	audispd-plugins auditd \
 	uuid-runtime \
 	sudo \
 "
+
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+
+# Package names based on the distro version
+IMAGE_PREINSTALL_append_buster = " libtss2-esys0"
+IMAGE_PREINSTALL_append_bullseye = " libtss2-esys-3.0.2-0"
-- 
2.20.1



