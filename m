Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B6C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:00:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.21354.1702558817904976896
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3BED0FdZ2126571; Thu, 14 Dec 2023 22:00:16 +0900
X-Iguazu-Qid: 2rWgTXl344SyMBizhI
X-Iguazu-QSIG: v=2; s=0; t=1702558815; q=2rWgTXl344SyMBizhI; m=lH7SkXyhDeJTyjoXAzaMLoCgyOmC1o2NZ0nqExgM1KM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3BED0E0q960316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Dec 2023 22:00:15 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] distro: fix dosfstools-native is not applied to security target
Date: Thu, 14 Dec 2023 18:30:12 +0530
X-TSB-HOP2: ON
Message-Id: <20231214130012.16994-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Dec 2023 13:00:12.0798 (UTC) FILETIME=[79B459E0:01DA2E8D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:00:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14096

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

'dosfstools-native' is required for vfat images to build reproducibly,
this value is assigned to `IMAGER_BUILD_DEPS` as a default value, but when
other local configurations defines some value to it then the default
value is skipped, so modifed to append the value instead of setting as a
default.

Fixes: #85

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 conf/distro/cip-core-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index fb5b98d..dfee24a 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -15,5 +15,5 @@ WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
 
-IMAGER_BUILD_DEPS ?= "dosfstools-native"
+IMAGER_BUILD_DEPS:append = " dosfstools-native"
 IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
-- 
2.20.1



