Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A141CD6E4A
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 05:42:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18502.1780378963543676829
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2026 22:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6525geCb3820717; Tue, 2 Jun 2026 14:42:41 +0900
X-Iguazu-Qid: 2rWhEh6OXU8DADyF7b
X-Iguazu-QSIG: v=2; s=0; t=1780378960; q=2rWhEh6OXU8DADyF7b; m=LMpGtAxj4ZTH8Gtj3TkRYzGGpqzo0tH79u6ZT3jQ5yk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gV08v73QCz4vym; Tue,  2 Jun 2026 14:42:39 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor updates related to use cases and relevance to IEC 62443-4-2
Date: Tue,  2 Jun 2026 02:00:08 -0400
X-TSB-HOP2: ON
Message-Id: <20260602060009.50354-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jun 2026 05:42:37.0161 (UTC) FILETIME=[9E50D590:01DCF252]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jun 2026 05:42:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23038

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.factory-reset.md | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index aa8dd1c..419e32b 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -51,3 +51,12 @@ root@demo:~# reboot
 ```
 root@demo:~# find /var -name "to-be-deleted"
 ```
+
+## Use cases
+
+- The primary use case is resetting data partitions (e.g. `/home` and `/var`). This also resets any configuration changes made under `/etc`, since the read-write overlay for /etc is currently backed by /var.
+- If the `/etc` RW overlay is backed by a dedicated partition (separate from `/home` or `/var`), that partition can be formatted independently to restore default configurations (included at build time).
+
+## Relevance to IEC 62443-4-2
+
+- Factory reset feature helps meet requirements under CR 4.2 Information Persistance. Refer [here](https://gitlab.com/cip-project/cip-documents/-/blob/master/iec-62443-assessment/iec-62443-4-2/iec-62443-4-2-fr-4-fr-5.rst?ref_type=heads#id12) for more details on how the requirement is met.
-- 
2.39.5



