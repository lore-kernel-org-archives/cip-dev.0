Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B8CC001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 04:20:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.10298.1691641205516837428
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Aug 2023 21:20:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37A4K2eD1726847; Thu, 10 Aug 2023 13:20:02 +0900
X-Iguazu-Qid: 2rWhc6jYx74CMRya1g
X-Iguazu-QSIG: v=2; s=0; t=1691641201; q=2rWhc6jYx74CMRya1g; m=sFuryNhpY0aO9n5x2zqhcbo1gU12gru/IzgmKHNpd84=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 37A4K0ab2912157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Aug 2023 13:20:01 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core] recipes-core: ltp: Update LTP to 20230516
Date: Thu, 10 Aug 2023 13:19:48 +0900
X-TSB-HOP2: ON
Message-Id: <20230810041948.814121-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 04:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12587

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/ltp/{ltp-full_20220527.bb => ltp-full_20230516.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20220527.bb => ltp-full_20230516.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20220527.bb b/recipes-core/ltp/ltp-full_20230516.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20220527.bb
rename to recipes-core/ltp/ltp-full_20230516.bb
index a99f301..943340f 100644
--- a/recipes-core/ltp/ltp-full_20220527.bb
+++ b/recipes-core/ltp/ltp-full_20230516.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "d635afb5ec7b0de763ab50713baf9fbf65cf089da6e6768f816e4a166cbd17c4"
+SRC_URI[sha256sum] = "d78f4bdd5bdc9e91357631954affba7e66190a2509c369b59f55efd190268956"
-- 
2.40.1



