Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A4CE7B01
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 06:44:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.8328.1695883483493718426
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 23:44:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38S6ifnV228607; Thu, 28 Sep 2023 15:44:41 +0900
X-Iguazu-Qid: 2rWhdxlJInFGQGIh6m
X-Iguazu-QSIG: v=2; s=0; t=1695883481; q=2rWhdxlJInFGQGIh6m; m=E9xdVMxhj4ehQp8IC0e3jU5NRobxXK0gqHUJiORN7Ew=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 38S6idHr857559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 Sep 2023 15:44:40 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 2/2] distro: Set dosfstools as build dependency
Date: Thu, 28 Sep 2023 12:14:37 +0530
X-TSB-HOP2: ON
Message-Id: <20230928064437.12654-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1788B037A0B186C6.25332@lists.cip-project.org>
References: <1788B037A0B186C6.25332@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2023 06:44:36.0401 (UTC) FILETIME=[3F285210:01D9F1D7]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 06:44:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13242

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

custom dosfstools is included with fix that will help create DOS images
reproducibly.

This is excluded for buster because the patch cannot be applied and
also reproducible build is not important in buster.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 conf/distro/cip-core-common.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 5d3ce10..3ae2a3e 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -14,3 +14,6 @@ KERNEL_NAME ?= "cip"
 WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
+
+IMAGER_BUILD_DEPS ?= "dosfstools"
+IMAGER_BUILD_DEPS:remove:buster = "dosfstools"
-- 
2.20.1



