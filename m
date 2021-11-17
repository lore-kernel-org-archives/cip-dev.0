Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9200C433FE
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 10:54:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.5549.1637146469709209777
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 02:54:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1AHAsRY1003106;
 Wed, 17 Nov 2021 19:54:27 +0900
X-Iguazu-Qid: 2wGqpPIUzJ97bIugHx
X-Iguazu-QSIG: v=2; s=0; t=1637146466; q=2wGqpPIUzJ97bIugHx;
 m=SvTzEuOib3bFba22DUyHsM02y342YsuwFWlgx1HQqV4=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 1AHAsPhV017876
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Nov 2021 19:54:26 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id DE3141000F1
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:25 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AHAsPGA008811
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 19:54:25 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/3] Kconfig: Enable Security extensions for
 bullseye image
Date: Wed, 17 Nov 2021 16:24:37 +0530
X-TSB-HOP: ON
Message-Id: <20211117105437.4621-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
References: <16B7FCBA2ADC61EA.22891@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Nov 2021 10:54:21.0043 (UTC)
 FILETIME=[79CD3C30:01D7DBA1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 10:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6940

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 8421f1b..3b882d6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -115,7 +115,6 @@ config KAS_INCLUDE_IMAGE_FORMAT
 
 config IMAGE_SECURITY
 	bool "Security extensions"
-	depends on DEBIAN_BUSTER
 
 config KAS_INCLUDE_SECURITY
 	string
-- 
2.20.1



