Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB3CEBF88
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 04:38:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1284.1765168679076204189
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Dec 2025 20:38:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5B84bu3u2675319; Mon, 8 Dec 2025 13:37:56 +0900
X-Iguazu-Qid: 2yAaYMbri9tSXYghCz
X-Iguazu-QSIG: v=2; s=0; t=1765168676; q=2yAaYMbri9tSXYghCz; m=zxpIK3CdlPNKoAUJXm7DSbp70ZpgSElDhZ83/mDKpCo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dPq3S1WY3zyPc; Mon,  8 Dec 2025 13:37:55 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1] .gitlab-ci.yml: Enable deployment for qemu-amd64-bookworm
Date: Sun,  7 Dec 2025 23:51:41 -0500
X-TSB-HOP2: ON
Message-Id: <20251208045141.4092733-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Dec 2025 04:37:53.0981 (UTC) FILETIME=[6B0E96D0:01DC67FC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Dec 2025 04:38:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20955

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Commit 7dc56da3 introduced a qemu-amd64-bookworm target for running
IEC tests but failed to enable deployment for the target.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fa372e0..2714a37 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -294,6 +294,7 @@ build:qemu-amd64-bookworm:
     security_test: enable
     use_rt: disable
     release: bookworm
+    deploy: enable
 
 build:iwg20m-bookworm-test:
   extends:
-- 
2.39.5



