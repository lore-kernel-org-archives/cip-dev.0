Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29EFE7E650
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 16:40:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.24065.1695746429195793576
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 09:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38QGeQEQ3317421; Wed, 27 Sep 2023 01:40:26 +0900
X-Iguazu-Qid: 2rWgSWj5NcSNtvgGRM
X-Iguazu-QSIG: v=2; s=0; t=1695746425; q=2rWgSWj5NcSNtvgGRM; m=yG4J2LZlXEq7hixU84BaSsdtRA2F3lzbf7DqcRp+lGo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 38QGeOHg1876922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Sep 2023 01:40:25 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 2/2] conf/distro/cip-core-common.inc: Set dosfstools as build dependency
Date: Tue, 26 Sep 2023 22:10:21 +0530
X-TSB-HOP2: ON
Message-Id: <20230926164021.30185-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
References: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Sep 2023 16:40:20.0720 (UTC) FILETIME=[239B0F00:01D9F098]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 16:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13233

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

custom dosfstools is included with fix that will help create DOS images
reproducibly.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 conf/distro/cip-core-common.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 5d3ce10..5a158f2 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -14,3 +14,4 @@ KERNEL_NAME ?= "cip"
 WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
+IMAGER_BUILD_DEPS ?= "dosfstools"
-- 
2.20.1



