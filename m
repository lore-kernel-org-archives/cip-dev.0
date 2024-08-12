Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26997C531DC
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:17:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.43895.1723461434418525033
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 47CBHDXX1461659; Mon, 12 Aug 2024 20:17:13 +0900
X-Iguazu-Qid: 2yAacTOYDDL6ePuOie
X-Iguazu-QSIG: v=2; s=0; t=1723461432; q=2yAacTOYDDL6ePuOie; m=ZFzDWWQLJ9c4jp2cpynXaIm69sebGMGWz3MvFTkNR3o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 47CBHBXa907480
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 20:17:12 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/3] .gitlab-ci.yml: Update debian-cve-checker image reference
Date: Mon, 12 Aug 2024 16:46:05 +0530
X-TSB-HOP2: ON
Message-Id: <20240812111605.1246549-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 11:17:08.0972 (UTC) FILETIME=[2BD2E2C0:01DAECA9]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:17:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16777

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This commit updates image reference of debian-cve-checker project.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ab1835a..bc98ec9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -456,7 +456,7 @@ test:qemu-arm-IEC:
 cve-checks:
   stage: cve-check
   needs: []
-  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
   tags:
     - small
   script:
-- 
2.30.2



