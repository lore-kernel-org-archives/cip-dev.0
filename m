Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A7CFD370
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 03:54:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9754.1764042891530126497
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 19:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5AP3smbu3623664; Tue, 25 Nov 2025 12:54:49 +0900
X-Iguazu-Qid: 2rWgiXlvbpCzqePUbX
X-Iguazu-QSIG: v=2; s=0; t=1764042888; q=2rWgiXlvbpCzqePUbX; m=QlZoMgF+lfaaM6hyLZaV9mLe+rrl8uRdMxFnIHlTfZg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dFpjh2ktbz4vys; Tue, 25 Nov 2025 12:54:47 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1] Add factory-reset-helper to security image as well
Date: Mon, 24 Nov 2025 23:07:54 -0500
X-TSB-HOP2: ON
Message-Id: <20251125040754.1006136-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Nov 2025 03:54:45.0704 (UTC) FILETIME=[3CF41C80:01DC5DBF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 03:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20721

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently, the factory-reset-helper package is conditionally appended to
IMAGE_INSTALL only in cip-core-image.bb

But the security image uses cip-core-image-security.bb as the top-level
image recipe and therefore does not include the factory-reset-helper package.

Let's move appending factory-reset-helper to IMAGE_INSTALL to a common place
so that its also available to the security image.

Closes #141

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image.bb  | 2 --
 recipes-core/images/cip-core-image.inc | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 52dd180..4a9cea9 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -15,7 +15,5 @@ DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
-IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
-
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/cip-core-image.inc
index 7b0f7b0..f6162cd 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -11,4 +11,6 @@
 
 inherit image
 
+IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
+
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
-- 
2.39.5



