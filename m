Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91725C71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 10:43:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.10515.1693219419449092380
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 03:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37SAhbT11559549; Mon, 28 Aug 2023 19:43:37 +0900
X-Iguazu-Qid: 2yAaansOw8X8FJiT4b
X-Iguazu-QSIG: v=2; s=0; t=1693219416; q=2yAaansOw8X8FJiT4b; m=9NIkVpLtTBVimP/rlqKb1zOQA/aL4DbFPFrk6YT/fK8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 37SAhaTp3690390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 19:43:36 +0900
From: tho1.nguyendat@toshiba.co.jp
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: tho1.nguyendat@toshiba.co.jp, kazuhiro3.hayashi@toshiba.co.jp
Subject: [PATCH 1/3] linux/cip-kernel-config: Use latest commit
Date: Mon, 28 Aug 2023 17:43:13 +0700
X-TSB-HOP2: ON
Message-Id: <20230828104315.466393-2-tho1.nguyendat@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
References: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 10:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12881

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index e104200..51b17c6 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "a28b7a678418287b12161975fe8b9b04a3cc8c88"
+SRCREV_cip-kernel-config ?= "aca5978b5abf93b20df4efda067c3a3f461476e0"
-- 
2.39.2



